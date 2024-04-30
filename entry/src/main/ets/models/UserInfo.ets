export class UserInfo {
  readonly id: number
  fullName: string
  avatarPath: string | Resource

  constructor(id: number, fullName: string = null, avatarPath: string | Resource = null) {
    this.id = id
    this.fullName = fullName
    this.avatarPath = avatarPath
  }

}