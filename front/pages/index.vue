<template>
  <div>
    <AppBar />
    <TaskList :tasks="tasks" />
  </div>
</template>
<script>
import AppBar from '@/components/AppBar'
import TaskList from '@/components/TaskList'
export default {
  components: {
    AppBar,
    TaskList,
  },
  data() {
    return {
      tasks: [],
    }
  },
  methods: {
    addTask(title) {
      this.tasks.push({
        title,
      })
    },
  },
}
</script>
<style></style>
