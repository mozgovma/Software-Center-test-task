<script setup>
import { ref } from 'vue';
import { RouterLink, RouterView } from 'vue-router';

// Создаем состояние для отслеживания активного элемента
const activeLink = ref('/');

// Функция для установки активной ссылки
function setActiveLink(link) {
  activeLink.value = link;
}
</script>

<template>
  <div class="main-wrapper">
    <header>
      <div class="heading">
        <h2>Demo Test</h2>
      </div>
      <nav class="navigation">
        <div
          class="nav-item"
          :class="{ active: activeLink === '/profile' }"
          @click="setActiveLink('/profile')"
        >
          <img class="icon" src="/src/assets/user.svg" alt="User">
          <RouterLink to="/profile" class="nav-link">Profile</RouterLink>
        </div>
        <div
          class="nav-item"
          :class="{ active: activeLink === '/' }"
          @click="setActiveLink('/')"
        >
          <img class="icon" src="/src/assets/rim.svg" alt="Vehicles">
          <RouterLink to="/" class="nav-link">Vehicles</RouterLink>
        </div>
        <div
          class="nav-item"
          :class="{ active: activeLink === '/settings' }"
          @click="setActiveLink('/settings')"
        >
          <img class="icon" src="/src/assets/settings.svg" alt="Settings">
          <RouterLink to="/settings" class="nav-link">Settings</RouterLink>
        </div>
      </nav>
    </header>
    <main>
      <RouterView />
    </main>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap');

.main-wrapper {
  display: flex;
}

header {
  background-color: #282828;
  width: 256px;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.heading {
  padding-top: 30px;
  padding-left: 30px;
  color: white;
  font-family: 'DM Sans', sans-serif;
  font-size: 24px;
  font-weight: 700;
}

.navigation {
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin-top: 40px !important;
}

.nav-item {
  display: flex;
  align-items: center;
  transition: background-color 0.3s ease;
  padding: 10px;
  font-family: 'DM Sans', sans-serif;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer; /* Добавляем указатель курсора для интерактивных элементов */
}

.nav-item.active {
  background-color: rgba(255, 255, 255, 0.4); /* Цвет фона для активного элемента */
  color: white;
}
.active-link {
  color: white;
}
.nav-item:hover {
  background-color: rgba(255, 255, 255, 0.2);
}

.icon {
  width: 24px;
  height: 24px;
  margin-right: 16px !important;
}

.nav-link {
  color: rgba(255, 255, 255, 0.45);
  text-decoration: none;
  font-size: 16px;
}

.nav-link:hover {
  color: white;
  text-decoration: none; /* Убираем подчеркивание при наведении на ссылку */
}
</style>
