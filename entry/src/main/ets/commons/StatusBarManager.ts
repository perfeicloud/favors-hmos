import window from '@ohos.window'

export class StatusBarManager {
  private static mInstance: StatusBarManager
  private mWindowStage: window.WindowStage

  private constructor() { }

  public static on(windowStage: window.WindowStage = undefined): StatusBarManager {
    if (!this.mInstance) {
      this.mInstance = new StatusBarManager()
    }
    if (windowStage) {
      this.mInstance.mWindowStage = windowStage
    }
    return this.mInstance
  }

  /**
   * 设置沉浸式状态栏
   * @param is 是否沉浸式，默认值 true
   * @param arrSystemBarEnable 导航栏、状态栏的可见模式
   * @param windowStage WindowStage实例
   * @returns 状态栏高度
   */
  public setImmersiveStatusBar(
    is: boolean = true,
    windowStage: window.WindowStage = this.mWindowStage
  ): Promise<{statusBarHeight: number, navigationBarHeight: number}> {
    return new Promise((resolve, reject) => {
      windowStage.getMainWindow().then(windowClass => {
        windowClass.setWindowLayoutFullScreen(is).then(() => {
          resolve({
            statusBarHeight: windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height | 0,
            navigationBarHeight: windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height | 0
          })
        }).catch(err => reject(err))
      }).catch(err => reject(err))
    })
  }
}