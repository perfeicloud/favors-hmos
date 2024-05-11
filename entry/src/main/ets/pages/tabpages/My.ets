import { UserInfo } from '../../models/UserInfo'
import { NavBar } from '../components/NavBar'

@Component
@Preview
export struct My {
  @State userInfo: UserInfo = new UserInfo()

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

  aboutToAppear() {
    // 获取UserInfo
    setTimeout(() => {
      this.userInfo = new UserInfo(1, '白日梦想家', 'https://game.gtimg.cn/images/yxzj/coming/v2/skins//image/20240302/17093507917127.jpg')
      console.log(`${this.userInfo.id}, ${JSON.stringify(this.userInfo)}`)
    }, 5000)
    console.log(`${this.userInfo.id}, ${JSON.stringify(this.userInfo)}`)
  }
}