import { http } from '@kit.NetworkKit'

const dataHost = 'https://api.perfei.com'

const request = async (path: string, method = http.RequestMethod.GET, extraData?) => {
  const httpRequest = http.createHttp()
  const token = ''

  const data = await httpRequest.request(
    dataHost + path,
    {
      method,
      header: {
        'Content-Type': 'application/json',
        'Authorization': token || ''
      },
      extraData,
      expectDataType: http.HttpDataType.STRING,
      connectTimeout: 15000
    }
  )
  httpRequest.destroy()

  return new Promise<object>((resolve, reject) => {
    if (data.responseCode < 300) {
      resolve(JSON.parse(data.result.toString()))
    } else {
      reject({
        'errCode': data.responseCode,
        'errMsg': data.result.toString()
      })
    }
  })
}

export const Request = {
  GET(path: string) {
    return request(path)
  },
  POST(path: string, data: Object) {
    return request(path, http.RequestMethod.POST, data)
  },
  PUT(path: string, data: object) {
    return request(path, http.RequestMethod.PUT, data)
  },
  DELETE(path: string, data: Object) {
    return request(path, http.RequestMethod.DELETE, data)
  }
}