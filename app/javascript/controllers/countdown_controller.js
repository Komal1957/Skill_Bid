import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { deadline: String }

  connect() {
    this.updateTimer()
    // Update every 1 second
    this.interval = setInterval(() => this.updateTimer(), 1000)
  }

  disconnect() {
    clearInterval(this.interval)
  }

  updateTimer() {
    const deadline = new Date(this.deadlineValue).getTime()
    const now = new Date().getTime()
    const distance = deadline - now

    if (distance < 0) {
      this.element.innerHTML = "Auction Ended"
      clearInterval(this.interval)
      return
    }

    const days = Math.floor(distance / (1000 * 60 * 60 * 24))
    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
    const seconds = Math.floor((distance % (1000 * 60)) / 1000)

    this.element.innerHTML = `${days}d ${hours}h ${minutes}m ${seconds}s`
  }
}