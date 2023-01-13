<template>
    <div class="message--hasError" hidden>
        <slot name="message"> {{text}} không được để trống </slot>
    </div>
</template>

<script>
export default {
    props:["text"]
}
</script>

<style scoped>
    @import url('../../../style/component/messageError.css');
</style>