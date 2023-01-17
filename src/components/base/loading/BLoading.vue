<template>
  <div class="loading" :class="loadingClass">
      <div class="loader icon icon--loader"></div>
  </div>
</template>


<script>

export default {
  props: [
    'loadingClass',
  ],
}

</script>

<style>
.loading {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    background-color: #fff;
    width: 100%;
    height: 100%;
    z-index: 5;
    display: flex;
    align-items: center;
    justify-content: center;
    
}

.loading--table {
  background-color: rgba(0, 0, 0, 0.02);
}

.loading--modal {
  background-color: rgba(0, 0, 0, 0.02);
}

.loader {
  animation: spin 1.2s linear infinite;
}

@keyframes spin {
  0% { transform: scale(1.6) rotate(0deg); }
  100% { transform: scale(1.6) rotate(360deg); }
}
</style>