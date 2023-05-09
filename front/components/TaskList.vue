<template>
  <div class="status-container">
    <div
      v-for="(status, statusIndex) in statuses"
      :key="statusIndex"
      class="status-column"
    >
      {{ status.name }}
      <v-list style="border-radius:5px;">
        <v-card 
          v-for="(task, taskIndex) in status.tasks"
          :key="taskIndex"
          color="#385F73" dark width="90%" 
          style="margin:20px auto;"
        >
          <v-card-subtitle>{{ task.title }}</v-card-subtitle>
          <v-card-text>cardtext</v-card-text>
        </v-card>
        <v-btn @click="addTask(statusIndex)">タスクの追加</v-btn>
      </v-list>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      statuses: [
        { name: '未実施', tasks: [] },
        { name: '実施中', tasks: [] },
        { name: '実施済み', tasks: [] },
        { name: '完了', tasks: [] },
      ],
    }
  },
  methods: {
    addTask(index) {
      const newTask = { title: '新しいタスク' }; // タスクの初期値
      this.statuses[index].tasks.push(newTask);
    },
  },
}
</script>

<style>
.status-container {
  display: flex;
}

.status-column {
  flex: 1;
  margin-right: 10px;
}
</style>
