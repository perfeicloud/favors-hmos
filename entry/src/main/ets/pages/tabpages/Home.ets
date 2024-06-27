import { NavBar } from '../components/NavBar'

@Component
export struct Home {
  @Styles boxStyles() {
    .width('100%')
    .margin({ top: 12 })
    .padding(12)
    .borderRadius(14)
    .backgroundColor($r('sys.color.ohos_id_color_list_card_bg'))
  }

  build() {
    Column() {
      NavBar({ title: '人情账本' })

      List() {
        ListItem() {
          Text('标题栏')
        }.boxStyles()

        ForEach([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], (item: number) => {
          ListItem() {
            Text(`${item} - Favors Item`)
          }.boxStyles()
        })
      }.layoutWeight(1)
    }.height('100%').padding({ left: 12, right: 12 })
  }
}