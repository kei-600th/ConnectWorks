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
          <v-card-subtitle>
            <v-text-field
              v-if="task.isNew"
              v-model="task.name"
              label="新規のタスク">
            </v-text-field>
            <template v-else>
              {{ task.name }}
            </template>
          </v-card-subtitle>
          <v-card-text v-if="task.isNew">
            <v-btn
            color="#385F73"
            @click="taskSubmit"
            >
            追加
            </v-btn>
          </v-card-text>
        </v-card>
        <v-btn @click="addTask(statusIndex)">タスクの追加</v-btn>
      </v-list>
    </div>
  </div>
</template>

<script>
import axios from '@/plugins/axios'
export default {
  props: {
  project: {
    type: Object,
    default: function() {
      return {
        id: null,
        name: "",
        tasks: [],
      }
    },
  },
},
  data() {
    return {
      statuses: [
        { name: '未実施', tasks: [] },
        { name: '実施中', tasks: [] },
        { name: '実施済み', tasks: [] },
        { name: '完了', tasks: [] },
      ],
      newTask : { name: '', status: '', project_id: null, isNew: null}
    }
  },
  created() {
    this.project.tasks.forEach(task => {
      const status = this.statuses.find(status => status.name === task.status);
      if (status) {
        status.tasks.push(task);
      }
    });
  },
  methods: {
    addTask(index) {
      this.newTask = { name: '新しいタスク', status: this.statuses[index].name,project_id:this.project.id, isNew: true}; // タスクの初期値
      this.statuses[index].tasks.push(this.newTask);
    },
    async taskSubmit() {
      await axios.post('/v1/tasks', this.newTask)
      this.newTask.isNew = null;
      this.$emit('taskSubmitted');
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
