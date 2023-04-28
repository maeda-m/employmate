import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.element.querySelectorAll('turbo-frame')[0].hidden = false
  }

  get form() {
    return this.element.querySelector('form')
  }

  frame(event) {
    return document.querySelector(`#${event.target.dataset.frameId}`)
  }

  hide(event) {
    this.frame(event).hidden = true
  }

  hideWithValid(event) {
    const fields = this.frame(event).querySelectorAll('input,select')
    const isValid = Array.from(fields).every((field) => {
      return field.validity.valid
    })

    if (isValid) {
      this.hide(event)
    } else {
      this.form.reportValidity()
      event.preventDefault()
    }
  }
}
