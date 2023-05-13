<template>
  <div>
    <div class="status-container">
      <div
        v-for="(status, statusIndex) in statuses"
        :key="statusIndex"
        class="status-column"
      >
        {{ status.name }}
        <v-list class="rounded-list">
          <div
          v-for="(task, taskIndex) in status.tasks"
          :key="taskIndex"
          >
            <v-card
              v-if="task.isNew !== true"
              color="#385F73"
              class="styled-card"
              @click="showModal(task)"
            >
              <v-card-subtitle>
                {{ task.name }}
              </v-card-subtitle>
            </v-card>
            <v-card
              v-if="task.isNew"
              color="#385F73"
              class="styled-card">
              <v-card-subtitle>
                <v-text-field
                    v-model="task.name"
                    label="新規のタスク"
                  >
                </v-text-field>
              </v-card-subtitle>
              <v-card-actions>
                <v-btn color="#385F73" @click="taskSubmit(task)"> 追加 </v-btn>
                <v-btn color="#37474F" @click="cancelAddTask(statusIndex)">
                  取消
                </v-btn>
              </v-card-actions>
            </v-card>
          </div>
          <v-btn :disabled="addTaskDisabled" @click="addTask(statusIndex)"
            >タスクの追加</v-btn
          >
        </v-list>
      </div>
    </div>


    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <v-card-title>
          {{ showTask.name }}
        </v-card-title>

        <v-card-text>
          タスクの説明を表示
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="primary"
            text
            @click="dialog = false"
          >
            I accept
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

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
        name: '',
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
      newTask: { name: '', status: '', project_id: null, isNew: null },
      addTaskDisabled: false,
      dialog: false,
      addingStateId: null,
      showTask: {}
    }
  },
  created() {
    this.project.tasks.forEach((task) => {
      const status = this.statuses.find((status) => status.name === task.status)
      if (status) {
        status.tasks.push(task)
      }
    })
  },
  methods: {
    addTask(index) {
      this.newTask = {
        name: '',
        status: this.statuses[index].name,
        project_id: this.project.id,
        isNew: true,
      } // タスクの初期値
      this.statuses[index].tasks.push(this.newTask)
      this.addingStateId = index
      this.addTaskDisabled = true
    },
    async taskSubmit(submitTask) {
      if (this.newTask.name !== '') {
        try {
          await axios.post('/v1/tasks', submitTask)
          submitTask.isNew = null
          this.addTaskDisabled = false
          this.$emit('taskSubmitted')
        } catch (error) {
          this.handleError(error)
        }
      } else {
        alert('タスク名を入力してください')
      }
    },
    cancelAddTask(index) {
      this.statuses[index].tasks.pop()
      this.addTaskDisabled = false
    },
    handleError(error) {
      if (error.response && error.response.data) {
        const messages = Object.values(error.response.data)
        alert(`Error: ${messages.join(', ')}`)
      } else {
        alert('Error: タスクの作成に失敗しました。')
      }
    },
    showModal(clickedTask){
      this.showTask = clickedTask
      this.dialog = true
      this.cancelAddTask(this.addingStateId)
    }
  },
}
</script>

<style scoped>
.status-container {
  display: flex;
}

.status-column {
  flex: 1;
  margin-right: 10px;
}

.rounded-list {
  border-radius: 5px;
}

.styled-card {
  width: 90%;
  margin: 20px auto;
}
</style>
