import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  confirm(event) {
    const button = event.target
    const message = button.dataset.turboConfirm
    if (window.confirm(message) === false) {
      event.preventDefault()
    }
  }
}
