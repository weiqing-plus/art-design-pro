import request from '@/utils/http'
import { menuDataToRouter } from '@/router/utils/menuToRouter'
import { AppRouteRecord } from '@/types/router'

interface MenuResponse {
  menuList: AppRouteRecord[]
}

// 菜单接口
export const menuService = {
  async getMenuList(): Promise<MenuResponse> {
    try {
      // 模拟接口返回的菜单数据
      const menuData = await request.post<AppRouteRecord[]>({
        url: '/api/auth/menu'
      })
      // 处理菜单数据
      const menuList = menuData.map((route) => menuDataToRouter(route))
      return { menuList }
    } catch (error) {
      throw error instanceof Error ? error : new Error('获取菜单失败')
    }
  },
  async getTreeList(): Promise<MenuResponse> {
    try {
      // 模拟接口返回的菜单数据
      const menuData = await request.post<AppRouteRecord[]>({
        url: '/api/menu/tree'
      })
      // 处理菜单数据
      const menuList = menuData.map((route) => menuDataToRouter(route))
      return { menuList }
    } catch (error) {
      throw error instanceof Error ? error : new Error('获取菜单失败')
    }
  }
}
