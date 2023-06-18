import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    confirm: String,
  }

  confirm(event) {
    if (window.confirm(this.confirmValue) === false) {
      event.preventDefault()
    }
  }
}
