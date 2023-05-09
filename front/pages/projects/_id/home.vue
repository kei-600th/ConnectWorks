<template>
  <div>
    <SideBar />
    {{ projectName }}
    <TaskList :tasks="tasks" />
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
    }
  },
  mounted() {
    this.getProject()
  },
  methods: {
    async getProject() {
      const id = this.$route.params.id
      await axios.get(`/v1/projects/${id}`).then((res) => {
        this.projectName = res.data.name
      })
    }
  }
}


</script>
<style></style>