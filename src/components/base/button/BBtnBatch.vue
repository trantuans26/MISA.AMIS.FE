<template>
    <button class="btn btn__batch"
        :class="{'btn__batch--actived': this.employeesSelectedByID.length > 1}"
        @click="isShow = !isShow"
        @blur="isShow = false"
    >
        <div class="btn__batch--content">
            {{ this.textBatch }}
            <div class="btn__batch--icon">
                <i class="icon icon__grey--caretdown"
                    :class="{'icon__black--caretdown': this.employeesSelectedByID.length > 1}"
                ></i>
            </div>
        </div>

        <ul class="btn__dropdown--list"
         v-show="isShow && this.employeesSelectedByID.length"
        >
            <div>
                <li class="btn__dropdown--item dropdown--item"
                    @click="deleteBatch()"
                >
                    <a class="btn__dropdown--text">
                        {{ this.textDelete }}
                    </a>
                </li>
            </div>
        </ul>
    </button>
</template>
  
<script>
import Resource from "@/lib/resource";

export default {
    name: "btnBatch",
    props: {
        employeesSelectedByID: [],
    },

    created() {

    },

    updated() {

    },

    watch: {

    },

    methods: {
        deleteBatch() {
            let me = this;
            
            me.$emit('deleteBatch', true);
        },
    },

    data() {
        return {
            isShow: false,
            textDelete: Resource.TextVi.Table.Delete,
            textBatch: Resource.TextVi.Table.Batch,

        };
    },

};

</script>
  
<style scoped>

</style>
  