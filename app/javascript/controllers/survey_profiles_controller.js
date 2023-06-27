import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    const boundSubmitWithButtonDisable = this.submitWithButtonDisable.bind(this)
    const noValidateButtonSelector =
      '.visit-start-page,.show-prev-question,.show-user-profile'
    this.element
      .querySelectorAll(noValidateButtonSelector)
      .forEach((button) => {
        button.addEventListener('click', (event) => {
          event.preventDefault()
          boundSubmitWithButtonDisable(event)
        })
      })
  }

  frame(event) {
    return event.target.closest('turbo-frame')
  }

  showNextQuestionWithCurrentQuestionValid(event) {
    if (this.frame(event).hidden) {
      // Note: Enter キー押下でのフォーム送信（非表示の1問目の次へボタン経由）を拒否する
      // See: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#implicit-submission
      return
    }

    const fields = this.frame(event).querySelectorAll('input,select')
    const isValid = Array.from(fields).every((field) => {
      return field.reportValidity()
    })

    if (isValid) {
      this.submitWithButtonDisable(event)
    }
  }

  submitWithButtonDisable(event) {
    this.withDisable()
    const submitter = event.target.closest('button') || event.target
    submitter.form.requestSubmit(submitter)
  }

  withDisable() {
    this.setDisabled(true)
  }

  withoutDisable() {
    this.setDisabled(false)
  }

  setDisabled(value) {
    // NOTE: requestSubmit する button や turbo: false な submit は disable_with が効かない
    //       また submitter に disabled を付与するとフォーム送信自体が止まる
    // See: https://github.com/hotwired/turbo/pull/386
    const buttons = this.element.querySelectorAll('button,input[type="submit"]')
    buttons.forEach((button) => {
      button.disabled = value
    })
  }
}
