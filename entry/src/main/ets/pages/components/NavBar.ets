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
    width: '24px',
    height: '24px'
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
        Shape() {
          Path()
            .commands('M5.31079777,13.7499686 L11.2803301,19.7196699 L11.3140714,19.7556673 C11.5727547,20.0502619 11.5615076,20.4991526 11.2803301,20.7803301 C10.9991526,21.0615076 10.5502619,21.0727547 10.2556673,20.8140714 L10.2196699,20.7803301 L3.18929777,13.7499686 L5.31079777,13.7499686 Z M11.2803301,3.21966991 C11.5615076,3.5008474 11.5727547,3.94973814 11.3140714,4.24433269 L11.2803301,4.28033009 L4.3105,11.25 L21,11.25 C21.3994202,11.25 21.7259152,11.56223 21.7487268,11.9559318 L21.75,12 C21.75,12.3994202 21.43777,12.7259152 21.0440682,12.7487268 L21,12.75 L3.10355339,12.75 C2.8383369,12.75 2.58398299,12.6446432 2.39644661,12.4571068 C2.01893979,12.0796 2.00635623,11.4753589 2.35869593,11.0827365 L2.39644661,11.0428932 L10.2196699,3.21966991 C10.5125631,2.9267767 10.9874369,2.9267767 11.2803301,3.21966991 Z')
            .strokeWidth(0)
        }
        .shapeStyles()
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
        Shape() {
          Path()
            .commands('M6.25,15.5 C7.21649831,15.5 8,16.2835017 8,17.25 C8,18.2164983 7.21649831,19 6.25,19 C5.28350169,19 4.5,18.2164983 4.5,17.25 C4.5,16.2835017 5.28350169,15.5 6.25,15.5 Z M17.75,15.5 C18.7164983,15.5 19.5,16.2835017 19.5,17.25 C19.5,18.2164983 18.7164983,19 17.75,19 C16.7835017,19 16,18.2164983 16,17.25 C16,16.2835017 16.7835017,15.5 17.75,15.5 Z M6.25,4.5 C7.21649831,4.5 8,5.28350169 8,6.25 C8,7.21649831 7.21649831,8 6.25,8 C5.28350169,8 4.5,7.21649831 4.5,6.25 C4.5,5.28350169 5.28350169,4.5 6.25,4.5 Z M17.75,4.5 C18.7164983,4.5 19.5,5.28350169 19.5,6.25 C19.5,7.21649831 18.7164983,8 17.75,8 C16.7835017,8 16,7.21649831 16,6.25 C16,5.28350169 16.7835017,4.5 17.75,4.5 Z')
            .strokeWidth(0)
        }
        .shapeStyles()
        .bindMenu(this.menus)
      }
    }.width('100%').padding(12)
  }
}