export class Tally {
  readonly id: number
  category: number
  amount: number
  timestamp: number
  remark?: string

  constructor(id: number,
              amount: number,
              category: number,
              timestamp: number,
              remark?: string) {
    this.id = id
    this.amount = amount
    this.category = category
    this.timestamp = timestamp
    if (remark) this.remark = remark
  }
}