<template>
    <span class="table__col--more"
        tabindex="1"
        @click="show = true"
        @blur="hideDropDownFunction()"
    >
        <i class="icon icon--functiondown"></i>
    </span>
    <span class="dropdown dropdown--function" 
        tabindex="1"
        v-show="show"
    >
        <ul class="dropdown__list">
            <li class="dropdown__item">Nhân bản</li>
            <li class="dropdown__item" @click="$emit('showDeleteDialog', true)">Xoá</li>
            <li class="dropdown__item">Ngưng sử dụng</li>
        </ul>
        </span>
</template>
  
<script>

export default {
    name: "BComboboxIcon",
    props: [
        "cbbClass",
        "inputClass",
        "drilldownClass",
        "drilldownItemClass",
        "dropdownClass",
        "filter",
        "tabindex",
    ],
    
    created() {

    },

    updated() {

    },

    watch: {

    },

    methods: {
        hideDrilldown() {
            let me = this;
            setTimeout(() => {
                    me.show = false;
            }, 200); 
        }
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
  