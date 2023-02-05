<template>
    <div class="dropdown__box"
    tabindex="1"
    >
        <div class="btn__dropdown"
            tabindex="1"
            @click="this.isShow = true"
            @blur="this.isShow = false"
        >
            <div class="dropdown dropdown--function" 
                v-if="this.isShow"
            >
                <ul class="dropdown__list">
                    <li class="dropdown__item" @click="onReplicateFunction()"> {{ this.textReplication }}</li>
                    <li class="dropdown__item" @click="showDeleteDialog()"> {{ this.textDelete }}</li>
                    <li class="dropdown__item"> {{ this.textStop }}</li>
                </ul>
            </div>
        </div>
    </div>
</template>
  
<script>
import Resource from "@/lib/resource";

export default {
    name: "btnMore",
    props: {
    },

    created() {

    },

    updated() {
        console.log("isShow updated", this.isShow)

    },

    watch: {

    },

    methods: {
        onReplicateFunction() {
            let me = this;
            me.$emit('onReplicateFunction', true);
            
            setTimeout(() => {
                me.isShow = false;    
            }, 100);
        },

        showDeleteDialog() {
            let me = this;
            
            me.$emit('showDeleteDialog', true);

            setTimeout(() => {
                me.isShow = false;    
            }, 100);
        },
    },

    data() {
        return {
            isShow: false,
            textBatch: Resource.TextVi.Table.Batch,
            textUpdate: Resource.TextVi.Table.Update,
            textReplication: Resource.TextVi.Table.Replicate,
            textDelete: Resource.TextVi.Table.Delete,
            textStop: Resource.TextVi.Table.Stop,
            textRecordPerPage: Resource.TextVi.Table.RecordPerPage,
            textNext: Resource.TextVi.Table.Next,
            textPrevious: Resource.TextVi.Table.Previous,

        };
    },

};

</script>
  
<style scoped>

</style>
  