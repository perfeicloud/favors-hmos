import { NavBar } from './components/NavBar'

@Component
export struct TabHome {
  @Prop statusBarHeight: number
  @Prop navigationBarHeight: number

  build() {
    Column() {
      NavBar({ title: '人情账本' })
      Text(`State: ${this.statusBarHeight}, Navigation: ${this.navigationBarHeight}`)
    }.height('100%').padding({ left: 12, right: 12 })
  }
}