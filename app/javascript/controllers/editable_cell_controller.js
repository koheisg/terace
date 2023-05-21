import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form", "show", 'input' ]

  edit() {
    const width = this.showTarget.offsetWidth
    const height = this.showTarget.offsetHeight
    this.formTarget.classList.remove("hidden")
    this.showTarget.classList.add("hidden")
    this.inputTarget.focus()
    this.formTarget.setAttribute("style",`width: ${width}px; height: ${height}px;`)
  }

  show() {
    this.formTarget.classList.add("hidden")
    this.showTarget.classList.remove("hidden")
  }

  loading() {
    this.showTarget.classList.remove("error")
    this.showTarget.innerHTML = this.inputTarget.value
    this.formTarget.classList.add("hidden")
    this.showTarget.classList.add("loading")
    this.showTarget.classList.remove("hidden")
  }

  hide() {
    this.showTarget.classList.remove("loading")
  }

  error() {
    this.showTarget.classList.remove("loading")
    this.showTarget.classList.add("error")
  }
}
