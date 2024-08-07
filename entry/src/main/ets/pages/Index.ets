import { Home } from './tabpages/Home'
import { Contact } from './tabpages/Contact'
import { My } from './tabpages/My'
import { AvoidAreaHeight, TabItem } from '../models/AppStorages'
import { UserInfo } from '../models/UserInfo'

@Entry
@Component
struct Index {
  @StorageProp('AvoidAreaHeight') avoidAreaHeight: AvoidAreaHeight = new AvoidAreaHeight()
  @State currentTabIndex: number = 0
  private tabItems: TabItem[] = [
    new TabItem($r('app.string.TabItem_Home_text'), $r("app.media.ic_tab_home_0"), $r("app.media.ic_tab_home_1")),
    new TabItem($r('app.string.TabItem_Contact_text'), $r('app.media.ic_tab_contacts_0'), $r('app.media.ic_tab_contacts_1')),
    new TabItem($r('app.string.TabItem_My_text'), $r("app.media.ic_tab_my_0"), $r("app.media.ic_tab_my_1"))
  ]
  private tabsController: TabsController = new TabsController()

  @Builder TabBar(index: number, item: TabItem) {
    Column() {
      Image((this.currentTabIndex === index) ? item.selectedIcon : item.icon)
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
      Text(item.text)
        .lineHeight(14)
        .fontColor(this.currentTabIndex === index ? $r('app.color.brand_primary') : $r('sys.color.ohos_id_color_bottom_tab_text_off'))
        .fontSize(10)
        .fontWeight(this.currentTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
    }
    .width('100%')
    .onClick(() => this.tabsController.changeIndex(this.currentTabIndex = index))
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        ForEach(this.tabItems, (item: TabItem, index) => {
          TabContent() {
            if (index === 0) Home()
            else if (index === 1) Contact()
            else if (index === 2) My()
          }.tabBar(this.TabBar(index, item))
        })
      }
      .onChange((index: number) => {
        this.currentTabIndex = index
      })
    }
    .padding({ top: px2vp(this.avoidAreaHeight.top), bottom: px2vp(this.avoidAreaHeight.bottom) })
    .backgroundColor($r('sys.color.ohos_id_container_color'))
  }

  aboutToAppear() {
    setTimeout(() => {
      const userInfo = new UserInfo(1, '白日梦想家', 'https://game.gtimg.cn/images/yxzj/coming/v2/skins//image/20240302/17093507917127.jpg')
      AppStorage.setOrCreate('UserInfo', userInfo)
    }, 10000)
  }
}