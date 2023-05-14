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
      :persistent="persistent"
    >
      <v-card
      v-if="!isEditing"
      >
        <v-card-title>
          {{ showTask.name }}
        </v-card-title>
        <v-card-text>
          {{ showTask.status }}
        </v-card-text>
        <v-card-text>
          {{ showTask.describe }}
        </v-card-text>
        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
          color="primary"
          text
          @click="editModal(showTask)"
          >
          編集
          </v-btn>
          <v-btn
            color="error"
            text
            @click="deleteTask()"
          >
          削除
          </v-btn>
          <v-btn
            color="primary"
            text
            @click="dialog = false"
          >
          戻る
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-card
      v-if="isEditing"
      >
        <v-card-title>
          <v-text-field
          v-model=editTask.name
          label="タスク名"
          >
          </v-text-field>
        </v-card-title>
        <v-card-text>
          <v-select
          v-model=editTask.status
          :items="statusNames"
          >
          </v-select>
        </v-card-text>
        <v-card-text>
          <v-textarea
          v-model=editTask.describe>
          </v-textarea>
        </v-card-text>
        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
          color="primary"
          text
          @click="updateTask(editTask)"
          >
          保存
          </v-btn>
          <v-btn
            color="primary"
            text
            @click="cancelEditModal()"
          >
          取消
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
      newTask: [],
      addTaskDisabled: false,
      // タスクの追加ボタンの可否
      dialog: false,
      addingStateId: null,
      // 追加処理中のstatusesの番号
      showTask: {},
      editTask: {},
      isEditing: false,
      persistent: false,
    }
  },
  computed: {
  statusNames() {
    return this.statuses.map((status) => status.name);
  },
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
      this.newTask.push({
        name: '',
        status: this.statuses[index].name,
        project_id: this.project.id,
        isNew: true,
      })
      this.statuses[index].tasks.push(this.newTask[this.newTask.length - 1])
      this.addingStateId = index
      this.addTaskDisabled = true
    },
    async taskSubmit(submitTask) {
      if (submitTask.name !== '') {
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
      this.addingStateId = null
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
      if (this.addingStateId !== null){
        this.cancelAddTask(this.addingStateId)
      }
    },
    editModal(showingTask){
      this.editTask = {...showingTask};
      this.isEditing = true
      this.persistent = true
      
    },
    cancelEditModal(){
      this.isEditing = false
      this.persistent = false
    },
    async updateTask(submitTask){
      if (submitTask.name !== '') {
        try {
          await axios.put(`/v1/tasks/${submitTask.id}`, submitTask)
          this.statuses.name = this.showTask.status
          this.splice()
          const addIndex = this.statuses.findIndex(item => item.name === submitTask.status);
          this.statuses[addIndex].tasks.push(submitTask)
          this.showTask = submitTask
          this.cancelEditModal()
        } catch (error) {
          this.handleError(error)
        }
      } else {
        alert('タスク名を入力してください')
      }
    },
    async deleteTask(){
      try {
      await axios.delete(`/v1/tasks/${this.showTask.id}`, this.showTask)
      this.splice()
      this.dialog = false
      } catch (error) {
        this.handleError(error)
      }
    },
    splice(){
      const deleteStatusIndex = this.statuses.findIndex(item => item.name === this.showTask.status);
      const tasksArray = this.statuses[deleteStatusIndex].tasks;
      const taskIndex = tasksArray.findIndex(task => task.id === this.showTask.id);
      if (taskIndex !== -1) {
        tasksArray.splice(taskIndex, 1);
      }
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
