import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.element.querySelectorAll('turbo-frame')[0].hidden = false
  }

  get form() {
    return this.element.querySelector('form')
  }

  frame(event) {
    return event.target.closest('turbo-frame')
  }

  hide(event) {
    this.frame(event).hidden = true
  }

  hideWithValid(event) {
    const fields = this.frame(event).querySelectorAll('input,select')
    const isValid = Array.from(fields).every((field) => {
      return field.reportValidity()
    })

    if (isValid) {
      this.hide(event)
      this.form.action = this.frame(event).dataset.formaction
    } else {
      event.preventDefault()
    }
  }

  hideWithInput(event) {
    this.hide(event)
    this.form.action = this.frame(event).dataset.formaction
    this.form.noValidate = true
    this.form.requestSubmit()
    this.form.noValidate = false
  }
}
