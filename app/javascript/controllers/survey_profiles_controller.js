import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.element.querySelectorAll('section')[0].hidden = false
  }

  get form() {
    return this.element.querySelector('form')
  }

  question(event) {
    return event.target.closest('section')
  }

  get csrfToken() {
    const token = document.head.querySelector('meta[name="csrf-token"]')
    return token.content
  }

  back(event) {
    this.showQuestion(event, {
      shown: () => {
        this.question(event).hidden = true
      },
      nobody: () => {
        Turbo.visit('/', { action: 'replace' })
      },
    })
  }

  next(event) {
    const currentQuestion = this.question(event)
    const fields = currentQuestion.querySelectorAll('input,select')
    const isValid = Array.from(fields).every((field) => {
      return field.reportValidity()
    })

    if (isValid) {
      currentQuestion.hidden = true
      this.showQuestion(event, {
        shown: (nextQuestion) => {
          nextQuestion.dispatchEvent(
            new CustomEvent('show:question', { detail: currentQuestion })
          )
          currentQuestion.hidden = true
        },
        nobody: () => {
          document.querySelector('input[type="submit"]').hidden = false
        },
      })
    } else {
      event.preventDefault()
    }
  }

  showQuestion(event, options = {}) {
    const url = event.target.href || event.target.dataset.url
    fetch(url, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrfToken,
      },
      body: new FormData(this.element),
    })
      .then((response) => response.text())
      .then((question_id) => {
        if (question_id) {
          const question = document.querySelector(`#${question_id}`)
          question.hidden = false
          options.shown(question)
        } else {
          options.nobody()
        }
      })
  }
}
