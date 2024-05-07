import router from '@ohos.router'

export interface INavBar {
  title: Resource|string
  isBack?: boolean
  icons?: Array<{icon: Resource|string, action: ()=>void}>
  menus?: Array<{value: string, action: ()=>void}>
}

@Extend(Shape) function shapeStyles() {
  .viewPort({
    x: 0,
    y: 0,
    width: '1024px',
    height: '1024px'
  })
  .width(24)
  .height(24)
}

@Component
@Preview
export struct NavBar {
  private title: Resource|string
  private isBack: boolean
  @State icons: ({icon: Resource|string, action: ()=>void})[] = []
  @State menus: ({value: string, action: ()=>void})[] = []

  build() {
    Row({space: 12}) {
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
        ForEach(this.icons, (item: {icon: Resource|string, action?: ()=>void}) => {
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