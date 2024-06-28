import { authentication } from '@kit.AccountKit'
import { util } from '@kit.ArkTS'
import { StatusBarManager } from '../commons/StatusBarManager'
import { TabItem } from '../models/TabItem'
import { Home } from './tabpages/Home'
import { Contact } from './tabpages/Contact'
import { My } from './tabpages/My'

@Entry
@Component
struct Index {
  @State statusBarHeight: number = 0
  @State navigationBarHeight: number = 0
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
    .padding({ top: px2vp(this.statusBarHeight), bottom: px2vp(this.navigationBarHeight) })
    .backgroundColor($r('sys.color.ohos_id_container_color'))
  }

  aboutToAppear() {
    // 设置沉浸式窗口，获取状态栏高度
    StatusBarManager.on().setImmersiveStatusBar().then(res => {
      this.statusBarHeight = res.statusBarHeight
      this.navigationBarHeight = res.navigationBarHeight
    })

    // 创建登录请求，并设置参数
    let loginRequest = new authentication.HuaweiIDProvider().createLoginWithHuaweiIDRequest()
    loginRequest.forceLogin = true
    loginRequest.idTokenSignAlgorithm = authentication.IdTokenSignAlgorithm.PS256
    loginRequest.state = util.generateRandomUUID()

    // 执行登录请求，并处理结果
    try {
      let controller = new authentication.AuthenticationController(getContext(this));
      controller.executeRequest(loginRequest, (error, data) => {
        if (error) {
          console.error(`Failed to auth. Code: ${error.code}, message: ${error.message}`)
          // return
        }
        let loginWithHuaweiIDResponse = data as authentication.LoginWithHuaweiIDResponse
        let state = loginWithHuaweiIDResponse.state
        if (state != undefined && loginRequest.state != state) {
          console.info(`Failed to authorize. The state is different, response state: ${state}`)
          return
        }
        console.info(`Succeeded in login. ${JSON.stringify(loginWithHuaweiIDResponse)}`)

        let loginWithHuaweiIDCredential = loginWithHuaweiIDResponse.data!;
        let code = loginWithHuaweiIDCredential.authorizationCode;
        let idToken = loginWithHuaweiIDCredential.idToken;
        let openID = loginWithHuaweiIDCredential.openID;
        let unionID = loginWithHuaweiIDCredential.unionID;
        // 开发者处理code, idToken, openID, unionID
        console.info(
          `code: ${code}`,
          `idToken: ${idToken}`,
          `openID: ${openID}`,
          `unionID: ${unionID}`
        )
      })
    } catch (error) {
      console.error(`Failed to auth.`)
    }


    // // 获取华为账号openID
    // let authRequest = new authentication.HuaweiIDProvider().createAuthorizationWithHuaweiIDRequest();
    // authRequest.scopes = ['profile', 'openid']
    // authRequest.permissions = ['idtoken']
    // authRequest.forceAuthorization = false
    // authRequest.state = util.generateRandomUUID()
    //
    // // 执行授权请求，并处理结果
    // try {
    //   let controller = new authentication.AuthenticationController()
    //   controller.executeRequest(authRequest, (error, data) => {
    //     if (error) {
    //       console.error(`Failed to auth. Code: ${error.code}, message: ${error.message}`)
    //       // return;
    //     }
    //     let authorizationWithHuaweiIDResponse = data as authentication.AuthorizationWithHuaweiIDResponse;
    //     let state = authorizationWithHuaweiIDResponse.state;
    //     if (state != undefined && authRequest.state != state) {
    //       console.info(`Failed to authorize. The state is different, response state: ${state}`)
    //       return;
    //     }
    //
    //     console.info(`Succeeded in authentication. ${JSON.stringify(authorizationWithHuaweiIDResponse)}`)
    //     let authorizationWithHuaweiIDCredential = authorizationWithHuaweiIDResponse.data!;
    //     let avatarUri = authorizationWithHuaweiIDCredential.avatarUri; // 元服务不支持该字段
    //     let nickName = authorizationWithHuaweiIDCredential.nickName; // 元服务不支持该字段
    //     let idToken = authorizationWithHuaweiIDCredential.idToken;
    //     let openID = authorizationWithHuaweiIDCredential.openID;
    //     let unionID = authorizationWithHuaweiIDCredential.unionID;
    //     // 开发者处理avatarUri, nickName, idToken, openID, unionID
    //     console.log(
    //       `avatarUri: ${avatarUri}`,
    //       `nickName: ${nickName}}`,
    //       `idToken: ${idToken}`,
    //       `openID: ${openID}`,
    //       `unionID: ${unionID}`
    //     );
    //   });
    // } catch (error) {
    //   console.error(`Failed to auth.`)
    // }

  }
}