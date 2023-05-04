<template>
  <v-app dark>
    <div>
      <v-app-bar
        color="deep-purple-accent-4"
        dense
        dark
      >
        <v-app-bar-nav-icon></v-app-bar-nav-icon>

        <v-btn>プロジェクト</v-btn>

        <v-spacer></v-spacer>

        <v-btn icon>
          <v-icon>mdi mdi-account-circle</v-icon>
        </v-btn>

      </v-app-bar>

      
      <Nuxt />
    </div>
  </v-app>
</template>