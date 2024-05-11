import { NavBar } from './components/NavBar'

@Component
@Preview
export struct TabMy {

  build() {
    Column() {
      NavBar({ title: '我的' })
      Text('我的页面')
    }.height('100%').padding({ left: 12, right: 12 })
  }
}