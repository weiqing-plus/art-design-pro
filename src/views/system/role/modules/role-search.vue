<template>
  <ArtSearchBar
    v-model:filter="searchFormState"
    :items="formItems"
    @reset="handleReset"
    @search="handleSearch"
  />
</template>

<script setup lang="ts">
  import { SearchChangeParams, SearchFormItem } from '@/types'

  interface Emits {
    (e: 'update:modelValue', value: any): void
    (e: 'search'): void
    (e: 'reset'): void
  }

  const emit = defineEmits<Emits>()

  // 定义表单搜索初始值
  const initialSearchState = {
    name: '',
    status: ''
  }

  const searchFormState = ref({ ...initialSearchState })

  // 重置表单
  const handleReset = () => {
    //emit('update:modelValue', { ...initialSearchState })
    searchFormState.value = {
      ...initialSearchState
    }
    handleSearch()
  }

  // 搜索处理
  const handleSearch = () => {
    console.log('搜索参数:', searchFormState.value)
    emit('search')
  }

  // 表单项变更处理
  const handleFormChange = (params: SearchChangeParams): void => {
    console.log('表单项变更:', params)
  }

  // 表单配置项
  const formItems: SearchFormItem[] = [
    {
      label: '角色名称',
      prop: 'name',
      type: 'input',
      config: {
        clearable: true
      },
      onChange: handleFormChange
    },
    {
      label: '角色状态',
      prop: 'status',
      type: 'select',
      config: {
        clearable: true
      },
      options: () => [
        { label: '启用', value: '1' },
        { label: '停用', value: '2' }
      ],
      onChange: handleFormChange
    }
  ]
</script>
