import { preferences } from '@kit.ArkData';

/*
 * 首选项单实例
 */
export default class PreferencesInstance {
  private static mInstance: PreferencesInstance
  public data: preferences.Preferences

  private constructor(context) {
    this.data = preferences.getPreferencesSync(context, { name: 'myStore' })
  }

  public static on(context?): PreferencesInstance {
    if (!this.mInstance) {
      this.mInstance = new PreferencesInstance(context)
    }
    return this.mInstance
  }
}