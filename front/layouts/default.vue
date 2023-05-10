<template>
  <v-app dark >
      <v-app-bar app color="deep-purple-accent-4" dense dark clipped-left>
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
        <v-toolbar-title>ConnectWorks</v-toolbar-title>
        <v-menu
          offset-y
          nudge-bottom="16px"
          :close-on-content-click="closeOnContentClick"
        >
          <template #activator="{ on, attrs }">
            <v-btn color="primary" dark v-bind="attrs" v-on="on">
              プロジェクト
            </v-btn>
          </template>
          <v-card width="300px">
            <v-list>
              <v-list-item v-for="(project, index) in projects" :key="index" :to="`/projects/${project.record.id}/home`">
                <v-list-item-title>{{ project.record.name }}</v-list-item-title>
              </v-list-item>
            </v-list>
            <v-text-field
              v-model="newProject.name"
              label="プロジェクト作成"
              required
            >
              <template #append-outer>
                <v-btn color="primary" @click="handleSubmit">作成</v-btn>
              </template>
            </v-text-field>
          </v-card>
        </v-menu>
        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon>mdi mdi-account-circle</v-icon>
        </v-btn>
      </v-app-bar>
      <v-main >
        <Nuxt />
      </v-main>
  </v-app>
</template>

<script>
import axios from '@/plugins/axios'

export default {
  data() {
    return {
      projects: [],
      closeOnContentClick: false,
      newProject: { name: '' },
    }
  },
  mounted() {
    this.getProjects()
  },
  methods: {
    async getProjects() {
      const { data } = await axios.get('/v1/projects');
      this.projects = data.map((data) => ({ record: data }));
    },

    async handleSubmit() {
      if (this.newProject.name !== '') {
        try {
          await axios.post('/v1/projects', this.newProject)
          this.newProject.name = ''
          await this.getProjects()
        } catch (error) {
          this.handleError(error);
        }
      } else {
        alert('プロジェクト名を入力してください')
      }
    },
    handleError(error) {
      if (error.response && error.response.data) {
        const messages = Object.values(error.response.data);
        alert(`Error: ${messages.join(', ')}`);
      } else {
        alert('Error: プロジェクトの作成に失敗しました。');
      }
    },
  },
}
</script>
