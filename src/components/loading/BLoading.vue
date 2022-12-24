<template>
  <div class="loading">
      <div class="loader icon icon--loader"></div>
  </div>
</template>


<script>

</script>

<style scoped>
.loading {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    background-color: #fff;
    width: 100%;
    height: 100%;
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
    
}
.loader {
  animation: spin 1.2s linear infinite;
}

@keyframes spin {
  0% { transform: scale(1.6) rotate(0deg); }
  100% { transform: scale(1.6) rotate(360deg); }
}
</style>