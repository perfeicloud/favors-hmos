import { LoginPanel, loginComponentManager, authentication } from '@kit.AccountKit';
// import { util } from '@kit.ArkTS';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Component
export struct QuickLoginPanel {
  logTag: string = 'QuickLoginPanel';
  domainId: number = 0x0000;
  /**
   * Whether to display the LoginPanel component.
   */
  @State show: boolean = false;
  /**
   * AnonymousPhoneNumber associated with the HUAWEI ID.
   */
  quickLoginAnonymousPhone: string = '';
  /**
   * Define the privacy text on LoginPanel.
   */
  privacyText: loginComponentManager.PrivacyText[] = [{
    text: '已阅读并同意',
    type: loginComponentManager.TextType.PLAIN_TEXT
  }, {
    text: '《用户服务协议》 ',
    tag: '用户服务协议',
    type: loginComponentManager.TextType.RICH_TEXT
  }, {
    text: '《隐私协议》',
    tag: '隐私协议',
    type: loginComponentManager.TextType.RICH_TEXT
  }, {
    text: '和',
    type: loginComponentManager.TextType.PLAIN_TEXT
  }, {
    text: '《华为帐号用户认证协议》',
    tag: '华为帐号用户认证协议',
    type: loginComponentManager.TextType.RICH_TEXT
  }];
  /**
   * Construct a controller for LoginPanel.
   */
  controller: loginComponentManager.LoginPanelController = new loginComponentManager.LoginPanelController()
    .onClickLoginWithHuaweiIDButton((error: BusinessError, response: loginComponentManager.HuaweiIDCredential) => {
      hilog.info(this.domainId, this.logTag, 'onClickLoginWithHuaweiIDButton');
      if (error) {
        hilog.error(this.domainId, this.logTag, 'onClickLoginWithHuaweiIDButton error ' + error.code);
        return;
      }

      if (response) {
        hilog.info(this.domainId, this.logTag, 'onClickLoginWithHuaweiIDButton response success.');
        let authCode = response.authorizationCode;
        let openID = response.openID;
        let unionID = response.unionID;
        let idToken = response.idToken;
        this.show = false;
        return;
      }
    })
    .onClickOptionalLoginButton(() => {
      hilog.info(this.domainId, this.logTag, 'onClickOptionalLoginButton');
      this.show = false;
    })
    .onClickPrivacyText((error: BusinessError, tag: string) => {
      hilog.info(this.domainId, this.logTag, 'onClickPrivacyText tag:' + tag);
    })
    .onClickCloseButton(() => {
      hilog.info(this.domainId, this.logTag, 'onClickCloseButton');
      this.show = false;
    })
    .onChangeAgreementStatus((error: BusinessError, agreementStatus: loginComponentManager.AgreementStatus) => {
      hilog.info(this.domainId, this.logTag, "onChangeAgreementStatus:" + agreementStatus);
    });

  build() {
    if (this.show) {
      Stack() {
        LoginPanel({
          show: this.show,
          params: {
            appInfo: {
              appIcon: $r('app.media.app_icon'),
              appName: $r('app.string.app_name'),
              appDescription: "应用描述"
            },
            privacyText: this.privacyText,
            anonymousPhoneNumber: this.quickLoginAnonymousPhone,
            optionalLoginButtonAttr: { text: '其他方式登录' },
            loginType: loginComponentManager.LoginType.QUICK_LOGIN,
          },
          controller: this.controller
        })
      }
      .height('100%')
      .width('100%')
    }
  }

  aboutToAppear(): void {
    /**
     * Obtain the anonymous mobile phone number associated the HUAWEI ID.
     */
    this.getQuickLoginAnonymousPhone();
  }

  getQuickLoginAnonymousPhone() {
    /**
     * Creates an authorization request.
     */
    let authRequest = new authentication.HuaweiIDProvider().createAuthorizationWithHuaweiIDRequest();
    /**
     * User information requested by the application.
     */
    authRequest.scopes = ['quickLoginAnonymousPhone'];
    authRequest.forceAuthorization = false;
    let controller = new authentication.AuthenticationController(getContext(this));
    try {
      controller.executeRequest(authRequest).then((response: authentication.AuthorizationWithHuaweiIDResponse) => {
        let anonymousPhone = response.data?.extraInfo?.quickLoginAnonymousPhone;
        if (anonymousPhone) {
          this.quickLoginAnonymousPhone = anonymousPhone as string;
          this.show = true;
          hilog.info(this.domainId, this.logTag, 'authorization success');
          return;
        }

        hilog.info(this.domainId, this.logTag, 'authorization success anonymousPhone is empty');
      }).catch((err: BusinessError) => {
        hilog.error(this.domainId, this.logTag, 'authorization fail: ' + err.code);
      })
    } catch (err) {
      hilog.error(this.domainId, this.logTag, 'authorization fail: ' + err.code);
    }
  }
}
