import { distributedKVStore } from '@kit.ArkData'

export class KVStore {
  private static instance: KVStore
  private kvManager: distributedKVStore.KVManager | undefined = undefined
  private constructor(context, bundleName: string) {
    this.kvManager = distributedKVStore.createKVManager({
      context, bundleName
    })
  }

  public static create(context, bundleName: string) {
    if (!this.instance) {
      this.instance = new KVStore(context, bundleName)
    }
    return this.instance
  }

  public static async GET(storeId: string) {
    if (this.instance.kvManager) {
      return await this.instance.kvManager.getKVStore<distributedKVStore.DeviceKVStore>(storeId, { securityLevel: 1 })
    }
  }

}