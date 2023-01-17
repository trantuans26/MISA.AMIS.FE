<template>
    <div class="content">
        <div class="content__header">
            <div class="content__title">{{this.contentTitle}}</div>
            <div class="btn btn--add"
                @click="isDisplayModal = true, updateFunction = false"
            >{{this.contentAdd}}</div>
        </div>

        <div class="content__body">
            <div class="table__function">
                <div class="table__search">
                    <input class="input input--search"
                        type="text" :placeholder="this.textSearchPlaceholder"
                        v-model.trim="this.filter.employeeFilter"
                        v-on:keyup.enter="this.currentPage = 1, loadAPI()"
                    >
                    <i class="icon icon--search" @click="this.filter.employeeFilter = 'haha', this.currentPage = 1, loadAPI()"></i>
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
                                    
                                >
                                    <td class="table__col table__col--center table__col--check">
 <!--                                        <input type="checkbox" 
                                            :value="employee.EmployeeId"
                                            v-model='this.employeesSelectedByID' 
                                        > -->
                                        <input type="checkbox" 
                                            :checked="checkEmployee(employee.employeeID)"
                                            @click="clickCheckEmployee(employee.employeeID)"
                                        >
                                    </td>
                                    <td class="table__col table__col--left table__col--employeeCode" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.employeeCode}}</p> </td>
                                    <td class="table__col table__col--left table__col--employeeName" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.employeeName}}</p> </td>
                                    <td class="table__col table__col--left table__col--gender" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{this.formatGender(employee.gender)}}</p> </td>
                                    <td class="table__col table__col--center table__col--birthday" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{formatDate(employee.dateOfBirth)}}</p> </td>
                                    <td class="table__col table__col--left table__col--identity" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.identityNumber}}</p> </td>
                                    <td class="table__col table__col--left table__col--positionName" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.jobPosition}}</p> </td>
                                    <td class="table__col table__col--left table__col--departmentName" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.departmentName}}</p> </td>
                                    <td class="table__col table__col--left table__col--bankNumber" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.bankNumber}}</p> </td>
                                    <td class="table__col table__col--left table__col--bankName" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.bankName}}</p> </td>
                                    <td class="table__col--left table__col--bankBranch" @dblclick="focusEmployee(employee), isDisplayModal = true, updateFunction = true"> <p>{{employee.bankBranch}}</p> </td>
                                    <td class="table__col--function table__col--function">
                                        <span class="table__col--update"
                                            @click="focusEmployee(employee), isDisplayModal = true, updateFunction = true"
                                        >Sửa</span>
                                        <span class="table__col--more"
                                            tabindex="1"
                                            @click="selectEmployee(employee)"
                                            @blur="deselectEmployee()"
                                        >
                                            <i class="icon icon--functiondown"></i>
                                        </span>
                                    </td>
                                    <span class="dropdown dropdown--function" 
                                        v-show="checkEmployeeSelected(employee)"
                                    >
                                        <ul class="dropdown__list">
                                            <li class="dropdown__item">Nhân bản</li>
                                            <li class="dropdown__item" @click="showDeletDialog()">Xoá</li>
                                            <li class="dropdown__item">Ngưng sử dụng</li>
                                        </ul>
                                    </span>
                                </tr> 
                                <tr class="table__row table__row--space"></tr>
                            </tbody>
                        </table>
                    </div>
                </table>

                <div class="table__footer" 
                >
                    <span class="table__record">Tổng số: <b>{{totalRecord}}</b> bản ghi</span>
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
                            >Trước</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.totalPage > 1"
                                @click="firstPage()"
                                :class="{'table__subnumber--focus': this.currentPage == 1}"
                            >1</span>
                            <span class="table__subnumber" tabindex="1" 
                                @click="this.currentPage -= 2, loadAPI()"
                                v-show="this.currentPage > 2 && this.totalPage > 3">...</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="(this.currentPage < 3 || this.totalPage == 3) && this.totalPage > 2"
                                @click="this.currentPage=2, loadAPI()"
                                :class="{'table__subnumber--focus': this.currentPage == 2}"
                            >2</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage < 3  && this.totalPage > 3"
                                @click="this.currentPage=3, loadAPI()"
                            >3</span>

                            <span class="table__subnumber" tabindex="1"
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3"
                                @click="this.currentPage--, loadAPI()"
                            >{{ this.currentPage - 1 }}</span>
                            <span class="table__subnumber table__subnumber--focus" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3"
                            >{{ this.currentPage }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1 && this.totalPage > 3"
                                @click="this.currentPage++, loadAPI()"
                            >{{ this.currentPage + 1 }}</span>

                            <span class="table__subnumber" tabindex="1" 
                                @click="this.currentPage += 2, loadAPI()"
                                v-show="this.currentPage < this.totalPage - 1 && this.totalPage > 3">...</span>
                            <span class="table__subnumber" tabindex="1"
                                v-show="this.currentPage > this.totalPage-2  && this.totalPage > 3"
                                @click="this.currentPage = this.totalPage-2, loadAPI()"
                            >{{ this.totalPage-2 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > this.totalPage-2  && this.totalPage > 3"
                                @click="this.currentPage = this.totalPage-1, loadAPI()"  
                                :class="{'table__subnumber--focus': this.currentPage == this.totalPage-1}"
                            >{{ this.totalPage-1 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                @click="lastPage()"
                                :class="{'table__subnumber--focus': this.currentPage == this.totalPage}"
                            >{{this.totalPage}}</span>
                            <span class="table__next" 
                                @click="nextPage()"
                                :class="{'table__item--disable': this.currentPage == this.totalPage}"
                            >Sau</span>
                        </div>
                    </div>
                </div>

                <BLoading v-show="isShowLoadingTable" loadingClass="loading--table"></BLoading>
            </div>
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

    <!-- Begin: Toast thông báo xoá -->
    <BToast
        v-show="this.isShowSuccessDeleteToast"
        @closeToast="this.isShowSuccessDeleteToast = false"
    ></BToast>
    <!-- End: Toast thông báo xoá -->

    <!-- Begin: Toast thông báo thêm|sửa -->
    <BToast
        v-show="this.isShowSuccessToast"
        @closeToast="this.isShowSuccessToast = false"
    >
        <template #text>
            {{ this.updateFunction ? this.textToastMessage.success.update : this.textToastMessage.success.insert }}
        </template>
    </BToast>
    <!-- End: Toast thông báo thêm|sửa -->

    <BLoading v-show="this.isShowLoading"></BLoading>
</template>

<script>
import axios from "axios";
import Resource from "@/lib/resource";
/* import TheDelete from "@/components/function/delete/TheDelete.vue"; */
import moment from 'moment'
import useValidate from '@vuelidate/core'
import {required} from '@vuelidate/validators'
import BLoading from '@/components/base/loading/BLoading.vue'
import EmployeeDetail from "./EmployeeDetail.vue";
import BDialog from "@/components/base/dialog/BDialog.vue";
import BToast from "@/components/base/toast/BToast.vue";
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
/*         BComboboxIcon, */
    },
    props: [
        'sidebarmini',
    ],

    // Khởi tạo một đối instance(đối tượng), chưa thiết lập data, event
    beforeCreate() {
    },

    // Thiết lập vào data, event nhưng chưa vào DOM
    created() {
        console.log("Created")
        let me = this;
        try {
            me.isShowLoading = true; // Hiển thị loading data
            
            me.loadAPI();     
        } catch (error) {
            console.log(error);
        }
    },
    
    /* Khởi tạo giá trị mặc định khi vào DOM thật */
    beforeMount() {
        console.log("beforeMount")
    },

    /* DOM thật */
    mounted() {
        console.log("Mounted")
    },

    /* Khi dữ liệu thay đổi, và trước khi render, patch lại và hiển thị ra cho người dùng */
    beforeUpdate() {
        console.log("beforeUpdate");
    },

    /*  Sử dụng khi bạn cần truy cập DOM sau khi thay đổi thuộc tính */
    updated() {
        console.log("updated");
    },

    /* Đây là nơi để quản lý tài nguyên xóa tài nguyên, dọn dẹp các component */
    beforeUnmount() {
        
    },

    unmounted() {
        
    },

    methods: {
        /* Tải dữ liệu API
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
                    console.log("data", resource.data);
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                })
            } catch (e) {
                console.log(e);
            }
        },

        /* Tìm kiếm nhân viên theo mã, tên, số điện thoại
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */  
        searchEmployee() {

        },

        /* Tải lại danh sách nhân viên
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        reloadEmployeeTable() {

        },

        /* Xoá 1 nhân viên theo ID
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
                    this.loadAPI();
                    this.employeeDeleted = '';
                    // Display success toast message 
                    //this.showDeleteSuccessToast();
                })
                .catch((error) => {
                    console.log(error);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* API xuất file excel
            @param {}
            @returns void
            Author: Tuan 
            Date: 16/1/2023
        */
        apiExportExcel() {
            try {
                axios
                .get(`https://localhost:44368/api/v1/Employees/export`)
                .then((response) => {
                    let url = response.request.responseURL;
                
                    window.open(url);
                })
                .catch((error) => {
                    console.log(error);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* Show toast xoá thành công
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        showSucessDeleteToast() {
            this.isShowSuccessDeleteToast = true;
            setTimeout(() => this.isShowSuccessDeleteToast = false, 2400); 
        },

        /* Show toast thêm|sửa thành công
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        showSucessToast() {
            this.isShowSuccessToast = true;
            setTimeout(() => this.isShowSuccessToast = false, 2400); 
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

        //#region Click events
        /* Check các nhân viên với checkbox
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        clickCheckEmployee(id) {
            let bool = true;
            for(var i = 0; i < this.employeesSelectedByID.length; i++) {
                if(id == this.employeesSelectedByID[i]) {
                    bool = false;
                    this.employeesSelectedByID.splice(i,1);
                    break;
                }
            }
            
            if(bool) this.employeesSelectedByID.push(id);
        },

        /* Bỏ chọn nhân viên thao tác các chức năng
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        deselectEmployee() {
            setTimeout(() => this.employeeSelected = '', 200); 
        },

        /* Chọn 1 nhân viên thao tác các chức năng
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

        /* Show cảnh báo khi chọn xoá
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        showDeletDialog() {
            this.isShowDeleteDialog = true;
            this.employeeDeleted = this.employeeSelected;
        },

        /* Focus 1 nhân viên
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
        /* Check các nhân viên với checkbox
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

        /* Kiểm tra các nhân viên đang focus
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

        /* Kiểm tra 1 nhân viên đang được chọn
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
        /* Ẩn dropdown chọn số bản ghi trên 1 trang
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        hideDropdownPage() {
            setTimeout(() => this.isShowDropdownPage = false, 200); 
        },

        /* Lùi trang
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

        /* Về trang đầu
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

        /* Tới trang cuối
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

        /*  Format giới tính tinyint sang text
            @param {int} status: trạng thái bên backend trả về
            @returns void
            Date: 21/11/2022 
         */
        formatGender(value) {
            if(value == 0) return "Nam";
            else if (value == 1) return "Nữ";
            else if (value == 2) return "Khác";
        },
    },

    data() {
        return {
            //#region Data xử lý sự kiện show
            isShowDropdownPage: false,
            isShowLoading: false,
            isShowLoadingTable: false,
            isShowSuccessDeleteToast: false,
            isShowSuccessToast: false,
            isShowDeleteDialog: false,
            isShowMoreFunction: false,
            isDisplayModal: false,
            //#endregion Data xử lý sự kiện show


            updateFunction: false,
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

            textEdit: Resource.TextVi.Table.Edit,
            textReplication: Resource.TextVi.Table.Replication,
            textDelete: Resource.TextVi.Table.Delete,
            textStop: Resource.TextVi.Table.Stop,
            textRecordPerPage: Resource.TextVi.Table.RecordPerPage,
            //#endregion Data table

            textToastMessage: { // Nội dung Toast
                success: {
                    title: Resource.TextVi.ToastMessage.Success.Title,
                    insert: Resource.TextVi.ToastMessage.Success.Insert,
                    update: Resource.TextVi.ToastMessage.Success.Update,
                } 
            },

            textTooltip: { // Nội dung tooltip
                identityNumber: Resource.TextVi.Tooltip.IdentityNumber,
                phone: Resource.TextVi.Tooltip.Phone,
                fax: Resource.TextVi.Tooltip.Fax,
                bankBranch: Resource.TextVi.Tooltip.BankBranch,
                reload: Resource.TextVi.Tooltip.Reload,
                exportExcel: Resource.TextVi.Tooltip.ExportExcel,
            },
            v$: useValidate(), // validate dữ liệu (sử dụng vuelidate)
        }
    },

    validations: {
        // Các trường cần validate thiếu
        assetModal: { 
            fixedAssetCode: { required },
            fixedAssetName: { required },
            departmentCode: { required },
            categoryCode: { required },
            quantity: { required },
            cost: { required },
            depreciationRate: { required },
            lifeTime: { required },
            purchaseDate: { required },
            productionDate: { required },
        },
    },


    
    computed: {
        /* Chọn tất cả dòng
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

        /* Tự động thêm tên tài sản khi điền mã tài sản
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        categorySelection: {
            get: function() { 
                return this.assetModal.categoryCode;
            },

            set: function(code) {
                this.assetModal.categoryCode = code;
                for(var i=0; i<this.categories.length; i++) {
                    if(this.categories[i].fixed_asset_category_code == code) {
                        this.assetModal.categoryId = this.categories[i].fixed_asset_category_id;
                        this.assetModal.categoryName = this.categories[i].fixed_asset_category_name;
                        this.assetModal.lifeTime = this.categories[i].life_time;
                        this.assetModal.depreciationRate = this.categories[i].depreciation_rate;
                        break;
                    } else {
                        this.assetModal.categoryId = "";
                        this.assetModal.categoryName = "";
                    }
                }         
            }
        }
    },
}
</script>