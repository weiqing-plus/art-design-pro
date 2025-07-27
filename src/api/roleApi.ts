import request from '@/utils/http'

export class RoleService {
  // 获取角色列表
  static getRoleList(params: Api.Common.PaginatingSearchParams) {
    return request.post<Api.Role.RoleListData>({
      url: '/api/role/list',
      data: params
    })
  }
}
