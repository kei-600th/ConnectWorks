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
          <v-card-actions v-if="task.isNew">
            <v-btn
            color="#385F73"
            @click="taskSubmit"
            >
            追加
            </v-btn>
            <v-btn
            color="#37474F"
            @click="cancelAddTask(statusIndex)"
            >
            取消
            </v-btn>
          </v-card-actions>
        </v-card>
        <v-btn :disabled="addTaskDisabled" @click="addTask(statusIndex)">タスクの追加</v-btn>
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
    default: () => ({
      id: null,
      name: "",
      tasks: [],
    }),
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
      newTask : { name: '', status: '', project_id: null, isNew: null},
      addTaskDisabled: false
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
      this.addTaskDisabled = true;
    },
    async taskSubmit() {
      if (this.newTask.name !== '') {
      try {
        await axios.post('/v1/tasks', this.newTask)
        this.newTask.isNew = null;
        this.addTaskDisabled = false
        this.$emit('taskSubmitted');
        } catch (error) {
          this.handleError(error);
        }
      } else {
        alert('タスク名を入力してください')
      }
    },
    cancelAddTask(index){
      this.statuses[index].tasks.pop();
      this.addTaskDisabled = false
    },
    handleError(error) {
      if (error.response && error.response.data) {
        const messages = Object.values(error.response.data);
        alert(`Error: ${messages.join(', ')}`);
      } else {
        alert('Error: タスクの作成に失敗しました。');
      }
    }
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
