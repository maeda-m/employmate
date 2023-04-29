import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.originFormAction = this.form.action
    this.originFormValidate = this.form.noValidate
    this.form.querySelectorAll('turbo-frame')[0].hidden = false
  }

  get form() {
    return this.element
  }

  restoreOriginFormAction() {
    this.form.action = this.originFormAction
    this.form.noValidate = this.originFormValidate
  }

  frame(event) {
    return event.target.closest('turbo-frame')
  }

  showNextQuestionAction(event) {
    return this.frame(event).dataset.formaction
  }

  showNextQuestionWithCurrentQuestionValid(event) {
    const fields = this.frame(event).querySelectorAll('input,select')
    const isValid = Array.from(fields).every((field) => {
      return field.reportValidity()
    })

    if (isValid) {
      this.showNextQuestionWithoutCurrentQuestionValid(event)
    }
  }

  showNextQuestionWithoutCurrentQuestionValid(event) {
    this.form.action = this.showNextQuestionAction(event)
    this.form.noValidate = true
    this.form.requestSubmit()
  }
}
