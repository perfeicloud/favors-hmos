export class UserInfo {
  readonly id: number = 0
  nickName?: string | Resource
  avatarPath?: string | Resource
  motto?: string

  constructor()
  constructor(id: number, nickName: string, avatarPath?: string, motto?: string)

  constructor(id?: number, nickName?: string, avatarPath?: string, motto?: string) {
    this.id = id || 0
    this.nickName = nickName || $r('app.string.UserInfo_nickName')
    this.avatarPath = avatarPath || $r('app.media.ic_user_portrait')
    if (motto) this.motto = motto
  }
}