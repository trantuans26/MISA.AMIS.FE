<template>
    <div class="dialog">
        <div class="dialog__box">
            <div class="dialog__close"
                @click="this.$emit('closeDialog', false)"
            >
                <i class="icon icon--closeDialog"></i>
            </div>

            <div class="dialog__body">
                <div class="dialog__title">
                    <slot name="title">
                        {{ this.textDialog.title.delete }}
                    </slot>
                </div>
                <div class="dialog__message">
                    <slot name="message">
                        {{ this.textEmployee + ' &#60;' + message + '&#62; ' + this.textAfter}}
                    </slot>
                </div>
            </div>

            <slot name="footer">
                <div class="dialog__footer">
                    <div class="btn btn--dialog btn--red"
                        @click="this.$emit('closeDialog', false), this.$emit('deleteEmployee')"
                    >{{ textDialog.delete }}</div>
                    <div class="btn btn--outline btn--dialog"
                        @click="this.$emit('closeDialog', false)"
                    >{{ textDialog.cancel }}</div>
                </div>
            </slot>
        </div>
    </div>
</template>
  
<script>
import Resource from "@/lib/resource";

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

            textDialog: {
                close: Resource.TextVi.Dialog.Close,
                save: Resource.TextVi.Dialog.Save,
                cancel: Resource.TextVi.Dialog.Cancel,
                delete: Resource.TextVi.Dialog.Delete,
                title: {
                    delete: Resource.TextVi.Dialog.Title.Delete,
                }
            },

            textEmployee: Resource.TextVi.Dialog.Text.Employee,
            textAfter: Resource.TextVi.Dialog.Text.After,
        };
    },

};

</script>
  
<style scoped>

</style>
  