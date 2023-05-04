<template>
  <div>
    <TaskList :tasks="tasks" />
  </div>
</template>
<script>
  import TaskList from "@/components/TaskList";
  export default {
    components: {
      TaskList,
    },
    data() {
      return {
        tasks: [],
      };
    },
    methods: {
      addTask(title) {
        this.tasks.push({
          title
        });
      },
    },
  };
</script>
<style>
</style>