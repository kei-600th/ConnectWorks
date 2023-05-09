<template>
  <v-row >
    <v-col
    v-for="(status, index) in statuses"
    :key="index"
    >
      {{ status.name }}
      <v-list style="border-radius:5px;">
        <v-card 
        v-for="(item, index) in items"
        :key="index"
        color="#385F73" dark width="90%" 
        style="margin:10px">
          <v-card-subtitle>{{ item.title }}</v-card-subtitle>
          <v-card-text>cardtext
          </v-card-text>
        </v-card>
      </v-list>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      items: [
        { title: 'コードを書く' },
        { title: 'テストコードを書く' },
        { title: 'コードレビューをする' },
        { title: 'リファクタリングする' },
        { title: 'リファクタリングする' },
        { title: 'リファクタリングする' },
        { title: 'リファクタリングする' },
        { title: 'リファクタリングする' },
        { title: 'リファクタリングする' },
        
      ],
      statuses: [
        { name: '未実施' },
        { name: '実施中' },
        { name: '実施済み' },
        { name: '完了' },
      ],
    }
  },
}
</script>

<style></style>
