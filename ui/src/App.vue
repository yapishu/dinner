<template>
  <div id="app">
    <button @click="startRandomCycling" class="random-button" :disabled="buttonDisabled"  :class="{ 'button-disabled': buttonDisabled }">
      SELECT MEAL
    </button>
    <div v-if="showStars" class="stars">✨✨✨✨✨✨✨✨</div>
    <p v-if="selectedItem" style="text-align: center; font-size: 6em; margin-top: 20px;">{{ selectedItem }}</p>
    <div v-if="showStars" class="stars">✨✨✨✨✨✨✨✨</div>
  </div>
</template>

<script>
import { defineComponent, ref } from 'vue';

export default defineComponent({
  setup() {
    const items = ['Whataburger', 'Chick-Fil-A', 'In-n-Out', 'Pizza', 'Asian food', 'Indian food', ];
    const selectedItem = ref('');
    const showStars = ref(false);
    const buttonDisabled = ref(false);

    let intervalId = null;

    function startRandomCycling() {
      buttonDisabled.value = true;
      const cycleDuration = 100;
      let cycles = 20; // Increase for longer effect
      intervalId = setInterval(() => {
        selectedItem.value = items[Math.floor(Math.random() * items.length)];
        cycles--;
        if (cycles <= 0) {
          clearInterval(intervalId);
          showStars.value = true;
          setTimeout(() => showStars.value = false, 1000); // Hide stars after 1 second
        }
      }, cycleDuration);
    }

    return { startRandomCycling, selectedItem, showStars, buttonDisabled };
  }
});
</script>

<style>
body {
  background-color: rgb(46, 46, 46);
}

.random-button {
  height: 150px;
  width: 150px;
  font-size: 24px;
  background-color: red;
  border: 5px solid darkred;
  border-radius: 50%;
  color: white;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  transition: background-color 0.3s, border-color 0.3s;
}

.random-button:hover {
  background-color: #d42c2c;
  border-color: #b20000;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #709ac4;
  margin-top: 60px;
}

.result {
  position: absolute;
  top: calc(50% + 100px); /* Adjusted to move below the button */
  left: 50%;
  transform: translateX(-50%);
  white-space: nowrap; /* Keeps the text and stars aligned in the same line */
}

.selected-item {
  font-size: 4em;
  margin-top: 20px;
}

.stars {
  animation: shootStars 1s forwards;
}

@keyframes shootStars {
  0% { opacity: 0; transform: scale(0.5); }
  50% { opacity: 1; transform: scale(1.5); }
  100% { opacity: 0; transform: scale(0); }
}

.random-button.button-disabled {
  background-color: grey;
  border-color: darkgrey;
  cursor: not-allowed;
}
</style>