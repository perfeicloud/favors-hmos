import router from '@ohos.router'

interface IconItem {
  icon: Resource|string,
  action: ()=>void
}

@Component
export struct NavBar {
  title: Resource|string = ''
  private isBack: boolean = false
  private icons: (IconItem)[] = []
  private menus: MenuElement[] = []

  build() {
    Row({ space: 12 }) {
      if (this.isBack) {
        Image($r('app.media.ic_public_back'))
          .width(24)
          .height(24)
          .onClick( () => router.back() )
      }
      Text(this.title)
        .fontSize(this.isBack ? 20 : 24)
        .fontWeight(500)
      Blank()
      Row({space: 24}) {
        ForEach(this.icons, (item: IconItem) => {
          Image(item.icon)
            .width(24)
            .height(24)
            .onClick(() => {
              item.action()
            })
        })
        Image($r('app.media.ic_public_more'))
          .width(24)
          .height(24)
          .bindMenu(this.menus)
      }
    }.width('100%').padding(12)
  }
}