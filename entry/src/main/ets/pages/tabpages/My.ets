import { UserInfo } from '../../models/UserInfo'
import { NavBar } from '../components/NavBar'

@Component
export struct My {
  @StorageProp('UserInfo') userInfo: UserInfo = new UserInfo()

  build() {
    Column() {
      NavBar({ title: '我的' })
      // 个人信息
      Row() {
        Image(this.userInfo.avatarPath || $r('app.media.ic_user_portrait'))
          .width(36)
          .height(36)
          .borderRadius(100)
        Text(this.userInfo.nickName || $r('app.string.UserInfo_nickName'))
          .fontSize(16)
          .margin({left: 12})
      }
    }.height('100%').padding({ left: 12, right: 12 })
  }
}