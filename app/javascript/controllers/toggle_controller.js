import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets =  ["content"]
  toggleVisibility() {
    this.contentTarget.classList.toggle("hidden")
  }
}
