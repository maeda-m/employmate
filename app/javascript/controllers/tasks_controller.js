import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form']

  done() {
    this.formTarget.requestSubmit()
  }

  survey() {
    /* global Turbo */
    Turbo.visit(this.formTarget.action)
  }
}
