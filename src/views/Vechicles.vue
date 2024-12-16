<template>
  <Header />
  <div class="controls">
  <div class="inpt">
    <input
      type="text"
      class="search-input"
      placeholder="Search VIN"
      v-model="searchQuery"
    >
    <div class="select-container">
      <label class="heading-select-input" for="vehicles-per-page">Select vehicles per page:</label>
      <select id="vehicles-per-page" class="select-input" v-model="vehiclesPerPage">
        <option value="9">9</option>
        <option value="6">6</option>
        <option value="3">3</option>
      </select>
    </div>
  </div>
    <button class="add-vehicle-button">
      <span class="icon">+</span>
      <span>Add Vehicle</span>
    </button>
  </div>
  <div class="card-container">
    <CarCard v-for="car in paginatedCars" :key="car.id" :car="car" />
  </div>
  <div v-if="error">{{ error }}</div>
  <div class="pagination-controls">
    <button class="pagination-button"  @click="prevPage" :disabled="currentPage === 1"><</button>
    <span class="pagination-info">  {{ currentPage }} / {{ totalPages }} </span>
    <button class="pagination-button" @click="nextPage" :disabled="currentPage === totalPages">></button>
  </div>
</template>






<script setup>
import { ref, onMounted, computed, watch } from 'vue';
import axios from 'axios';
import Header from '../components/Header.vue'; // Убедись, что путь правильный
import CarCard from '../components/CarCard.vue'

const cars = ref([]);
const searchQuery = ref('');
const vehiclesPerPage = ref(6); 
const currentPage = ref(1); 
const error = ref(null);

async function fetchData() {
  try {
    const response = await axios.get('https://api.caiman-app.de/api/cars-test');
    cars.value = response.data.data;
  } catch (err) {
    error.value = "Не удалось загрузить данные.";
    console.error('Error fetching data:', err);
  }
}

onMounted(() => {
  fetchData();
});


watch(vehiclesPerPage, (newValue) => {
  vehiclesPerPage.value = Number(newValue);
  currentPage.value = 1;
});

const filteredCars = computed(() => {
  if (!searchQuery.value) return cars.value;
  const query = searchQuery.value.toLowerCase();
  return cars.value.filter(car => car.vin.toLowerCase().includes(query));
});

const totalPages = computed(() => {
  return Math.ceil(filteredCars.value.length / vehiclesPerPage.value);
});

const paginatedCars = computed(() => {
  const start = (currentPage.value -1) * vehiclesPerPage.value;
  const end = start + vehiclesPerPage.value;
  return filteredCars.value.slice(start, end);
});


function nextPage() {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
  }
}

function prevPage() {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap');

.pagination-button{
  border: none;
  background-color: #eee;
  border-radius: 4px;
  width: 30px;
  height: 30px;
  font-size: 18px;
  color: #333;
  cursor: pointer;
  transition: background-color 0.3s, transform 0.3s;
}
.inpt{
  display: flex;
    gap: 40px;
}

.pagination-controls{
  display: flex;
  align-items: center;
  justify-content: flex-end;
  margin: 0px 10px 0px 0px !important;
}
.pagination-info{
  font-family: DM Sans;
  font-size: 16px;
  font-weight: 400;
  line-height: 22px;
  text-align: center;
}

.heading-select-input{
  font-family: DM Sans;
  font-size: 16px;
  font-weight: 400;
  line-height: 22px;
  text-align: center;
}

.container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 25px;
  font-family: DM Sans;
  font-size: 16px;
  font-weight: 400;
  line-height: 22px;
  text-align: center;
  height: 100px;
}

.controls {
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding-top: 20px;
}

h1 {
  margin-left: 50px;
}

.part-from-header {
  display: flex;
  align-items: center;
  gap: 20px;
}

.button {
  width: 30px;
  height: 30px;
  border: 1px solid rgba(232, 110, 132, 1);
  border-radius: 5px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  color: rgba(232, 110, 132, 1);
  background-color: transparent;
  cursor: pointer;
  box-sizing: border-box;
}

.button:hover {
  background-color: rgba(232, 110, 132, 0.1);
}

.user, .language {
  display: flex;
  align-items: center;
  gap: 10px;
}

.search-input {
  width: 350px;
  height: 40px;
  padding: 0 10px;
  border: 1px solid rgba(228, 228, 228, 1);
  border-radius: 4px;
  box-sizing: border-box;
  font-family: DM Sans;
  font-size: 16px;
  font-weight: 400;
  line-height: 22px;
  text-align: left;

}

.select-container {
  display: flex;
  align-items: center;
  gap: 10px;
}

.select-input {
  height: 30px;
  border: 1px solid rgba(228, 228, 228, 1);
  border-radius: 4px;
  font-size: 14px;
  padding: 0 5px;
  box-sizing: border-box;
}

.add-vehicle-button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 180px;
  height: 40px;
  background-color: rgba(217, 14, 50, 1);
  border: none;
  border-radius: 6px;
  color: #FFFFFF;
  font-size: 16px;
  cursor: pointer;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  gap: 8px;
}

.add-vehicle-button .icon {
  font-size: 20px;
  font-weight: bold;
}

.add-vehicle-button:hover {
  background-color: #d9433e;
}

.pagination-button:disabled {
  background-color: #ddd;
  cursor: not-allowed;
}

.card-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  padding: 20px;
  justify-content: center;
}
</style>
  