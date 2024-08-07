export class AvoidAreaHeight {
  readonly top: number
  readonly bottom: number

  constructor(top = 0, bottom = 0) {
    this.top = top
    this.bottom = bottom
  }
}

export class TabItem {
  text: string | Resource
  icon: string | Resource
  selectedIcon: string | Resource

  constructor(text: string | Resource, icon: string | Resource, selectedIcon: string | Resource) {
    this.text = text
    this.icon = icon
    this.selectedIcon = selectedIcon
  }
}