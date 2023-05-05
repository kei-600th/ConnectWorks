<template>
  <v-app dark>
    <div>
      <v-app-bar app color="deep-purple-accent-4" dense dark clipped-left>
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
        <v-toolbar-title>ConnectWorks</v-toolbar-title>

        

          <v-menu offset-y nudge-bottom="16px">
            <template #activator="{ on, attrs }">
              <v-btn
                color="primary"
                dark
                v-bind="attrs"
                v-on="on"
              >
                プロジェクト
              </v-btn>
            </template>
            <v-list>
              <v-list-item
                v-for="(item, index) in items"
                :key="index"
              >
                <v-list-item-title>{{ item.title }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>


        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon>mdi mdi-account-circle</v-icon>
        </v-btn>
      </v-app-bar>

      <v-navigation-drawer v-model="drawer" app dark clipped :width="200">
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
        { title: 'Click Me' },
        { title: 'Click Me' },
        { title: 'Click Me' },
        { title: 'Click Me 2' },
      ],
    }),
  }
</script>
