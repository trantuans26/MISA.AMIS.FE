<template>
    <div class="content">
        <div class="content__header">
            <div class="content__title">{{this.contentTitle}}</div>
            <div class="btn btn--add"
                @click="isDisplayModal = true"
            >{{this.contentAdd}}</div>
        </div>

        <div class="content__body">
            <div class="table__function">
                <div class="table__search">
                    <input class="input input--search"
                        type="text" :placeholder="this.textSearchPlaceholder"
                        v-model.trim="this.filter.employeeFilter"
                        v-on:keyup.enter="loadAPI()"
                    >
                    <i class="icon icon--search"></i>
                </div>
                <div class="table__reset"
                    data-title="Tải lại dữ liệu"
                    @click="loadAPI()"
                ><i class="icon icon--reset"></i></div>
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
                                <th class="table__col table__col--left table__col--identity" data-title="Số chứng minh nhân dân">{{this.textIdentity}}</th>
                                <th class="table__col table__col--left table__col--positionName">{{this.textRole}}</th>
                                <th class="table__col table__col--left table__col--departmentName">{{this.textOrganizationName}}</th>
                                <th class="table__col table__col--right table__col--bankNumber">{{this.textBankNumber}}</th>
                                <th class="table__col table__col--left table__col--bankName">{{this.textBankName}}</th>
                                <th class="table__col--left table__col--bankBranch" data-title="Chi nhánh tài khoản ngân hàng">{{this.textBankBranch}}</th>
                                <th class="table__col--center table__col--function">{{this.textFunction}}</th>
                            </thead>
                        </table>
                    </div>

                    <div class="table__body">
                        <table>
                            <tbody>
                                <tr 
                                    class="table__row" 
                                    v-for="(employee) in this.employees"
                                    :key="employee"
                                    :class="{'table__row--checked': checkBackground(employee.EmployeeId), 'table__row--focus': checkEmployeesFocus(employee.EmployeeId)}"   
                                    @click="focusEmployeesByID(employee.EmployeeId)"
                                >
                                    <td class="table__col table__col--center table__col--check">
 <!--                                        <input type="checkbox" 
                                            :value="employee.EmployeeId"
                                            v-model='this.employeesSelectedByID' 
                                        > -->
                                        <input type="checkbox" 
                                            :checked="checkEmployee(employee.EmployeeId)"
                                            @click="clickCheckEmployee(employee.EmployeeId)"
                                        >
                                        <span class="dropdown dropdown--function" v-show="checkEmployeeSelected(employee)">
                                            <ul class="dropdown__list">
                                                <li class="dropdown__item">Nhân bản</li>
                                                <li class="dropdown__item" @click="isShowDeleteDialog = true">Xoá</li>
                                                <li class="dropdown__item">Ngưng sử dụng</li>
                                            </ul>
                                        </span>
                                    </td>
                                    <td class="table__col table__col--left table__col--employeeCode">{{employee.EmployeeCode}}</td>
                                    <td class="table__col table__col--left table__col--employeeName">{{employee.FullName}}</td>
                                    <td class="table__col table__col--left table__col--gender">Nam {{employee.EmployeeGenderName}}</td>
                                    <td class="table__col table__col--center table__col--birthday">26/06/2001{{employee.EmployeeBirthday}}</td>
                                    <td class="table__col table__col--left table__col--identity">0342060019785{{employee.EmployeeIdentity}}</td>
                                    <td class="table__col table__col--left table__col--positionName">{{employee.PositionName}}</td>
                                    <td class="table__col table__col--left table__col--departmentName">{{employee.DepartmentName}}</td>
                                    <td class="table__col table__col--right table__col--bankNumber">223123123231{{employee.EmployeeBankNumber}}</td>
                                    <td class="table__col table__col--left table__col--bankName">Techcombank{{employee.EmployeeBankName}}</td>
                                    <td class="table__col--left table__col--bankBranch">Hà Nội{{employee.EmployeeBankBranch}}</td>
                                    <td class="table__col--right table__col--function">
                                        <span class="table__col--update">Sửa</span>
                                        <span class="table__col--more"
                                            tabindex="1"
                                            @click="this.selectEmployee(employee)"
                                            
                                        >
                                            <i class="icon icon--functiondown"></i>
                                        </span>
                                    </td>
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
                            <div class="item--caretdown" @click="this.isShowDropdownPage = !this.isShowDropdownPage">
                                <i class="icon icon--caretdown"></i>
                            </div>
                            <input class="input table__sizeInput" 
                                type="text"
                                v-bind:value="this.filter.pageSize + textRecordPerPage"
                                readonly
                            >
                            <span class="dropdown dropdown--page" v-show="this.isShowDropdownPage">
                                <ul class="dropdown__list">
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 10}" @click="this.filter.pageSize = 10, loadAPI()">10{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 20}" @click="this.filter.pageSize = 20, loadAPI()">20{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 30}" @click="this.filter.pageSize = 30, loadAPI()">30{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 50}" @click="this.filter.pageSize = 50, loadAPI()">50{{textRecordPerPage}}</li>
                                    <li class="dropdown__item" :class="{'dropdown__item--focus': this.filter.pageSize == 100}" @click="this.filter.pageSize = 100, loadAPI()">100{{textRecordPerPage}}</li>
                                </ul>
                            </span>
                        </div>

                        <div class="table__number">
                            <span class="table__previous"
                                @click="previousPage()"
                                :class="{'table__item--disable': this.currentPage == 1}"
                            >Trước</span>
                            <span class="table__subnumber" tabindex="1" 
                                @click="firstPage()"
                                :class="{'table__subnumber--focus': this.currentPage == 1}"
                            >1</span>
                            <span class="table__subnumber" tabindex="1" v-show="this.currentPage > 2">...</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage < 3"
                                @click="this.currentPage=2, loadAPI()"
                                :class="{'table__subnumber--focus': this.currentPage == 2}"
                            >2</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage < 3"
                                @click="this.currentPage=3, loadAPI()"
                            >3</span>

                            <span class="table__subnumber" tabindex="1"
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1"
                                @click="this.currentPage--, loadAPI()"
                            >{{ this.currentPage - 1 }}</span>
                            <span class="table__subnumber table__subnumber--focus" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1"
                            >{{ this.currentPage }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > 2 && this. currentPage < this.totalPage - 1"
                                @click="this.currentPage++, loadAPI()"
                            >{{ this.currentPage + 1 }}</span>

                            <span class="table__subnumber" tabindex="1" v-show="this.currentPage < this.totalPage - 1">...</span>
                            <span class="table__subnumber" tabindex="1"
                                v-show="this.currentPage > this.totalPage-2"
                                @click="this.currentPage = this.totalPage-2, loadAPI()"
                            >{{ this.totalPage-2 }}</span>
                            <span class="table__subnumber" tabindex="1" 
                                v-show="this.currentPage > this.totalPage-2"
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
            </div>
        </div>
    </div>

    <EmployeeDetail v-if="isDisplayModal"></EmployeeDetail>

    <BDialog
        class="dialog--delete"
        :message="this.employeeSelected.EmployeeCode"
        v-show="this.isShowDeleteDialog"
        @closeDialog="(this.isShowDeleteDialog = $event)"
        @deleteEmployee="deleteEmployeeByID(), showSucessDeleteToast()"
    ></BDialog>

    <BToast
        v-show="this.isShowSuccessDeleteToast"
        @closeToast="this.isShowSuccessDeleteToast = false"
    ></BToast>

    <TheLoading v-show="this.isShowLoading"></TheLoading>
</template>

<script>
import axios from "axios";
import Resource from "@/lib/resource";
/* import TheDelete from "@/components/function/delete/TheDelete.vue"; */
/* import moment from 'moment' */
import Enum from "../../lib/enum.js";
import useValidate from '@vuelidate/core'
import {required} from '@vuelidate/validators'
import TheLoading from '@/components/loading/TheLoading.vue'
import EmployeeDetail from "./EmployeeDetail.vue";
import BDialog from "@/components/base/dialog/BDialog.vue";
import BToast from "@/components/base/toast/BToast.vue";
/* import TheLoading from "@/components/base/loading/TheLoading.vue"; */
/* import BaseMessageError from "@/components/base/message/BaseMessageError.vue"; */

export default {
    name: "EmployeeList",
    components: {
        TheLoading,
        EmployeeDetail,
        BDialog,
        BToast,
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
            setTimeout(() => me.isShowLoading = false, 500);

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
            try {

                axios
                .get(`${Resource.Url.Employees}/filter?employeeFilter=${me.filter.employeeFilter}&pageSize=${me.filter.pageSize}&pageNumber=${me.currentPage}`)
                .then((resource) => {
                    me.employees = resource.data.Data;
                    me.totalRecord = resource.data.TotalRecord;
                    me.totalPage = resource.data.TotalPage;
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                });
 
             /*    axios
                .get(`${Resource.Url.Employees}/filter?keyword=${me.filter.keyword}&fixedAssetCategoryId=${me.filter.fixedAssetCategoryId}&departmentId=${me.filter.departmentId}&pageSize=600&pageIndex=1`)
                .then((resource) => {
                    me.updateTotalPageIndex(resource.data.length);
                    me.employeesNoLimit = resource.data;
                    me.totalAllEmployees = resource.data.length;
                    console.log("No filter:" + resource.data);
                })
                .catch((error) => {
                    console.log('error' + error.status);
                }); */
            } catch (e) {
                console.log(e);
            }
        },

        /* Xoá 1 nhân viên theo ID
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        deleteEmployeeByID() {
            try {
                axios
                .delete(`${Resource.Url.Employees}/${this.employeeSelected.EmployeeId}`)
                .then(() => {
                    // Reload data
                    this.loadAPI();
                    this.employeeSelected = '';

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

        /* Show toast xoá thành công
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        showSucessDeleteToast() {
            this.isShowSuccessDeleteToast = true;
            setTimeout(() => this.isShowSuccessDeleteToast = false, 4000); 
        },

        /* Binding css cho dòng được chọn
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkBackground(id) {
            for(var i = 0; i < this.selectedEmployeeByIds.length; i++) {
                if(id == this.selectedEmployeeByIds[i]) {
                    return true;
                }
            }

            return false;
        },

        /* Focus các nhân viên
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        focusEmployeesByID(id) {
            let bool = true;

            for(var i = 0; i < this.employeesIDFocused.length; i++) {
                if(id == this.employeesIDFocused[i]) {
                    this.employeesIDFocused.splice(i,1);
                    bool = false;
                    break;
                }
            }

            if(bool) this.employeesIDFocused.push(id);
        },

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

        /* Kiểm tra các nhân viên đang focus
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkEmployeesFocus(id) {
            for(var i = 0; i < this.employeesIDFocused.length; i++) {
                if(id == this.employeesIDFocused[i]) {
                    return true;
                }
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

        /*  Hàm xử lý exception gửi về từ backend hiện ra cho người dùng
            @param {int} status: trạng thái bên backend trả về
            @returns void
            Date: 21/11/2022 
         */
        handleException(status) {
            try {
                switch (status) {
                case Enum.StatusCode.BADREQUEST:
                    this.textExceptionMsg = Resource.ExceptionMsg.BADREQUEST;
                    this.validateBackendShow = true;
                    break;
                case Enum.StatusCode.FORBIDDEN:
                    this.textExceptionMsg = Resource.ExceptionMsg.FORBIDDEN;
                    this.validateBackendShow = true;
                    break;
                case Enum.StatusCode.NOTFOUND:
                    this.textExceptionMsg = Resource.ExceptionMsg.NOTFOUND;
                    this.validateBackendShow = true;
                    break;
                case Enum.StatusCode.UNAUTHORIZED:
                    this.textExceptionMsg = Resource.ExceptionMsg.UNAUTHORIZED;
                    this.validateBackendShow = true;
                    break;
                case Enum.StatusCode.NTERNALSERVERERROR:
                    this.textExceptionMsg = Resource.ExceptionMsg.NTERNALSERVERERROR;
                    this.validateBackendShow = true;
                    break;
                }
            } catch (error) {
                console.log(error);
            }
        },
    },

    data() {
        return {
            sucess: {
                icon: "icon--sucessToast",
                title: "Thành công",
                text: "Công việc đã bị xoá",
            },
            warning: {
                icon: "icon--sucessToast",
                title: "Cảnh báo",
                text: "Dữ liệu của bạn đã bị thay đổi bởi người dùng khác",
            },

            isShowDropdownPage: false,
            isShowLoading: false,
            isShowSuccessDeleteToast: false,
            isShowDeleteDialog: false,
            isShowMoreFunction: false,
            isDisplayModal: false,
            selectedEmployeeByIds: [],
            employeesIDFocused: [],
            employeeSelected: '',
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
                pageSize: '20',
                pageNumber: '',
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
                return this.employees ? this.employeesSelectedByID.length == this.employees.length : false;
            },

            set: function (value) {
                var employeesSelectedByID = [];

                if (value) {
                    this.employees.forEach(function (employee) {
                        employeesSelectedByID.push(employee.EmployeeId);
                    });
                }

                this.employeesSelectedByID = employeesSelectedByID;
            }
        },
        /* Thực hiện format trường Số lượng
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        quantityFormat: {
            get: function() {
                if (this.assetModal.quantity == null || this.assetModal.quantity == 0 || this.assetModal.quantity == "") return 0;
                return this.formatCurrency(parseInt(this.assetModal.quantity));
            },
                // setter
            set: function(number) {
                number = this.formatNum(number);
                this.assetModal.quantity = number;
            }
        },

        /* Thực hiện format trường Nguyên giá đồng thời tính lại giá trị hao mòn năm
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        costFormat: {
            get: function() {
                if (this.assetModal.cost == null || this.assetModal.cost == 0 || this.assetModal.cost == "") return 0;
                return this.formatCurrency(parseInt(this.assetModal.cost));
            },
                // setter
            set: function(number) {
                number = this.formatNum(number);
                if (number != 0 && number != null && number != '') {
                    this.assetModal.cost = number;
                    this.assetModal.depreciation = (this.assetModal.depreciationRate*0.01 * this.assetModal.cost);
                    this.assetModal.depreciation = Math.floor(this.assetModal.depreciation);
                } else {
                    this.assetModal.cost = '';
                }
            }
        },

        /* Thực hiện format số năm sử dụng
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        lifeTimeFormat: {
            get: function() {
                if (this.assetModal.lifeTime == null || this.assetModal.lifeTime == 0 || this.assetModal.lifeTime == "" || this.assetModal.lifeTime == Infinity) return 0;
                return this.formatCurrency(parseInt(this.assetModal.lifeTime));

            },
            set: function(number) {
                number = this.formatNum(number);
                if (number == null || number == 0 || number == "" || number == Infinity) {
                    this.assetModal.lifeTime = '';
                    this.assetModal.depreciationRate = '';
                } else {
                    this.assetModal.lifeTime = number;
                    this.assetModal.depreciationRate = (100 / number).toFixed(2);
                    this.assetModal.depreciation = (parseFloat(this.assetModal.depreciationRate)*0.01 * this.assetModal.cost);
                    this.assetModal.depreciation = Math.floor(this.assetModal.depreciation);
                }
            }
        },

        /* Thực hiện format tỷ lệ hao mòn đồng thời tính lại giá trị hao mòn năm
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        depreciationRateFormat: {
            get: function() {
                let rate = this.assetModal.depreciationRate;
                if (rate == null || rate == '0' || rate == "") 
                    return "00,00";     
                return this.formatDecimal(rate);
            },

            set: function(number) {
                let tmp = number;
                tmp = tmp.replaceAll(',', '.');
                if (tmp == null || tmp == '' || tmp == 0) {
                    this.assetModal.depreciationRate = 0;
                    this.assetModal.lifeTime = 0;
                    this.assetModal.depreciation = 0;
                } else if (isNaN(this.assetModal.lifeTime) || isNaN(tmp)) {
                    this.assetModal.lifeTime = 0;
                    this.assetModal.depreciation = 0;
                } else {
                    this.assetModal.depreciationRate =  tmp;
                    this.assetModal.depreciation = (parseFloat(tmp)*0.01 * this.assetModal.cost);
                    this.assetModal.depreciation = Math.floor(this.assetModal.depreciation);
                    this.assetModal.lifeTime = Math.floor((100 / tmp));
                }
            }
        },

        /* Tự động thêm tên tài sản khi điền mã tài sản
            Object
            Author: Tuan 
            Date: 10/12/2022 
        */
        departmentSelection: {
            get: function() {
                return this.assetModal.departmentCode;
            },

            set: function(code) {
                this.assetModal.departmentCode = code;
                for(var i=0; i<this.departments.length; i++) {
                    if(this.departments[i].department_code == code) {
                        this.assetModal.departmentName = this.departments[i].department_name;
                        this.assetModal.departmentId = this.departments[i].department_id;
                        break;
                    } else {
                        this.assetModal.departmentName = ""
                        this.assetModal.departmentId = ""                   
                    }
                }         
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