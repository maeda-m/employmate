import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  form(event) {
    return event.target.form
  }

  done(event) {
    this.form(event).requestSubmit()
  }

  survey(event) {
    /* global Turbo */
    Turbo.visit(this.form(event).action)
  }
}
