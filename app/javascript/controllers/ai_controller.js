import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "output"]
  static values = { url: String }

  connect() {
    // Debounce timer
    this.timeout = null
  }

  suggest() {
    // Clear previous timer
    clearTimeout(this.timeout)

    // Wait 800ms after user stops typing
    this.timeout = setTimeout(() => {
      const title = this.inputTarget.value
      if (title.length < 5) return // Don't suggest for short words

      fetch('/ai/suggest', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({ title: title })
      })
      .then(response => response.json())
      .then(data => {
        if (data.description) {
          this.outputTarget.value = data.description
          // Optional: Flash the textarea to show it updated
          this.outputTarget.classList.add("bg-yellow-50")
          setTimeout(() => this.outputTarget.classList.remove("bg-yellow-50"), 500)
        }
      })
      .catch(error => console.error('Error:', error))
    }, 800)
  }
}