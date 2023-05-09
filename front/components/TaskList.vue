<template>
  <div class="status-container">
    <div
      v-for="(status, index) in statuses"
      :key="index"
      class="status-column"
    >
      {{ status.name }}
      <v-list style="border-radius:5px;">
        <v-card 
          v-for="(item, index) in items"
          :key="index"
          color="#385F73" dark width="90%" 
          style="margin:20px auto;"
        >
          <v-card-subtitle>{{ item.title }}</v-card-subtitle>
          <v-card-text>cardtext</v-card-text>
        </v-card>
      </v-list>
    </div>
  </div>
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

<style>
.status-container {
  display: flex;
}

.status-column {
  flex: 1;
  margin-right: 10px;
}
</style>
