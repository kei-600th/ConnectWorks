<template>
  <v-card>
    <v-card-title>
      Task List
      <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        label="Search"
        single-line
        hide-details
      ></v-text-field>
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="tasks"
      :search="search"
    ></v-data-table>
  </v-card>
</template>

<script>
export default {
  props: ['tasks'],
  data() {
    return {
      search: '',
      headers: [
        {
          text: 'タイトル',
          align: 'left',
          sortable: false,
          value: 'title',
        },
        { text: 'ユーザー名', value: 'username' },
      ],
    }
  },
}
</script>

<style></style>