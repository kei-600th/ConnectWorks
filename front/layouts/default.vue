<template>
  <v-app dark>
    <div>
      <v-app-bar
        app
        color="deep-purple-accent-4"
        dense
        dark
        clippedLeft
      >
        <v-app-bar-nav-icon></v-app-bar-nav-icon>

        <v-btn>MyProject</v-btn>

        <v-spacer></v-spacer>

        <v-btn icon>
          <v-icon>mdi mdi-account-circle</v-icon>
        </v-btn>

      </v-app-bar>


      <v-navigation-drawer
        app
        dark
        clipped
        :width="200"
        v-model="drawer"
      >
        <v-list
          nav
          dense
        >
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