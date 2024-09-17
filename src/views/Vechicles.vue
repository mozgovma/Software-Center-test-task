<template>
  <div class="container">
    <h1>Vehicles</h1>
    <div class="part-from-header">
      <button class="button">+</button>
      <div class="user">
        <img src="/src/assets/Ellipse 13.png" alt="User Avatar">
        <span>John Doe</span>
      </div>
      <div class="language">
        <img src="/src/assets/uk.png" alt="English"> En
      </div>
    </div>
  </div>
  <hr class="thin-line">
  <div class="controls">
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
    <button class="add-vehicle-button">
      <span class="icon">+</span>
      <span>Add Vehicle</span>
    </button>
  </div>
  <div class="card-container">
    <div v-for="car in paginatedCars" :key="car.id" class="card">
      <img :src="car.placeholder" alt="Car Image" v-if="car.photo">
      <div class="car-info">
        <div class="model">{{ car.vehicle_name || 'Unknown Model' }}</div>
        <div class="vin">VIN: {{ car.vin }}</div>
      </div>
      <hr class="thin-line">
      <div class="footer-card-container">
        <div>{{car.angles_count}}/30</div>
        <div>3 days left</div>
      </div>
    </div>
  </div>
  <div class="pagination-controls">
    <button class="pagination-button"  @click="prevPage" :disabled="currentPage === 1"><</button>
    <span class="pagination-info">  {{ currentPage }} / {{ totalPages }} </span>
    <button class="pagination-button" @click="nextPage" :disabled="currentPage === totalPages">></button>
  </div>
</template>






<script setup>
import { ref, onMounted, computed, watch } from 'vue';
import axios from 'axios';

const cars = ref([]);
const searchQuery = ref('');
const vehiclesPerPage = ref(6); 
const currentPage = ref(1); 

async function fetchData() {
  try {
    const response = await axios.get('https://api.caiman-app.de/api/cars-test');
    cars.value = response.data.data;
  } catch (error) {
    console.error('Error fetching data:', error);
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
.footer-card-container{
  display: flex;
  justify-content: space-between;
  font-family: DM Sans;
  font-size: 16px;
  font-weight: 400;
  line-height: 22px;
  text-align: center;
}
.car-details{
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-family: DM Sans;
  font-size: 15px;
  font-weight: 500;
  line-height: 16px;
  text-align: right;
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
}

.model{
  font-family: DM Sans;
  font-size: 20px;
  font-weight: 700;
  line-height: 22px;
  text-align: left;
}
.vin{
  font-family: DM Sans;
  font-size: 15px;
  font-weight: 500;
  line-height: 20px;
  letter-spacing: 0.30000001192092896px;
  text-align: left;
}
.controls {
  display: flex;
  align-items: center;
  justify-content: space-evenly;
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

.thin-line {
  border: none;
  height: 1px;
  background-color: rgba(228, 228, 228, 1);
  width: 100%;
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

.card-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  padding: 20px;
  justify-content: center;
}

.card {
  width: 350px;
  height: 330px;
  border: 1px solid #ccc;
  border-radius: 8px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  padding: 15px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  background-color: #fff;
}

.card img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  object-fit: cover;
}

.car-info {
  margin: 10px 0 !important;
}

.car-info .model {
  font-size: 18px;
  font-weight: bold;
}

.car-info .vin {
  font-size: 14px;
  color: #666;
}

.thin-line {
  border: none;
  height: 1px;
  background-color: #ddd;
  width: 100%;
}
</style>
  