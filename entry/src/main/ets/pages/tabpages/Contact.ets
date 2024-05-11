import { NavBar } from '../components/NavBar'

@Component
@Preview
export struct Contact {

  build() {
    Column() {
      NavBar({ title: '亲友圈' })
      Text('亲友圈页面')
    }.height('100%').padding({ left: 12, right: 12 })
  }
}