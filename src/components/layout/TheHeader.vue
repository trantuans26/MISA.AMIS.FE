<template>
    <div class="header">
        <div class="header__leftside">
            <div class="header__toggle"
                @click="this.$emit('sidebarToggle', false)"
                v-show="isDisplay"
            ><i class="icon icon--menu"></i></div>

            <div class="header__company">
                <div class="header__companyName">{{this.companyName}}</div>
                <div class="header__companyExtend"><i class="icon icon--angleGrey-right"></i></div>
            </div>
        </div>

        <div class="header__rightside">
            <div class="header__notify" data-title="Thông báo">
                <i class="icon icon--notifyGrey"></i>
            </div>

            <div class="header__employee">
                <div class="header__avatar"><i class="icon icon--avatar"></i></div>
                <div class="header__employeeName">{{this.employeeName}}</div>
                <div class="header__employeeExtend"><i class="icon icon--dropdownGrey-mini"></i></div>
            </div>
        </div>
    </div>
</template>

<script>
import Resource from "@/translations/resource";

export default {
    name: "TheHeader",
    components: {
/*         TheDelete,
        TheLoading,
        BaseMessageError, */
    },
    props: [
        'isDisplay',
    ],
    data() {
        return {
            companyName: Resource.TextVi.Header.CompanyName, // tên Công ty
            employeeName: Resource.TextVi.Header.EmployeeName,
        }
    },
    methods: {

    },
}
</script>

<style scoped>

</style>