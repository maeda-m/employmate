import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.element.querySelectorAll('turbo-frame')[0].hidden = false
  }

  hide(event) {
    document.querySelector(`#${event.target.dataset.frameId}`).hidden = true
  }
}
