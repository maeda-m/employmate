import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  done(event) {
    const form = event.target.form
    form.requestSubmit()
  }
}
