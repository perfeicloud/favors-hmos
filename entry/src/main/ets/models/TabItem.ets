export class TabItem {
  text: string | Resource
  icon: string | Resource
  selectedIcon: string | Resource

  constructor(text: string | Resource,
              icon: string | Resource,
              selectedIcon: string | Resource) {
    this.text = text
    this.icon = icon
    this.selectedIcon = selectedIcon
  }
}