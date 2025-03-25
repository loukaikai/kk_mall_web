import request from '@/utils/request'
import qs from 'qs'

export function initData(url, params) {
  const data = params
  debugger
  return request({
    url: url,
    method: 'post',
    data
  })
}

export function download(url, params) {
  return request({
    url: url + '?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}
