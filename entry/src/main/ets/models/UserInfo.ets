export class UserInfo {
  readonly id?: number
  nickName?: string
  avatarPath?: string
  motto?: string

  constructor()
  constructor(id: number, nickName: string, avatarPath?: string, motto?: string)

  constructor(id?: number, nickName?: string, avatarPath?: string, motto?: string) {
    if (id) {
      this.id = id
      this.nickName = nickName
      if (avatarPath) this.avatarPath = avatarPath
      if (motto) this.motto = motto
    }
  }

}