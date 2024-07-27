export class UserInfo {
  readonly id: number
  nickName?: string
  avatarPath?: string
  motto?: string

  constructor(id = 0, nickName?: string, avatarPath?: string, motto?: string) {
    this.id = id
    this.nickName = nickName
    this.avatarPath = avatarPath
    this.motto = motto
  }
}