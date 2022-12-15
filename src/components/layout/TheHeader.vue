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
import Resource from "@/lib/resource";

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

            year: {
                show: false,
                value: 2022,
                list: [2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022]
            }
        }
    },
    methods: {
        /* Chọn năm hiển thị
            @param {year}
            @returns void
            Author: Tuan 
            Date: 7/11/2022 
        */
        selectYear(option) {
            this.year.value = option;
        },

    },
}
</script>

<style scoped>

</style>