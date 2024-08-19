export class Book {
  readonly id: number
  owner: number
  name?: string
  icon?: string
  remark?: string

  constructor(id = 0, owner = 0, name?: string, icon?: string, remark?: string) {
    this.id = id
    this.owner = owner
    this.name = name
    this.icon = icon
    this.remark = remark
  }
}