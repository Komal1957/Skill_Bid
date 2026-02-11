import { Controller } from "@hotwired/stimulus"
import { loadStripe } from "@stripe/stripe-js"

// Put your publishable key here or grab it from a meta tag in layout
const stripe = loadStripe('pk_test_51Sz97mQiMEfmAjW87svuwR92NXfZUEgENWA6uVgZy03fDLQjkYtwm5gPU2mYrWvr3VpBCiMlKBZcniKs7t5PXPGN00gxEVGaMZ');

export default class extends Controller {
  static values = { url: String }

  async checkout() {
    const response = await fetch(this.urlValue, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content }
    });
    
    const session = await response.json();
    
    if (session.error) {
      alert(session.error);
    } else {
      stripe.then(stripe => {
        stripe.redirectToCheckout({ sessionId: session.id });
      });
    }
  }
}