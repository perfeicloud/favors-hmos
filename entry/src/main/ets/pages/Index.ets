import { StatusBarManager } from '../commons/StatusBarManager'
import { TabContacts } from './TabContacts'
import { TabHome } from './TabHome'
import { TabMy } from './TabMy'

interface ITabItem {
  text: Resource|string
  icon: Resource|string
  selectedIcon?: Resource|string
}

@Entry
@Component
struct Index {
  @State currentTabIndex: number = 0
  @State statusBarHeight: number = 0
  @State navigationBarHeight: number = 0
  private tabsController: TabsController = new TabsController()
  private tabItems: ITabItem[] = [
    {
      text: $r('app.string.TabHome_label'),
      icon: $r("app.media.ic_tab_home_0"),
      selectedIcon: $r("app.media.ic_tab_home_1"),
    },
    {
      text: $r('app.string.TabContacts_label'),
      icon: $r('app.media.ic_tab_contacts_0'),
      selectedIcon: $r('app.media.ic_tab_contacts_1'),
    },
    {
      text: $r('app.string.TabMy_label'),
      icon: $r("app.media.ic_tab_my_0"),
      selectedIcon: $r("app.media.ic_tab_my_1"),
    }
  ]

  @Builder TabBar(index: number, item: ITabItem) {
    Column() {
      Image((this.currentTabIndex === index && item.selectedIcon) ? item.selectedIcon : item.icon)
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
      Text(item.text)
        .lineHeight(14)
        .fontColor(this.currentTabIndex === index ? 0xFF5D50 : 0x8a8a8a)
        .fontSize(10)
        .fontWeight(this.currentTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .onClick(() => {
      this.tabsController.changeIndex(this.currentTabIndex = index)
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        ForEach(this.tabItems, (item: ITabItem, index) => {
          TabContent() {
              if (index === 0) {
                TabHome({ statusBarHeight: this.statusBarHeight, navigationBarHeight: this.navigationBarHeight})
              } else if (index === 1) {
                TabContacts()
              } else if (index === 2) {
                TabMy()
              }
          }.tabBar(this.TabBar(index, item))
        })
      }
      .onChange((index: number) => {
        this.currentTabIndex = index
      })
    }
    .padding({ top: px2vp(this.statusBarHeight), bottom: px2vp(this.navigationBarHeight) })
    .backgroundColor($r('app.color.start_window_background'))
  }

  aboutToAppear() {
    // 设置沉浸式窗口，获取状态栏高度
    StatusBarManager.on().setImmersiveStatusBar().then(res => {
      this.statusBarHeight = res.statusBarHeight
      this.navigationBarHeight = res.navigationBarHeight
    })
  }

}