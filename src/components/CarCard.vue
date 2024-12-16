<template>
        <div class="card">
        <img :src="car.placeholder" alt="Car Image" v-if="car.photo">
        <div class="car-info">
            <div class="model">{{ car.vehicle_name || 'Unknown Model' }}</div>
            <div class="vin">VIN: {{ car.vin }}</div>
        </div>
        <hr class="thin-line">
        <div class="footer-card-container">
            <div>{{ car.angles_count }} / 30</div>
            <div>3 days left</div>
        </div>
        </div>
</template>
  
  <script setup>
  defineProps({
    car: Object
  });
  </script>
  
  <style scoped>

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

.car-info {
  margin: 10px 0 !important;
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

.thin-line {
  border: none;
  height: 1px;
  background-color: rgba(228, 228, 228, 1);
  width: 100%;
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



.car-info .model {
  font-size: 18px;
  font-weight: bold;
}

.car-info .vin {
  font-size: 14px;
  color: #666;
}

.card img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  object-fit: cover;
}
  </style>
  