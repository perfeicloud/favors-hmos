export class UserInfo {
  readonly id: number
  nickName?: string
  avatarPath?: string
  motto?: string

  constructor()
  constructor(id: number, nickName: string, avatarPath?: string, motto?: string)
  constructor(id = 0, nickName?: string, avatarPath?: string, motto?: string) {
    this.id = id
    if (nickName) this.nickName = nickName
    if (avatarPath) this.avatarPath = avatarPath
    if (motto) this.motto = motto
  }
}