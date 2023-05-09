<template>
  <v-row style="height:100;">
    <v-col
    v-for="(status, index) in statuses"
    :key="index"
    >
      {{ status.name }}
      <v-list style="border-radius:5px;">
        <v-list-item
          v-for="(item, index) in items"
          :key="index"
          style="height:100%;width:100%;padding:10px 0; display:flex; align-items: center;"
        >
        <v-card color="#385F73" dark width="90%" >
          <v-card-subtitle>{{ item.title }}</v-card-subtitle>
          <v-card-text>cardtext
          </v-card-text>
        </v-card>
        </v-list-item>
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
