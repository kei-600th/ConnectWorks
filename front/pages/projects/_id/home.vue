<template>
  <div>
    <SideBar />
    {{ project.name }}
    <TaskList v-if="project.id !== null" :project="project"  @taskSubmitted="getProject"/>
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
      project:{
        id: null, name: "", tasks: []
      }
    }
  },
  mounted() {
    this.getProject()
  },
  methods: {
    async getProject() {
      const id = Number(this.$route.params.id)
      await axios.get(`/v1/projects/${id}`).then((res) => {
        this.project.name = res.data.name
        this.project.id = id 
        this.project.tasks = res.data.tasks
      })
    }
  }
}


</script>
<style></style>