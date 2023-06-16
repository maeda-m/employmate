import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['overtime']

  selectAll() {
    this.overtimeTarget.select()
  }

  implicitSubmit() {
    // Note: Enter キー押下でのフォーム送信（戻るボタン経由）を拒否する
    // See: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#implicit-submission
  }
}
