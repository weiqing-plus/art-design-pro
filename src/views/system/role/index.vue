<template>
  <div class="user-page art-full-height">
    <!-- 搜索区域 -->
    <ArtSearchBar
      v-model:filter="searchFormState"
      :items="searchItems"
      :is-expand="false"
      :show-expand="true"
      @search="handleSearch"
      @reset="handleReset"
    />

    <ElCard class="art-table-card" shadow="never">
      <ArtTableHeader
        v-model:columns="columnChecks"
        @refresh="handleRefresh"
        layout="refresh,size,fullscreen,columns,settings"
        fullClass="art-table-card"
      >
        <template #left>
          <div class="toolbar-left">
            <ElButton type="primary" v-ripple>
              <ElIcon><Plus /></ElIcon>
              新增角色
            </ElButton>
          </div>
        </template>
      </ArtTableHeader>
      <ArtTable
        ref="tableRef"
        :loading="isLoading"
        :pagination="paginationState"
        :data="tableData"
        :columns="columns"
        @pagination:size-change="onPageSizeChange"
        @pagination:current-change="onCurrentPageChange"
      >
      </ArtTable>
    </ElCard>
  </div>
</template>

<script lang="ts" setup>
  import type { SearchFormItem } from '@/types'
  import { Plus } from '@element-plus/icons-vue'
  import { useTable } from '@/composables/useTable'
  import { RoleService } from '@/api/roleApi'

  // 定义搜索表单的初始状态
  const initialSearchState = {
    name: '',
    status: ''
  }
  // 搜索表单状态
  const searchFormState = ref({ ...initialSearchState })
  // 搜索表单配置项
  const searchItems: SearchFormItem[] = [
    {
      prop: 'name',
      label: '角色名称',
      type: 'input'
    },
    {
      prop: 'status',
      label: '角色状态',
      type: 'select',
      config: {
        clearable: true
      },
      options: [
        {
          label: '正常',
          value: 1
        },
        {
          label: '禁用',
          value: 2
        }
      ]
    }
  ]

  const handleSearch = () => {
    Object.assign(searchState, searchFormState.value)
    searchData()
  }
  const handleReset = () => {
    // 重置搜索表单状态
    searchFormState.value = { ...initialSearchState }
    resetSearch()
  }

  const handleRefresh = () => {
    refreshAll()
  }

  // 表格配置项
  const {
    // 列配置
    columns,
    columnChecks,

    // 刷新策略
    refreshAll,

    // 数据相关
    tableData,
    isLoading,

    // 分页相关
    paginationState,
    onPageSizeChange,
    onCurrentPageChange,

    // 搜索相关
    searchState, // 搜索参数
    resetSearch,

    // 数据操作
    searchData
  } = useTable<Api.Role.RoleListItem>({
    core: {
      apiFn: RoleService.getRoleList,
      apiParams: {
        page: 1,
        size: 1,
        name: '',
        status: ''
      },
      paginationKey: {
        current: 'page'
      },
      columnsFactory: () => [
        { type: 'selection', width: 50 },
        {
          prop: 'name',
          label: '角色名称',
          sortable: true
        },
        {
          prop: 'status',
          label: '角色状态',
          sortable: true,
          formatter: (row) => {
            return row.status === 1 ? '正常' : '禁用'
          }
        },
        {
          prop: 'desc',
          label: '角色描述'
        },
        {
          prop: 'created_at',
          label: '创建时间'
        }
      ]
    }
  })
</script>
