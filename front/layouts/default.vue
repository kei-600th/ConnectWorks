<template>
  <v-app dark>
    <div>
      <v-app-bar app color="deep-purple-accent-4" dense dark clipped-left>
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
        <v-toolbar-title>ConnectWorks</v-toolbar-title>
          <v-menu offset-y nudge-bottom="16px" :close-on-content-click="closeOnContentClick">
            <template #activator="{ on, attrs }">
              <!-- ボタンを押すとドロップダウンメニューが展開される -->
              <v-btn
                color="primary"
                dark
                v-bind="attrs"
                v-on="on"
              >
                プロジェクト
              </v-btn>
            </template>
            <v-card width="300px">

              <v-list>
                <v-list-item
                  v-for="(item, index) in items"
                  :key="index"
                >
                  <v-list-item-title>{{ item.title }}</v-list-item-title>
                </v-list-item>
              </v-list>

              <!-- ここにプロジェクト作成用ボックスを作成する -->
              <v-text-field 
              label="プロジェクト作成"
              required>
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

      <v-navigation-drawer app dark clipped :width="200">
        <v-list nav dense>
          <v-list-item>
            <v-list-item-title>タスクの追加</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>タスク一覧</v-list-item-title>
          </v-list-item>
          <v-list-item>
            <v-list-item-title>ドキュメント</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>

      <v-main>
        <Nuxt />
      </v-main>
    </div>
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      items: [
        { title: 'プロジェクト1' },
        { title: 'プロジェクト2' },
        { title: 'プロジェクト3' },
        { title: 'プロジェクト4' },
      ],
      closeOnContentClick: false,
    }),
    methods: {
      handleSubmit() {
        console.log("hello");
      }
    }
  }
</script>
