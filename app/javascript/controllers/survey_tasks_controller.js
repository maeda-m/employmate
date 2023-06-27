import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  form(event) {
    return event.target.form
  }

  switchRequired(event) {
    const required = event.target.value !== 'yes'
    const exceptSection = event.target.closest('section')
    const sections = this.form(event).querySelectorAll('section')

    Array.from(sections).forEach((section) => {
      if (exceptSection == section) {
        // Do Nothing
      } else {
        const element = section.querySelector('input,select')
        element.required = required
      }
    })
  }
}
