import { Controller } from '@hotwired/stimulus'

// See: https://github.com/jackbsteinberg/std-toast/blob/master/study-group/README.md
import 'sweetalert2'

/* global Sweetalert2 */
const Toast = Sweetalert2.mixin({
  toast: true,
  position: 'bottom',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
})

export default class extends Controller {
  static values = {
    title: String,
  }

  connect() {
    if (this.titleValue) {
      Toast.fire({
        title: this.titleValue,
      })
    }
  }
}
