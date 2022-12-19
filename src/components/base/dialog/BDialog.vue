<template>
    <div class="dialog">
        <div class="dialog__box">
            <div class="dialog__body">
                <div class="dialog__icon">
                    <slot name="icon">
                        <i class="icon icon--warning"></i>
                    </slot>
                </div>
                <div class="dialog__message">
                    <slot name="message">
                        Bạn có thực sự muốn xoá Nhân viên &#60;{{message}}&#62; không?
                    </slot>
                </div>
            </div>

            <div class="dialog__footer">
                <slot name="footer">
                    <div class="btn btn--dialog"
                        @click="this.$emit('closeDialog', false), this.$emit('deleteEmployee')"
                    >Có</div>
                    <div class="btn btn--outline btn--dialog"
                        @click="this.$emit('closeDialog', false)"
                    >Không</div>
                </slot>
            </div>
        </div>
    </div>
</template>
  
<script>

export default {
    name: "BDialog",
    props: [
        "message",
    ],
    
    created() {

    },

    updated() {

    },

    watch: {

    },

    methods: {
    },

    data() {
        return {
            show: false,
        };
    },

};

</script>
  
<style scoped>

</style>
  