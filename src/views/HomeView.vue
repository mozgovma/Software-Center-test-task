<template>
  <Header />
  <div class="about">
    <h1>404 not found</h1>
  </div>
</template>

<script>
 import Header from '../components/Header.vue'; // Убедись, что путь правильный

export default {
  components: {
    Header,
  },
};
</script>

<style>
@media (min-width: 1024px) {
  .about {
    display: flex;
    align-items: center;
  }
}
</style>
