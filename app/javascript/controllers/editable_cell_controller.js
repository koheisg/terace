import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form", "show", 'input' ]

  edit() {
    const width = this.showTarget.offsetWidth
    const height = this.showTarget.offsetHeight
    this.formTarget.classList.remove("hide")
    this.showTarget.classList.add("hide")
    this.inputTarget.focus()
    this.formTarget.setAttribute("style",`width: ${width}px; height: ${height}px;`)
  }

  show() {
    this.formTarget.classList.add("hide")
    this.showTarget.classList.remove("hide")
  }

  loading() {
    this.showTarget.classList.remove("error")
    this.showTarget.innerHTML = this.inputTarget.value
    this.formTarget.classList.add("hide")
    this.showTarget.classList.add("loading")
    this.showTarget.classList.remove("hide")
  }

  hide() {
    this.showTarget.classList.remove("loading")
  }

  error() {
    this.showTarget.classList.remove("loading")
    this.showTarget.classList.add("error")
  }
}
