export class Book {
  readonly id: number
  name: string | Resource
  icon: string | Resource
  remark: string

  constructor(id: number = 0,
              name: string | Resource  = $r('app.string.Book_name'),
              icon: string | Resource = $r('app.media.ic_book_icon'),
              remark: string = ''
  ) {
    this.id = id
    this.name = name
    this.icon = icon
    this.remark = remark
  }
}