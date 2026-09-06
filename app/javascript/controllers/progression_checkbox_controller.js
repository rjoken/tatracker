import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox"];
  static values = { completed: Boolean };

  connect() {
    this.applyCompletedState();
  }

  completedValueChanged() {
    this.applyCompletedState();
  }

  applyCompletedState() {
    if (!this.hasCheckboxTarget) return;
    this.checkboxTarget.checked = this.completedValue;
  }
}
