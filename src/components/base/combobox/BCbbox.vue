<template>
    <div class="modal__input--dropdown" 
    >
        <input class="input input--haveicon input--modal" type="text"
            :ref="cbbRef" 
            :placeholder="cbbPlaceholder"
            :maxlength="cbbMaxLength"
            :class="{'input--error': this.isShowValidity.emptyDepartmentID && !this.employeeModal.departmentName, 'input--focused': isShowDropdownDepartment}"
            :v-model="departmentName"
            @blur="isShow = false"
        >
        <base-message-error :text="this.textDepartmentName"></base-message-error>
        <div class="item--caretdown" 
            tabindex="1"
            @click="isShow = !isShow"
            @blur="isShow = false, this.$emit('validate', true)"
        >
            <i class="icon icon--caretdown"
                :class="{'icon--caretdownRotate' : isShow}"
            ></i>
        </div>
        <span class="dropdown dropdown--department" 
            v-show="isShow"
        >
            <ul class="dropdown__list">
                <li class="dropdown__item"
                > 
            
                </li>
                <li class="dropdown__item"
                    v-for="(department) in this.departments"
                    :key="department.departmentName"
                    @click="selectDepartment(department)"
                    :class="{'dropdown__item--selected': $emit(checkDepartmentSelected, department)}"
                >
                    <p>{{ department.departmentName }} </p>  
                </li>
            </ul>
        </span>
    </div>
</template>
  
<script>

export default {
    name: "BCbbox",
    props: [
        "cbbClass",
        "inputClass",
        "drilldownClass",
        "drilldownItemClass",
        "dropdownClass",
        "filter",
        "tabindex",
        "cbbBlur",
        "cbbClick",
        "cbbPlaceholder",
        "cbbRef",
        "cbbMaxLength",
        "cbbValidate",
        "departments",
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
                    me.isShow = false;
            }, 200); 
        }
    },

    data() {
        return {
            isShow: false,
            departmentName: this.$parent.employeeModal.departmentName,
        };
    },

};

</script>
  
<style scoped>

</style>
  