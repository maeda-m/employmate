import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.syncValue()
  }

  get yearValue() {
    return this.element.querySelector('select#date_year').value
  }

  get monthValue() {
    const monthElement = this.element.querySelector('select#date_month')
    return monthElement.options[monthElement.selectedIndex].label
  }

  get valueElement() {
    return this.element.querySelector('input[type="month"]')
  }

  syncValue() {
    this.valueElement.value = `${this.yearValue}-${this.monthValue}`
  }
}
