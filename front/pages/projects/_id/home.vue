<template>
  <div>
    <SideBar />
    {{ project.name }}
    <TaskList
      v-if="isProjectLoaded"
      :project="project"
      @taskSubmitted="getProject"
    />
  </div>
</template>
<script>
import axios from '@/plugins/axios'
import SideBar from '@/components/SideBar'
import TaskList from '@/components/TaskList'

export default {
  components: {
    SideBar,
    TaskList,
  },
  data() {
    return {
      project: {
        id: null,
        name: '',
      },
    }
  },
  computed: {
    isProjectLoaded() {
      return this.project.id !== null
    },
  },
  mounted() {
    this.getProject()
  },
  methods: {
    async getProject() {
      const id = Number(this.$route.params.id)
      try {
        const { data } = await axios.get(`/v1/projects/${id}`)
        this.project = data
      } catch (error) {
        throw new Error(error)
      }
    },
  },
}
</script>
<style></style>
