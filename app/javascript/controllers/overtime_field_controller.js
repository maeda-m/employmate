import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    this.question.addEventListener('show:question', (event) => {
      const prevAnswer = event.detail.querySelector('input')
      this.updateLabel(prevAnswer.value)
    })
  }

  get question() {
    return this.element.closest('section')
  }

  updateLabel(numeric) {
    const fields = this.question.querySelectorAll('.overtime')
    this.labels(numeric).forEach((label, i) => {
      const field = fields[i]
      document.querySelector(`label[for="${field.id}"]`).textContent = label
    })
  }

  labels(numeric) {
    if (/^\d{4}-\d{1,2}$/.test(numeric)) {
      const endMonth = new Date(`${numeric}-01`)

      const months = [...Array(6)].map((_, i) => {
        const month = new Date(endMonth)
        month.setMonth(endMonth.getMonth() - i)
        return month
      })

      return months.reverse().map((month) => {
        return month.toLocaleDateString('ja-JP', {
          year: 'numeric',
          month: 'numeric',
        })
      })
    } else {
      return []
    }
  }
}
