<template>
    <div class="content"
        @keydown="keyboardShortcuts"
    >
        <div class="content__header">
            <div class="content__title">{{this.contentTitle}}</div>
            <button class="btn btn--add"
                @click="isDisplayModal = true, updateFunction = false, replicateFunction = false"
            >{{this.contentAdd}}</button>
        </div>

        <div class="content__body">
            <div class="table__function">
                <div class="table__batch">
                    <btnBatch
                        :employeesSelectedByID="this.employeesSelectedByID"
                        @deleteBatch="this.isShowDeleteBatchDialog = true"
                    ></btnBatch>
                </div>

                <div class="table__search">
                    <input class="input input--search"
                        type="text" :placeholder="this.textSearchPlaceholder"
                        v-model.trim="this.filter.employeeFilter"
                        v-on:keyup.enter="this.currentPage = 1, loadAPI()"
                    >
                    <i class="icon icon--search" @click="this.currentPage = 1, loadAPI()"></i>
                </div>

                <div class="table__reset"
                    :data-title="textTooltip.reload"
                    @click="this.currentPage = 1, loadAPI()"
                >
                    <i class="icon icon--reset"></i>
                </div>

                <div class="table__exportExcel"
                    :data-title="textTooltip.exportExcel"
                    @click="apiExportExcel()"
                >
                    <i class="icon icon--excel"></i>
                </div>

                <div class="table__space--20grey"></div>
            </div>

            <div class="table">
                <div class="table__space--20white"></div>
                <div class="table__space--10grey"></div>
                <div class="table__space--20whiteRight"></div>
                <table class="table__scroll">
                    <div class="table__header">
                        <table>
                            <thead>
                                <th class="table__col table__col--center table__col--check">
                                    <input type="checkbox" v-model='selectAllEmployees'>
                                </th>
                                <th class="table__col table__col--left table__col--employeeCode">{{this.textEmployeeCode}}</th>
                                <th class="table__col table__col--left table__col--employeeName">{{this.textEmployeeName}}</th>
                                <th class="table__col table__col--left table__col--gender">{{this.textGender}}</th>
                                <th class="table__col table__col--center table__col--birthday">{{this.textBirthday}}</th>
                                <th class="table__col table__col--left table__col--identity" :data-title="textTooltip.identityNumber">{{this.textIdentity}}</th>
                                <th class="table__col table__col--left table__col--positionName">{{this.textRole}}</th>
                                <th class="table__col table__col--left table__col--departmentName">{{this.textOrganizationName}}</th>
                                <th class="table__col table__col--left table__col--bankNumber">{{this.textBankNumber}}</th>
                                <th class="table__col table__col--left table__col--bankName">{{this.textBankName}}</th>
                                <th class="table__col--left table__col--bankBranch" :data-title="textTooltip.bankBranch">{{this.textBankBranch}}</th>
                                <th class="table__col--center table__col--function">{{this.textFunction}}</th>
                            </thead>
                        </table>
                    </div>

                    <div class="table__body">
                        <table>
                            <tbody>
                                <tr 
                                    class="table__row" 
                                    tabindex="1"
                                    v-for="(employee) in this.employees"
                                    :key="employee"
                                    :class="{'table__row--checked': checkEmployee(employee.employeeID)}"                                     
                                    @click="selectEmployee(employee)"
                                    @blur="deselectEmployee"
                                >
                                    <td class="table__col table__col--center table__col--check">
                                        <input type="checkbox" 
                                            :checked="checkEmployee(employee.employeeID)"
                                            @click="clickCheckEmployee(employee)"
                                        >
                                    </td>
                                    <td class="table__col table__col--left table__col--employeeCode" @dblclick="onUpdateFunction(employee)"> <p>{{employee.employeeCode}}</p> </td>
                                    <td class="table__col table__col--left table__col--employeeName" @dblclick="onUpdateFunction(employee)"> <p>{{employee.employeeName}}</p> </td>
                                    <td class="table__col table__col--left table__col--gender" @dblclick="onUpdateFunction(employee)"> <p>{{this.formatGender(employee.gender)}}</p> </td>
                                    <td class="table__col table__col--center table__col--birthday" @dblclick="onUpdateFunction(employee)"> <p>{{formatDate(employee.dateOfBirth)}}</p> </td>
                                    <td class="table__col table__col--left table__col--identity" @dblclick="onUpdateFunction(employee)"> <p>{{employee.identityNumber}}</p> </td>
                                    <td class="table__col table__col--left table__col--positionName" @dblclick="onUpdateFunction(employee)"> <p>{{employee.jobPosition}}</p> </td>
                                    <td class="table__col table__col--left table__col--departmentName" @dblclick="onUpdateFunction(employee)"> <p>{{employee.departmentName}}</p> </td>
                                    <td class="table__col table__col--left table__col--bankNumber" @dblclick="onUpdateFunction(employee)"> <p>{{employee.bankNumber}}</p> </td>
                                    <td class="table__col table__col--left table__col--bankName" @dblclick="onUpdateFunction(employee)"> <p>{{employee.bankName}}</p> </td>
                                    <td class="table__col--left table__col--bankBranch" @dblclick="onUpdateFunction(employee)"> <p>{{employee.bankBranch}}</p> </td>
                                    <td class="table__col--function table__col--function">
                                        <span class="table__col--update"
                                            @click="onUpdateFunction(employee)"
                                        > {{ this.textUpdate }}</span>
                                        <span class="table__col--more"
                                        >
                                            <i class="icon icon--functiondown"></i>
                                        </span>
                                    </td>

                                    <btnMore
                                        @onReplicateFunction="onReplicateFunction(employee)"
                                        @showDeleteDialog="showDeleteDialog(employee)"
                                    >
                                    </btnMore>
                                </tr> 
                                <tr class="table__row table__row--space"></tr>
                            </tbody>
                        </table>
                    </div>
                </table>

                <div class="table__footer" 
                >
                    <span class="table__record"> {{ textTotal }}: <b>{{formatNumber(totalRecord)}}</b> {{ textRecord }}</span>
                    <div class="table__page">
                        <div class="table__size">
                            <div class="item--caretdown" 
                                tabindex="1"
                                @click="this.isShowDropdownPage = !this.isShowDropdownPage"
                                @blur="hideDropdownPage()"
                            >
                                <i class="icon icon--caretdown" :class="{'icon--caretdownRotate': this.isShowDropdownPage}"></i>
                            </div>
                            <input class="input table__sizeInput" 
                                type="text"
                                v-bind:value="this.filter.pageSize + textRecordPerPage"
                                :class="{'input--focused': isShowDropdownPage}"
                                readonly
                            >
                            <span class="dropdown dropdown--page" v-show="this.isShowDropdownPage">
                                <ul class="dropdown__list">
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 10}" @click="this.filter.pageSize = 10, this.currentPage = 1, employeesSelectedByID = [], loadAPI()">10{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 20}" @click="this.filter.pageSize = 20, this.currentPage = 1, employeesSelectedByID = [], loadAPI()">20{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 30}" @click="this.filter.pageSize = 30, this.currentPage = 1, employeesSelectedByID = [], loadAPI()">30{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 50}" @click="this.filter.pageSize = 50, this.currentPage = 1, employeesSelectedByID = [], loadAPI()">50{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 100}" @click="this.filter.pageSize = 100, this.currentPage = 1, employeesSelectedByID = [], loadAPI()">100{{textRecordPerPage}}</li>
                                </ul>
                            </span>
                        </div>

                        <div class="table__number">
                            <span class="table__previous"
                                @click="previousPage()"
                                :class="{'table__item--disable': this.currentPage == 1}"
                            >{{ this.textNext }}</span>

                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.totalPage > 1"
                                @click="firstPage()"
                                :class="{'table__subnumber--focus': this.currentPage == 1}"
                            >1</span>

                            <span class="table__subnumber" tabindex="1" 
                                @click="this.currentPage > 6 ? this.isShowPreviousPage = true : this.isShowPreviousPage = false, this.isShowNextPage = false"
                                v-show="(this.currentPage > 2 && this.totalPage > 3) || this.isShowNextPage == true"
                            >...</span>

                            <span class="table__subnumber" tabindex="1" 
                                v-show="(this.currentPage < 3 || this.totalPage == 3) && this.totalPage > 2  && this.isShowNextPage == false"
                                @click="this.currentPage=2, loadAPI()"
                                :class="{'table__subnumber--focus': this.currentPage == 2}"
                            >2</span>
                            
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage < 3  && this.totalPage > 3 && this.isShowNextPage == false"
                                @click="this.currentPage=3, loadAPI()"
                            >3</span>

                            <span class="table__subnumber" tabindex="1"
                                v-show="this.isShowNextPage == true"
                                @click="this.currentPage+=2, loadAPI()"
                            >{{ this.currentPage + 2 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.isShowNextPage == true"
                                @click="this.currentPage+=3, loadAPI()"
                            >{{ this.currentPage + 3 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.isShowNextPage == true"
                                @click="this.currentPage+=4, loadAPI()"
                            >{{ this.currentPage + 4 }}</span>

                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3 && this.isShowNextPage == false && this.isShowPreviousPage == false"
                                @click="this.currentPage--, loadAPI()"
                            >{{ this.currentPage - 1 }}</span>
                            <span class="table__subnumber table__subnumber--focus" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3 && this.isShowNextPage == false && this.isShowPreviousPage == false"
                            >{{ this.currentPage }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3 && this.isShowNextPage == false && this.isShowPreviousPage == false"
                                @click="this.currentPage++, loadAPI()"
                            >{{ this.currentPage + 1 }}</span>

                            <span class="table__subnumber" tabindex="1"
                                v-show="this.isShowPreviousPage == true"
                                @click="this.currentPage-=4, loadAPI()"
                            >{{ this.currentPage - 4 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.isShowPreviousPage == true"
                                @click="this.currentPage-=3, loadAPI()"
                            >{{ this.currentPage - 3 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.isShowPreviousPage == true"
                                @click="this.currentPage-=2, loadAPI()"
                            >{{ this.currentPage - 2 }}</span>

                            <span class="table__subnumber" tabindex="1"
                                v-show="this.currentPage > this.totalPage-2  && this.totalPage > 3 && this.isShowPreviousPage == false"
                                @click="this.currentPage = this.totalPage-2, loadAPI()"
                            >{{ this.totalPage-2 }}</span>

                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > this.totalPage-2  && this.totalPage > 3 && this.isShowPreviousPage == false"
                                @click="this.currentPage = this.totalPage-1, loadAPI()"  
                                :class="{'table__subnumber--focus': this.currentPage == this.totalPage-1}"
                            >{{ this.totalPage-1 }}</span>

                            <span class="table__subnumber" tabindex="1" 
                                @click="this.currentPage + 5 < this.totalPage ? this.isShowNextPage = true : this.isShowNextPage = false, this.isShowPreviousPage = false"
                                v-show="(this.currentPage < this.totalPage - 1 && this.totalPage > 3) || this.isShowPreviousPage == true"
                            >...</span>

                            <span class="table__subnumber" tabindex="1" 
                                @click="lastPage()"
                                :class="{'table__subnumber--focus': this.currentPage == this.totalPage}"
                            >{{this.totalPage}}</span>

                            <span class="table__next" 
                                @click="nextPage()"
                                :class="{'table__item--disable': this.currentPage == this.totalPage}"
                            >{{ this.textPrevious }}</span>
                        </div>
                    </div>
                </div>

                <BLoading v-show="isShowLoadingTable" loadingClass="loading--table"></BLoading>
            </div>
        </div>

        <EmployeeDetail 
            v-if="isDisplayModal"
            @closeModal="isDisplayModal = $event" 
            @showSuccessToast="showSucessToast()"
        ></EmployeeDetail>

        <BDialog
            class="dialog--delete"
            :message="this.employeeDeleted.employeeCode"
            v-if="this.isShowDeleteDialog"
            @closeDialog="(this.isShowDeleteDialog = $event)"
            @deleteEmployee="apiDeleteEmployeeByID(), showSucessDeleteToast()"
        >
        </BDialog>

        <BDialog
            class="dialog--deleteBatch"
            v-if="this.isShowDeleteBatchDialog"
            @closeDialog="(this.isShowDeleteBatchDialog = $event)"
            @deleteEmployee="apiDeleteEmployeesByIDs(), showSucessDeleteToast()"
        >   
            <template #message>
            {{ this.textDialog.deleteBatch }}
            </template>
        </BDialog>

        <!-- Begin: Toast th??ng b??o xo?? -->
        <BToast
            v-show="this.isShowSuccessDeleteToast"
            @closeToast="this.isShowSuccessDeleteToast = false"
        ></BToast>
        <!-- End: Toast th??ng b??o xo?? -->

        <!-- Begin: Toast th??ng b??o th??m|s???a -->
        <BToast
            v-show="this.isShowSuccessToast"
            @closeToast="this.isShowSuccessToast = false"
        >
            <template #text>
                {{ this.updateFunction ? this.textToastMessage.success.update : this.textToastMessage.success.insert }}
            </template>
        </BToast>
        <!-- End: Toast th??ng b??o th??m|s???a -->

        <BLoading v-show="this.isShowLoading"></BLoading>
    </div>
</template>

<script>
import axios from "axios";
import Resource from "@/translations/resource";
/* import TheDelete from "@/components/function/delete/TheDelete.vue"; */
import moment from 'moment';
import Enum from "@/utils/enum";
import BLoading from '@/components/base/loading/BLoading.vue'
import EmployeeDetail from "./EmployeeDetail.vue";
import BDialog from "@/components/base/dialog/BDialog.vue";
import BToast from "@/components/base/toast/BToast.vue";
import btnBatch from "@/components/base/button/BBtnBatch.vue";
import btnMore from "@/components/base/button/BBtnMore.vue";
/* import BComboboxIcon from "@/components/base/combobox/BComboboxIcon.vue"; */
/* import TheLoading from "@/components/base/loading/TheLoading.vue"; */
/* import BaseMessageError from "@/components/base/message/BaseMessageError.vue"; */

export default {
    name: "EmployeeList",
    components: {
        BLoading,
        EmployeeDetail,
        BDialog,
        BToast,
        btnBatch,
        btnMore,
/*         BComboboxIcon, */
    },
    props: [
        'sidebarmini',
    ],

    // Kh???i t???o m???t ?????i instance(?????i t?????ng), ch??a thi???t l???p data, event
    beforeCreate() {
    },

    // Thi???t l???p v??o data, event nh??ng ch??a v??o DOM
    created() {
        let me = this;
        try {
            me.isShowLoading = true; // Hi???n th??? loading data
            
            me.loadAPI();     
        } catch (error) {
            console.log(error);
        }
    },
    
    /* Kh???i t???o gi?? tr??? m???c ?????nh khi v??o DOM th???t */
    beforeMount() {

        
    },

    /* DOM th???t */
    mounted() {
        console.log("Mounted")
    },

    /* Khi d??? li???u thay ?????i, v?? tr?????c khi render, patch l???i v?? hi???n th??? ra cho ng?????i d??ng */
    beforeUpdate() {
        console.log("beforeUpdate");
    },

    /*  S??? d???ng khi b???n c???n truy c???p DOM sau khi thay ?????i thu???c t??nh */
    updated() {
        console.log("updated");
    },

    /* ????y l?? n??i ????? qu???n l?? t??i nguy??n x??a t??i nguy??n, d???n d???p c??c component */
    beforeUnmount() {
        
    },

    unmounted() {
        
    },

    methods: {
        /* T???i d??? li???u API
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        loadAPI() {
            let me = this;
            me.isShowLoadingTable = true;
            try {
                axios
                .get(`${Resource.Url.Employees}/filter?keyword=${me.filter.employeeFilter}&pageSize=${me.filter.pageSize}&pageNumber=${me.currentPage}`)
                .then((resource) => {
                    me.employees = resource.data.data;
                    me.totalRecord = resource.data.totalRecord;
                    me.totalPage = resource.data.totalPage;
                    me.isShowLoadingTable = false;
                    me.isShowLoading = false;
                    me.isShowNextPage = false;
                    me.isShowPreviousPage = false;
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                })
            } catch (e) {
                console.log(e);
            }
        },

        /* T??m ki???m nh??n vi??n theo m??, t??n, s??? ??i???n tho???i
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */  
        searchEmployee() {

        },

        /* T???i l???i danh s??ch nh??n vi??n
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        reloadEmployeeTable() {

        },

        /* Xo?? 1 nh??n vi??n theo ID
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        apiDeleteEmployeeByID() {
            try {
                axios
                .delete(`${Resource.Url.Employees}/${this.employeeDeleted.employeeID}`)
                .then(() => {
                    // Reload data
                    this.currentPage = 1;
                    this.loadAPI();
                    this.employeeDeleted = '';
                })
                .catch((error) => {
                    console.log(error);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* Xo?? nh??n vi??n theo danh s??ch ID
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        apiDeleteEmployeesByIDs() {
            try {
                axios
                .post(`${Resource.Url.Employees}/deleteBatch`, {
                    "iDs": this.employeesSelectedByID.toString(),
                })
                .then(() => {
                    // Reload data
                    this.currentPage = 1;
                    this.loadAPI();
                    this.employeesSelectedByID = [];
                })
                .catch((error) => {
                    console.log(error);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* API xu???t file excel
            @param {}
            @returns void
            Author: Tuan 
            Date: 16/1/2023
        */
        apiExportExcel() {
            let me = this;
            me.isShowLoadingTable = true;
            try {
                axios
                .get(`https://localhost:44368/api/v1/Employees/export?keyword=${me.filter.employeeFilter}`)
                .then((response) => {
                    let url = response.request.responseURL;
                    window.open(url);
                    me.isShowLoadingTable = false;
                })
                .catch((error) => {
                    console.log(error);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* Show toast xo?? th??nh c??ng
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        showSucessDeleteToast() {
            this.isShowSuccessDeleteToast = true;
            setTimeout(() => this.isShowSuccessDeleteToast = false, 2400); 
        },

        /* Show toast th??m|s???a th??nh c??ng
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        async showSucessToast() {
            this.isShowSuccessToast = true;
            await setTimeout(() => this.isShowSuccessToast = false, 2400); 

        },

        /* formatDate
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        formatDate(value){
            if (value) {
                return (moment(String(value)).format('DD/MM/YYYY'));
            }
        },

        /* ?????nh d???ng d??? li???u cho s??? (200000 => 200.000)
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        formatNumber(number) {
            let val = (number/1).toFixed(0)
            if (number && !isNaN(number)) {
                return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
            } else 
                return number;
        },

        /* Ph??m t???t
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        keyboardShortcuts(e) {
            let me = this;
            if (e.ctrlKey) {
                switch(e.keyCode) {
                    case Enum.KEY_CODE.ONE:
                        e.preventDefault();
                        me.isDisplayModal = true;
                        me.updateFunction = false;
                        me.replicateFunction = false;
                        break;
                    case Enum.KEY_CODE.TWO:
                        e.preventDefault();
                        me.onReplicateFunction(me.employeeSelected);
                        break;
                    case Enum.KEY_CODE.E:
                        e.preventDefault();
                        me.apiExportExcel();
                        break;
                    case Enum.KEY_CODE.D:
                        e.preventDefault();
                        if(me.employeesSelectedByID.length > 1)
                            me.isShowDeleteBatchDialog = true;
                        else {
                            if(me.employeeSelected) {
                                me.showDeleteDialog(me.employeeSelected);
                            }
                        }
                        break;
                    default:
                        break;
                }
            }

            if(e.keyCode == Enum.KEY_CODE.DELETE) {
                e.preventDefault();
                if(me.employeesSelectedByID.length > 1)
                    me.isShowDeleteBatchDialog = true;
                else {
                    if(me.employeeSelected) {
                        me.showDeleteDialog(me.employeeSelected);
                    }
                }
            }

            if(e.keyCode == Enum.KEY_CODE.ESC) {
                e.preventDefault();
            }
        },

        //#region Click events
        /* Th??m m???i nh??n vi??n
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        onInsertFunction() {
            let me = this;
            me.isDisplayModal = true;
            me.updateFunction = false;
            me.replicateFunction = false;
            me.isShowSuccessDeleteToast = false
            me.isShowSuccessToast = false;
        },

        /* S???a nh??n vi??n
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        onUpdateFunction(employee) {
            let me = this;
            me.focusEmployee(employee);
            me.isDisplayModal = true;
            me.updateFunction = true;
            me.isShowSuccessDeleteToast = false
            me.isShowSuccessToast = false;
        },

        /* Nh??n b???n nh??n vi??n
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        onReplicateFunction(employee) {
            let me = this;
            me.focusEmployee(employee);
            me.isDisplayModal = true;
            me.replicateFunction = true;
            me.updateFunction = false;
            me.isShowSuccessDeleteToast = false
            me.isShowSuccessToast = false;
            me.isShowDropDownMore = false;
        },

        /* Check c??c nh??n vi??n v???i checkbox
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        clickCheckEmployee(employee) {
            let bool = true;
            for(var i = 0; i < this.employeesSelectedByID.length; i++) {
                if(employee.employeeID == this.employeesSelectedByID[i]) {
                    bool = false;
                    this.employeesSelectedByID.splice(i,1);
                    break;
                }
            }
            
            if(bool) {
                this.employeesSelectedByID.push(employee.employeeID);
            }
        },

        /* B??? ch???n nh??n vi??n thao t??c c??c ch???c n??ng
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        deselectEmployee() {
            this.employeeSelected = null;
        },

        /* Ch???n 1 nh??n vi??n thao t??c c??c ch???c n??ng
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        selectEmployee(employee) {
            if(employee == this.employeeSelected) {
                this.employeeSelected = ''
            } else {
                this.employeeSelected = employee;
            }
        },

        /* Show c???nh b??o khi ch???n xo??
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        showDeleteDialog(employee) {
            this.isShowDeleteDialog = true;
            this.employeeDeleted = employee;
        },

        /* Focus 1 nh??n vi??n
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        focusEmployee(employee) {
            this.employeeFocused = employee;
        },
        //#endregion

        //#region Check events
        /* Check c??c nh??n vi??n v???i checkbox
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkEmployee(id) {
            for(var i = 0; i < this.employeesSelectedByID.length; i++) {
                if(id == this.employeesSelectedByID[i]) {
                    return true;
                }
            }
            return false
        },

        /* Ki???m tra c??c nh??n vi??n ??ang focus
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkEmployeeFocused(employee) {
            if(employee == this.employeeFocused) {
                return true;
            }
            return false; 
        },

        /* Ki???m tra 1 nh??n vi??n ??ang ???????c ch???n
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkEmployeeSelected(employee) {
            if(employee == this.employeeSelected) 
                return true;
            return false; 
        },
        //#endregion

        //#region Filter & Paging 
        /* ???n dropdown ch???n s??? b???n ghi tr??n 1 trang
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        hideDropdownPage() {
            setTimeout(() => this.isShowDropdownPage = false, 200); 
        },

        /* L??i trang
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        previousPage() {
            if(this.currentPage != 1) {
                this.currentPage--;
                this.loadAPI();
            }
        },

        /* Next trang
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        nextPage() {
            if(this.currentPage != this.totalPage) {
                this.currentPage++;
                this.loadAPI();
            }
        },

        /* V??? trang ?????u
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        firstPage() {
            if(this.currentPage != 1) {
                this.currentPage = 1;
                this.loadAPI();
            }
        },

        /* T???i trang cu???i
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        lastPage() {
            if(this.currentPage != this.totalPage) {
                this.currentPage = this.totalPage;
                this.loadAPI();
            }
        },
        //#endregion

        /*  Format gi???i t??nh tinyint sang text
            @param {int} status: tr???ng th??i b??n backend tr??? v???
            @returns void
            Date: 21/11/2022 
         */
        formatGender(value) {
            if(value == 0) return this.textMale;
            else if (value == 1) return this.textFemale;
            else if (value == 2) return this.textOther;
        },
    },

    data() {
        return {
            //#region Data x??? l?? s??? ki???n show
            isShowDropdownPage: false,
            isShowLoading: false,
            isShowLoadingTable: false,
            isShowSuccessDeleteToast: false,
            isShowSuccessToast: false,
            isShowDeleteDialog: false,
            isShowDeleteBatchDialog: false,
            isShowMoreFunction: false,
            isDisplayModal: false,
            isShowNextPage: false,
            isShowPreviousPage: false,
            isShowDropDownMore: false,
            //#endregion Data x??? l?? s??? ki???n show


            updateFunction: false,
            replicateFunction: false,
            employeeFocused: [],
            employeeSelected: '',
            employeeDeleted: '',
            employeesSelected: [],
            employeesSelectedByID: [],
            employees: [
            ],
            employeesNoLimit: [],

            totalRecord: 0,
            totalPage: 0,
            currentPage: 1,
            filter: {
                employeeFilter: '',
                pageSize: 20,
                pageNumber: 0,
                keyword: '',
            },

            contentTitle: Resource.TextVi.Content.Title,
            contentAdd: Resource.TextVi.Content.Add,

            //#region Data table 
            textSearchPlaceholder: Resource.TextVi.Table.Search,
            textEmployeeCode: Resource.TextVi.Table.EmployeeCode,
            textEmployeeName: Resource.TextVi.Table.EmployeeName,
            textGender: Resource.TextVi.Table.Gender,
            textBirthday: Resource.TextVi.Table.Birthday,
            textIdentity: Resource.TextVi.Table.Identity,
            textRole: Resource.TextVi.Table.Role,
            textOrganizationName: Resource.TextVi.Table.OrganizationName,
            textBankNumber: Resource.TextVi.Table.BankNumber,
            textBankName: Resource.TextVi.Table.BankName,
            textBankBranch: Resource.TextVi.Table.BankBranch,
            textFunction: Resource.TextVi.Table.Function,

            textBatch: Resource.TextVi.Table.Batch,
            textUpdate: Resource.TextVi.Table.Update,
            textReplication: Resource.TextVi.Table.Replicate,
            textDelete: Resource.TextVi.Table.Delete,
            textStop: Resource.TextVi.Table.Stop,
            textRecordPerPage: Resource.TextVi.Table.RecordPerPage,
            textNext: Resource.TextVi.Table.Next,
            textPrevious: Resource.TextVi.Table.Previous,
            textTotal: Resource.TextVi.Table.Total,
            textRecord: Resource.TextVi.Table.Record,
            //#endregion Data table

            textMale: Resource.TextVi.Gender.Male, // Nam
            textFemale: Resource.TextVi.Gender.Female, // N???
            textOther: Resource.TextVi.Gender.Other, // JKh??c

            textToastMessage: { // N???i dung Toast
                success: {
                    title: Resource.TextVi.ToastMessage.Success.Title,
                    insert: Resource.TextVi.ToastMessage.Success.Insert,
                    update: Resource.TextVi.ToastMessage.Success.Update,
                } 
            },

            textTooltip: { // N???i dung tooltip
                identityNumber: Resource.TextVi.Tooltip.IdentityNumber,
                phone: Resource.TextVi.Tooltip.Phone,
                fax: Resource.TextVi.Tooltip.Fax,
                bankBranch: Resource.TextVi.Tooltip.BankBranch,
                reload: Resource.TextVi.Tooltip.Reload,
                exportExcel: Resource.TextVi.Tooltip.ExportExcel,
            },

            textDialog: { // N???i dung dialog
                deleteBatch: Resource.TextVi.Dialog.Text.DeleteBatch,
            },
        }
    },
    
    computed: {
        /* Ch???n t???t c??? d??ng
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        selectAllEmployees: {
            get: function () {
                return this.employees.length > 0 ? this.employeesSelectedByID.length == this.employees.length : false;
            },

            set: function (value) {
                var employeesSelectedByID = [];

                if (value) {
                    this.employees.forEach(function (employee) {
                        employeesSelectedByID.push(employee.employeeID);
                    });
                }

                this.employeesSelectedByID = employeesSelectedByID;
            }
        },
    },
}
</script>