<template>
    <div class="toast">
        <div class="toast__container">
            <div class="toast__icon">
                <i class="icon" :class="this.sucess.icon"></i>
            </div>

            <div class="toast__body">
                <span class="toast__title">
                    <slot name="title">
                        {{this.sucess.title}}!
                    </slot>
                </span>
                <span class="toast__text">
                    <slot name="text">
                        {{this.sucess.text}}.
                    </slot>
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
                title: "Th??nh c??ng",
                text: "Nh??n vi??n ???? b??? xo??",
            },
            warning: {
                icon: "icon--sucessToast",
                title: "C???nh b??o",
                text: "D??? li???u c???a b???n ???? b??? thay ?????i b???i ng?????i d??ng kh??c",
            }
        };
    },

};

</script>
  
<style scoped>

</style>
  