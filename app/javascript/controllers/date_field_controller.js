import Flatpickr from 'stimulus-flatpickr'
import { Japanese } from 'flatpickr/dist/l10n/ja'

export default class extends Flatpickr {
  initialize() {
    this.config = {
      locale: Japanese,
      allowInput: true,
      disableMobile: true,
      dateFormat: 'Y/m/d',
      ariaDateFormat: 'Y/m/d',
    }
  }
}
