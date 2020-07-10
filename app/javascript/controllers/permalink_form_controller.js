import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'type', 'articleFields', 'pageFields', 'archiveFields', 'permalinkableFields']
  connect() {
    this.select()
  }

  select() {
    const content = this.selectPermalinkableFields()
    this.permalinkableFieldsTarget.innerHTML = content
  }

  selectPermalinkableFields() {
    const permalinkableType = this.typeTarget.value
    if (permalinkableType == 'Article') {
      return this.articleFieldsTarget.innerHTML
    } else if (permalinkableType == 'Page') {
      return this.pageFieldsTarget.innerHTML
    } else {
      return this.archiveFieldsTarget.innerHTML
    }
  }
}
