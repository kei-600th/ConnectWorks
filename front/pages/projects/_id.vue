<template>
  <div>
    <SideBar />
    {{ projectName }}
  </div>
</template>
<script>
import axios from '@/plugins/axios'
import SideBar from '@/components/SideBar'

export default {
  components: {
    SideBar,
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