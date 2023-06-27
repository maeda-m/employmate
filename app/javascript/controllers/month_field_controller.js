import Flatpickr from 'stimulus-flatpickr'
import { Japanese } from 'flatpickr/dist/l10n/ja'
import monthSelectPlugin from 'flatpickr/dist/plugins/monthSelect'

export default class extends Flatpickr {
  initialize() {
    this.config = {
      locale: Japanese,
      allowInput: true,
      disableMobile: true,
      ariaDateFormat: 'Y/m',
      plugins: [
        new monthSelectPlugin({
          dateFormat: 'Y/m',
        }),
      ],
    }
  }
}
