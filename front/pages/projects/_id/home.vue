<template>
  <div>
    <SideBar />
    {{ projectName }}
    <TaskList v-if="id !== null" :id="id" :project="project"/>
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
      projectName: "",
      id: null,
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
        this.projectName = res.data.name
        this.project.name = res.data.name
        this.id = id 
        this.project.id = id 
        this.project.tasks = res.data.tasks
        console.log(this.project)
      })
    }
  }
}


</script>
<style></style>