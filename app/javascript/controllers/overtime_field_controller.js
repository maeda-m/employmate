import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['overtime']

  selectAll() {
    this.overtimeTarget.select()
  }
}
