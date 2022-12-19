<template>
    <div class="toast">
        <div class="toast__container">
            <div class="toast__icon">
                <i class="icon" :class="this.sucess.icon"></i>
            </div>

            <div class="toast__body">
                <span class="toast__title">
                    {{this.sucess.title}}!
                </span>
                <span class="toast__text">
                    {{this.sucess.text}}.
                </span>
            </div>

            <div class="toast__close"
                @click="this.$emit('closeToast')"
            >
                <i class="icon icon--closeToast"></i>
            </div>
        </div>
    </div>
</template>
  
<script>
// register the plugin on vue


export default {
    name: "BToast",
    props: [
        'employeeID',
        'show',
    ],
    
    beforeCreate() {
    },

    created() {
    },

    watch: {

    },

    methods: {
        insertHTML() {
            if (this.type == "success") {
                this.html += `
                    <div class="toast__container">
                        <div class="toast__icon">
                            <i class="icon" :class="${this.sucess.icon}"></i>
                        </div>

                        <div class="toast__body">
                            <span class="toast__title">
                                ${this.sucess.title}!
                            </span>
                            <span class="toast__text">
                                ${this.sucess.text}.
                            </span>
                        </div>

                        <div class="toast__close"
                            @click="this.html = ''"
                        >
                            <i class="icon icon--closeToast"></i>
                        </div>
                    </div>
                `;
            }
        }
    },

    data() {
        return {
            type: "",
            html: "",
            icon: "",
            title: "",
            text: "",
            sucess: {
                icon: "icon--sucessToast",
                title: "Thành công",
                text: "Nhân viên đã bị xoá",
            },
            warning: {
                icon: "icon--sucessToast",
                title: "Cảnh báo",
                text: "Dữ liệu của bạn đã bị thay đổi bởi người dùng khác",
            }
        };
    },

};

</script>
  
<style scoped>

</style>
  