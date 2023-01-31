<template>
    <div class="dialog"
    >
        <div class="dialog__box">
<!--             <div class="dialog__close"
                @click="this.$emit('closeDialog', false)"
            >
                <i class="icon icon--closeDialog"></i>
            </div> -->

            <div class="dialog__body">
                <div class="dialog__icon">
                    <slot name="icon">
                        <i class="icon icon--warningDialog"></i>
                    </slot>
                </div>
                <div class="dialog__message">
                    <slot name="message">
                        {{ this.textEmployee + ' <' + message + '> ' + this.textAfter}}
                    </slot>
                </div>
            </div>

            <slot name="footer">
                <div class="dialog__footer">
                    <div class="btn btn--dialog"
                        @click="this.$emit('closeDialog', false), this.$emit('deleteEmployee')"
                    >{{ textDialog.yes }}</div>
                    <div class="btn btn--outline btn--dialog"
                        @click="this.$emit('closeDialog', false)"
                    >{{ textDialog.no }}</div>
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
                yes: Resource.TextVi.Dialog.Yes,
                no: Resource.TextVi.Dialog.No,
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
  