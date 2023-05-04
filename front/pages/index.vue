<template>
  <div>
    <AddArticle @submit="addArticle" />
    <ArticleList :articles="articles" />
  </div>
</template>
<script>
  import AddArticle from "@/components/AddArticle";
  import ArticleList from "@/components/ArticleList";
  export default {
    components: {
      AddArticle,
      ArticleList,
    },
    data() {
      return {
        articles: [],
      };
    },
    methods: {
      addArticle(title) {
        this.articles.push({
          title
        });
      },
    },
  };
</script>
<style>
</style>