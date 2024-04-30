import { StatusBarManager } from '../commons/StatusBarManager'
import { NavBar } from './components/NavBar'

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
      text: '人情账',
      icon: $r('app.media.ic_tab_present_0'),
      selectedIcon: $r('app.media.ic_tab_present_1'),
    },
    {
      text: '亲友圈',
      icon: $r('app.media.ic_tab_contacts_0'),
      selectedIcon: $r('app.media.ic_tab_contacts_1'),
    },
    {
      text: '我的',
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
        .fontColor(this.currentTabIndex === index ? Color.Orange : Color.Gray)
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

  aboutToAppear() {
    // 设置沉浸式窗口，获取状态栏高度
    StatusBarManager.on().setImmersiveStatusBar().then(res => {
      this.statusBarHeight = res.statusBarHeight
      this.navigationBarHeight = res.navigationBarHeight
    })
  }

  build() {
    Column() {
      Tabs({barPosition: BarPosition.End, controller: this.tabsController}) {
        ForEach(this.tabItems, (item: ITabItem, index) => {
          TabContent() {
            Column() {
              NavBar({
                title: item.text,
                isBack: index > 0 && true
              })
              Text(item.text)
              Text(`State: ${this.statusBarHeight}, Navigation: ${this.navigationBarHeight}`)
            }.height('100%').padding({left: 12, right: 12})
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

}