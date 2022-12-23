<template>
    <div class="modal modal--open">                     
        <div class="modal__main"
            @submit.prevent="onSubmit"
        >
            <div class="modal__section modal__icon">
                <div class="modal__support">
                    <i class="icon icon--support"></i>
                </div>
                <div class="modal__close" @click="onCancel()">
                    <i class="icon icon--close"></i>
                </div>
            </div>

            <header class="modal__section modal__header">
                <div class="modal__title">{{titleModal}}</div>
            </header>

            <!-- Begin: Modal body -->
            <div class="modal__section modal__content">
                <div class="modal__top">
                    <div class="modal__topLeft">
                        <!-- Nhân viên -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--employeeCode">
                                <label class="modal__label">{{this.textEmployeeCode}} <em>*</em></label>
                                <input class="input input--modal" 
                                    ref="employeeCodeFocusing" 
                                    :class="{'input--error': this.isSubmited && !this.employeeModal.employeeCode}"
                                    v-model.trim="this.employeeModal.employeeCode"
                                    type="text" 
                                    maxlength="100"
                                >
                                <base-message-error text="Mã nhân viên"></base-message-error>
                            </div>
            
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textFullName}} <em>*</em>
                                </label>
                                <input class="input input--modal" type="text"
                                    ref="fullnameFocusing" 
                                    :class="{'input--error': this.isSubmited && !this.employeeModal.fullName}"
                                    v-model.trim="this.employeeModal.fullName"
                                    maxlength="255"
                                >
                                <base-message-error text="Tên nhân viên"></base-message-error>
                            </div>
                        </div>

                        <!-- Đơn vị -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textDepartmentName}} <em>*</em>
                                </label>
                                <div class="modal__input--dropdown" 
                                    @submit.prevent="onSubmit"
                                >
                                    <input  class="input input--haveicon input--modal" type="text"
                                        ref="DepartmentNameFocusing" 
                                        v-model.trim="this.employeeModal.departmentName"
                                        :class="{'input--error': this.isSubmited && !this.employeeModal.departmentName}"
                                        placeholder="Chọn đơn vị"
                                        maxlength="50"
                                    >
                                    <base-message-error text="Đơn vị"></base-message-error>
                                    <div class="item--caretdown">
                                        <i class="icon icon--caretdown"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Chức danh -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textPositionName}}
                                </label>
                                <input 
                                    class="input input--modal" type="text"  
                                    v-model.trim="this.employeeModal.positionName"
                                    placeholder=""
                                    maxlength="50"
                                >
                                <base-message-error text="Chức danh"></base-message-error>
                            </div>
                        </div>
                    </div>    

                    
                    <div class="modal__topright">
                        <!-- Ngày sinh / giới tính -->
                        <div class="modal__line">
                            <div class="modal__item">
                                <label class="modal__label">
                                    {{this.textDateOfBirth}} 
                                </label>
                                <div class="modal__input--icon">
                                    <input 
                                        type="date" 
                                        v-model.trim="this.employeeModal.dateOfBirth"
                                        class="input input--modal"  
                                    >
                                    <base-message-error text="Ngày mua"></base-message-error>
                                </div>
                            </div>
            
                            <div class="modal__item modal__item--gender">
                                <label class="modal__label">
                                    {{this.textGender}}
                                </label>
                                <div class="modal__radio">
                                    <input type="radio" v-model="this.employeeModal.gender" value="0"> <p>Nam</p>
                                    <input type="radio" v-model="this.employeeModal.gender" value="1"> <p>Nữ</p>
                                    <input type="radio" v-model="this.employeeModal.gender" value="2"> <p>Khác</p>
                                </div>
                            </div>
                        </div>

                        <!-- Số CMND / Ngày cấp -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label" data-title="Số Chứng Minh Nhân Dân">
                                    {{this.textIdentityNumber}}
                                </label>
                                <input 
                                    class="input input--haveicon input--modal" type="text"  
                                    v-model.trim="this.employeeModal.identityNumber"
                                    placeholder=""
                                    maxlength="50"
                                >
                                <base-message-error text="Số CMND"></base-message-error>
                            </div>

                            <div class="modal__item">
                                <label class="modal__label">
                                    {{this.textIdentityDate}} 
                                </label>
                                <div class="modal__input--icon">
                                    <input 
                                        type="date" 
                                        v-model.trim="this.employeeModal.identityDate"
                                        class="input input--modal"  
                                    >
                                    <base-message-error text="Ngày cấp"></base-message-error>
                                </div>
                            </div>
                        </div>

                        <!-- Nơi cấp -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textIdentityPlace}}
                                </label>
                                <input 
                                    class="input input--modal" type="text"  
                                    v-model.trim="this.employeeModal.identityPlace"
                                    placeholder=""
                                    maxlength="50"
                                >
                                <base-message-error text="Nơi cấp"></base-message-error>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="modal__bottom">
                    <!-- Địa chỉ -->
                    <div class="modal__line">
                        <div class="modal__item modal__item--fill">
                            <label class="modal__label">
                                {{this.textAddress}}
                            </label>
                            <input
                                class="input input--modal" type="text"  
                                v-model.trim="this.employeeModal.address"
                                :placeholder="this.placeholder.address"
                                maxlength="50"
                            >
                            <base-message-error text="Địa chỉ"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label" data-title="Điện thoại di dộng">
                                {{this.textPhone}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.phone"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="ĐT di động"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label"  data-title="Điện thoại cố định">
                                {{this.textContact}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.contact"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="ĐT cố định"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textEmail}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.email"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="Email"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankAccountNumber}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.bankAccountNumber"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="Tài khoản ngân hàng"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankName}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.bankName"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="Tên ngân hàng"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankBranch}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.bankBranch"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="Chi nhánh"></base-message-error>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: Modal body -->

            <!-- Begin: Modal footer -->
            <footer class="modal__section modal__footer">
                <div class="modal__footer--start">
                    <button class="btn btn__save btn__save--space" @click="onSubmit()">Cất và Thêm</button>
                    <div tabindex="0" class="btn btn--outline">Cất</div> 
                </div>

                <div class="modal__footer--end">
                    <div tabindex="0" @click="this.closeModalAction()" class="btn btn--outline">Huỷ</div> 
                    <button v-on:focus="tabRollback()" class="btn__tabRollback"></button>
                </div>
            </footer>
            <!-- END: Modal footer -->
        </div>

        <BDialog
            v-show="this.isShowValidate"
        >
            <template #icon>
                <div>
                    <i class="icon icon--errorDialog"></i>
                </div>
            </template>

            <template #message>
                <p>{{this.errorMessage}}</p>
            </template>

            <template #footer>
                <div class="dialog__footer dialog__footer--1button">
                    <div class="btn btn--dialog"
                        @click="this.isShowValidate = false, this.errorMessage = ''"
                    >{{ this.textFunctionClose }}</div>
                </div>
            </template>
        </BDialog>
    </div>
</template>

<script>
import axios from "axios";
import moment from 'moment'
import Resource from "@/lib/resource";
import BDialog from "@/components/base/dialog/BDialog.vue";
import useValidate from '@vuelidate/core';
import {required} from '@vuelidate/validators';
import BaseMessageError from "@/components/base/message/BaseMessageError.vue";

export default {
    name: "EmployeeDetail",
    components: {
        BaseMessageError,
        BDialog,
    },

    props: [
    ],
    
    //#region lifecycle

    // Khởi tạo một đối instance(đối tượng), chưa thiết lập data, event
    beforeCreate() {
        console.log("beforeCreate from")
    },

    // Thiết lập vào data, event nhưng chưa vào DOM
    created() {
        console.log("created form")
        let me = this;

        me.displayModal = me.$parent.displayModal;

    },
    
    /* Khởi tạo giá trị mặc định khi vào DOM thật */
    beforeMount() {
        console.log("beforeMount form")
        let me = this;

        me.$nextTick(() => me.$refs.employeeCodeFocusing.focus());
  
        if(me.$parent.updateFunction) {
            me.titleModal = me.textUpdateModal;
            me.employeeModal.employeeCode = me.$parent.employeeFocused.EmployeeCode;
            me.employeeModal.fullName = me.$parent.employeeFocused.EmployeeName;
            me.employeeModal.departmentId = me.$parent.employeeFocused.DepartmentId;
            me.employeeModal.departmentCode = me.$parent.employeeFocused.DepartmentCode;
            me.employeeModal.departmentName = me.$parent.employeeFocused.DepartmentName;
            me.employeeModal.positionName = me.$parent.employeeFocused.PositionName;
            me.employeeModal.dateOfBirth = (moment(String(me.$parent.employeeFocused.DateOfBirth)).format('YYYY-MM-DD'));
            me.employeeModal.gender = me.$parent.employeeFocused.Gender;
            me.employeeModal.identityNumber = me.$parent.employeeFocused.IdentityNumber;
            me.employeeModal.identityDate = (moment(String(me.$parent.employeeFocused.IdentityDate)).format('YYYY-MM-DD'));
            me.employeeModal.identityPlace = me.$parent.employeeFocused.IdentityPlace;
            me.employeeModal.address = me.$parent.employeeFocused.Address;
            me.employeeModal.phone = me.$parent.employeeFocused.PhoneNumber;
            me.employeeModal.contact = me.$parent.employeeFocused.Contact;
            me.employeeModal.email = me.$parent.employeeFocused.Email;
            me.employeeModal.bankAccountNumber = me.$parent.employeeFocused.BankAccountNumber;
            me.employeeModal.bankName = me.$parent.employeeFocused.BankName;
            me.employeeModal.bankBranch = me.$parent.employeeFocused.BankBranch;
        } else {
            me.getNewEmployeeCode();
        }
    },

    /* DOM thật */
    mounted() {
        console.log("mounted form")

    },

    /* Khi dữ liệu thay đổi, và trước khi render, patch lại và hiển thị ra cho người dùng */
    beforeUpdate() {
        console.log("beforeUpdate form")
    },

    /*  Sử dụng khi bạn cần truy cêập DOM sau khi thay đổi thuộc tính */
    updated() {
        console.log("updated form")

        
    },

    /* Đây là nơi để quản lý tài nguyên xóa tài nguyên, dọn dẹp các component */
    beforeUnmount() {

    },

    unmounted() {
        
    },

    //#endregion lifecycle

    methods: {
        //#region Call API
        /* API thêm nhân viên
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        apiInsertEmployee() {
/*             let me = this; */
            try {
                axios
                .post(Resource.Url.Employees, {
                    "employeeCode": this.employeeModal.employeeCode,
                    "firstName": "Tuan",
                    "lastName": "Tuan",
                    "employeeName": this.employeeModal.employeeName,
                    "gender": 0,
                    "dateOfBirth": "2022-12-22T09:53:59.901Z",
                    "phoneNumber": "string",
                    "email": "string",
                    "address": "string",
                    "identityNumber": "string",
                    "identityDate": "2022-12-22T09:53:59.901Z",
                    "identityPlace": "string",
                    "joinDate": "2022-12-22T09:53:59.901Z",
                    "martialStatus": 0,
                    "educationalBackground": 0,
                    "departmentId": "142cb08f-7c31-21fa-8e90-67245e8b283e",
                    "workStatus": 0,
                    "personalTaxCode": "string",
                    "salary": 0,
                    "telephoneNumber": "string",
                    "bankAccountNumber": "string",
                    "bankName": "string",
                    "bankBranchName": "string",
                    "bankProvinceName": "string",
                    "employeePosition": "string",
                    "departmentCode": "string",
                    "departmentName": "string",
                    "qualificationName": "string",
                    "createdDate": "2022-12-22T09:53:59.901Z",
                    "createdBy": "string",
                    "modifiedDate": "2022-12-22T09:53:59.901Z",
                    "modifiedBy": "string"
                })
                .then(() => {
                    /* Close modal */
                    // Reload data
                    this.loadAPI();


                });
            } catch (error) {
                console.log(error);
            }           
        },

        /* API sửa nhân viên
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
       apiUpdateEmployee() {

       },

        /* Sửa 1 tài sản
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        updateFixedAsset() {
            try {                                   
                axios
                .put(`${Resource.Url.FixedAssets}/${this.employeeModal.fixedAssetId}`, {
                    "fixed_asset_code": this.employeeModal.fixedAssetCode,
                    "fixed_asset_name": this.employeeModal.fixedAssetName,
                    "department_id": this.employeeModal.departmentId,
                    "department_code": this.employeeModal.departmentCode,
                    "department_name": this.employeeModal.departmentName,
                    "fixed_asset_category_id": this.employeeModal.categoryId,
                    "fixed_asset_category_code": this.employeeModal.categoryCode,
                    "fixed_asset_category_name": this.employeeModal.categoryName,
                    "purchase_date": this.employeeModal.purchaseDate,
                    "cost": this.employeeModal.cost,
                    "quantity": this.employeeModal.quantity,
                    "depreciation_rate": this.employeeModal.depreciationRate,
                    "tracked_year": this.employeeModal.trackedYear,
                    "life_time": this.employeeModal.lifeTime,
                    "production_date": this.employeeModal.productionDate,
                    "active": 0
                })
                .then(() => {
                    // Close modal 

                    // Reload data
                    this.loadAPI();

                    // Close modal
                    this.closeModalAction();

                    // Display success toast message 
                    this.showSuccessToast();
                })
                .catch((error) => {
                    var status = error.response.status;
                    this.handleException(status);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* Thêm 1 tài sản
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        insertFixedAsset() {
            try {
                axios
                .post(Resource.Url.Employees, {
                    "fixed_asset_code": this.employeeModal.fixedAssetCode,
                    "fixed_asset_name": this.employeeModal.fixedAssetName,
                    "department_id": this.employeeModal.departmentId,
                    "department_code": this.employeeModal.departmentCode,
                    "department_name": this.employeeModal.departmentName,
                    "fixed_asset_category_id": this.employeeModal.categoryId,
                    "fixed_asset_category_code": this.employeeModal.categoryCode,
                    "fixed_asset_category_name": this.employeeModal.categoryName,
                    "purchase_date": this.employeeModal.purchaseDate,
                    "production_date": this.employeeModal.productionDate,
                    "cost": this.employeeModal.cost,
                    "quantity": this.employeeModal.quantity,
                    "depreciation_rate": this.employeeModal.depreciationRate,
                    "tracked_year": this.employeeModal.trackedYear,
                    "life_time": this.employeeModal.lifeTime,
                    "active": 1,
                    "created_by": "string",
                    "created_date": "2022-11-27T14:26:42.330Z",
                    "modified_by": "string",
                    "modified_date": "2022-11-27T14:26:42.330Z" 
                })
                .then(() => {
                    /* Close modal */
                    // Reload data
                    this.loadAPI();

                    // Close modal
                    this.closeModalAction();

                    // Display success toast message 
                    this.showSuccessToast();
                })
                .catch((error) => {
                    var status = error.response;
                    console.log(status);
                });
            } catch (error) {
                console.log(error);
            }
        },

        /* Lấy mã nhân viên lớn nhất
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        getNewEmployeeCode() {
            let me = this;
            try {

                axios
                .get(`${Resource.Url.Employees}/NewEmployeeCode`)
                .then((resource) => {
                    me.employeeModal.employeeCode = resource.data;
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                })
            } catch (e) {
                console.log(e);
            }
        },
        //#endregion Call API

        //#region Modal click events 
        /* Ẩn dropdown khi blur
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        hideCategoryModal() {
            setTimeout(() => {
                this.category.showModal = false;
            }, 200);  
        },

        /* Ẩn dropdown khi blur
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        hideDepartmentModal() {
            setTimeout(() => {
                this.department.showModal = false;
            }, 200);  
        },

        /* Đưa phòng ban vào input modal
            @param {option} giá trị đc chọn trong vòng lặp for
            @returns void
            Author: Tuan 
            Modified Date: 4/11/2022 
        */
        departmentSelectDrilldown(option) {
            if(option.department_id == this.employeeModal.departmentId) {
                this.employeeModal.departmentId = '';
                this.employeeModal.departmentCode = '';
                this.employeeModal.departmentName = '';
            } else {
                this.employeeModal.departmentId = option.department_id;
                this.employeeModal.departmentCode = option.department_code;
                this.employeeModal.departmentName = option.department_name;     
            }
        },  

        /* Đưa tài sản vào input modal
            @param {option} giá trị đc chọn trong vòng lặp for
            @returns void
            Author: Tuan 
            Modified Date: 4/11/2022 
        */
        categorySelectDrilldown(option) {
            if(option.fixed_asset_category_id == this.employeeModal.categoryId) {
                this.employeeModal.categoryId = '';
                this.employeeModal.categoryCode = ''
                this.employeeModal.categoryName = ''
            } else {
                this.employeeModal.categoryId = option.fixed_asset_category_id;
                this.employeeModal.categoryCode = option.fixed_asset_category_code;
                this.employeeModal.categoryName = option.fixed_asset_category_name;     
                this.employeeModal.depreciationRate = option.depreciation_rate;
                this.employeeModal.lifeTime = option.life_time;
            }
        },

        /* Tab rollback về mã tài sản
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        tabRollback() {
            this.focusFirst();
        },

        /* Focus ô input đầu tiên
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        focusFirst() {
            let me = this;

            me.$nextTick(() => me.$refs.employeeCodeFocusing.focus());
        },

        /* Click huỷ trên form modal
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        onCancel() {
            /* Mở cảnh báo */
            this.isDisplayAlert = true;
        },

        /* Đóng modal khi đồng ý cảnh báo
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        closeModal(bool) {
            if(bool) this.closeModalAction();
            this.isDisplayAlert = false;
        },

        /* Các nghiệp vụ khi đóng modal
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        closeModalAction() {
            this.isSubmited = false;
            this.$parent.isDisplayModal = false;
            this.htmlToastSaveSuccess = "";
            this.htmlError = "";
        },


        //#endregion Modal click events 

        //#region Modal processing ui
        /* Check dữ liệu khi lưu
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        onSubmit() {
            this.isSubmited = true;
            
            try {
                if(this.validateForm()) {
                    this.apiInsertEmployee();
                }
            } catch (e) {
                console.log(e);
            }
        },
        //#endregion Modal processing ui

        
        //#region Modal format support
        /* formatDate
            @param {}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
        */
        formatDate(value){
            if (value) {
                return (moment(String(value)).format('YYYY-MM-DD'));
            }
        },

        /* handler key number
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
         */
        validate(evt, type) {
            var regex = /[0-9]/g;
            if (type) {
                regex = /[0-9|,]/g;
            }
            var theEvent = evt || window.event;

            // Handle paste
            if (theEvent.type === "paste") {
                key = event.clipboardData.getData("text/plain");
            } else {
                // Handle key press
                var key = theEvent.keyCode || theEvent.which;
                key = String.fromCharCode(key);
            }
            if (!regex.test(key)) {
                theEvent.returnValue = false;
                if (theEvent.preventDefault) theEvent.preventDefault();
            }
        },

        /* Input type="text" chỉ viết số
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */  
        numbersOnly(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
                evt.preventDefault();
            } else {
                return true;
            }
        },

        //#endregion Modal format data

        //#region Modal validate form

        /* Tạo thông điệp cho cảnh báo hiện nhiều lỗi
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */       
        createValidateMessage() {
            this.errorMessage = "";
            let i = 0;
            while(i < this.errorArray.length) {
                this.errorMessage = `${this.errorMessage} - ${this.errorArray[i]} </br>`;
                i++;
            }
        },

        /* Validate dữ liệu truyền vào
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        validateForm() {
            let me = this;
            me.v$.$validate()
            if (me.v$.$error) {
                if (this.v$.employeeModal.employeeCode.$error) {
                    me.errorMessage += this.textErrorMessage.EmptyCode;
                    me.$nextTick(() => me.$refs.employeeCodeFocusing.focus());
                } else if (me.v$.employeeModal.fullName.$error) {
                    me.errorMessage = this.textErrorMessage.EmptyName;
                } else if (me.v$.employeeModal.departmentName.$error) {
                    me.errorMessage = this.textErrorMessage.EmptyDepartmentName;
                }
                me.isShowValidate = true;
                return false;
            } else {
                return true;
            } 
        },
        //#endregion Modal validate input
    },

    validations: {
        // Các trường cần validate thiếu
        employeeModal: { 
            employeeCode: { required },
            fullName: { required },
            departmentName: { required },
        },
    },

    data() {
        return {
            //#region Dialog 
            isShowValidate: false, // Hiển thị dialog cảnh báo lỗi validate 

            errorMessage: "", // Thông điệp hiện trong dialog cảnh báo lỗi validate
            //#endregion

            //#region Data Modal 
            employeeModal: { // Dữ liệu form modal
                employeeID: '',
                employeeCode: '',
                fullName: '',
                dateOfBirth: "",
                gender: 0,
                departmentName: "",
                identityNumber: "",
                identityDate: "",
                positionName: "",
                identityPlace: "",
                address: "",
                phone: "",
                contact: "",
                email: "",
                bankAccountNumber: "",
                bankName: "",
                bankBranch: "",
            },
            employeeCodeUpdate: '',

            notifyShow: false, // Có hiển thị dialog cảnh báo hay không
            heightAlertValidate: 1,
            errorArray: [], // Dãy chứa các lỗi validate
            validateProShow: false, // Có hiển thị dialog cảnh báo lỗi validate nghiệp vụ hay không
            validateBackendShow: false,
            hasError: false,
            displayModal: false, /* Hiển thị modal */
            isDisplayAlert: false, /* Hiển thị cảnh báo khi huỷ*/
            htmlToastSaveSuccess: "", /* Hiển thị thông báo lưu dữ liệu thành công */
            htmlError: "", /* Hiển thị lỗi cảnh báo input */
            isDisplayValidate: false, // Toggle thông báo validate dữ liệu
            textValidate: '', // Dữ liệu thông báo
            textExceptionMsg: "", // Thông điệp trong cảnh báo lỗi backend
            backendError: false, // Có hiển thị dialog cảnh báo lỗi từ backend không
            /* Begin: Tên các nội dung */
            titleModal: Resource.TextVi.Modal.InsertModal,
            textInsertModal: Resource.TextVi.Modal.InsertModal,
            textUpdateModal: Resource.TextVi.Modal.UpdateModal,
            textEmployeeCode: Resource.TextVi.Modal.EmployeeCode, 
            textFullName: Resource.TextVi.Modal.FullName,
            textDateOfBirth: Resource.TextVi.Modal.DateOfBirth,
            textGender: Resource.TextVi.Modal.Gender,
            textDepartmentName: Resource.TextVi.Modal.DepartmentName,
            textIdentityNumber: Resource.TextVi.Modal.IdentityNumber,
            textIdentityDate: Resource.TextVi.Modal.IdentityDate,
            textPositionName: Resource.TextVi.Modal.PositionName,
            textIdentityPlace: Resource.TextVi.Modal.IdentityPlace,
            textAddress: Resource.TextVi.Modal.Address,
            textPhone: Resource.TextVi.Modal.Phone,
            textContact: Resource.TextVi.Modal.Contact,
            textEmail: Resource.TextVi.Modal.Email,
            textBankAccountNumber: Resource.TextVi.Modal.BankAccountNumber,
            textBankName: Resource.TextVi.Modal.BankName,
            textBankBranch: Resource.TextVi.Modal.BankBranch,
            /* End: Tên các nội dung */

            /* Begin: Tên các chức năng */
            textFunctionClose: Resource.TextVi.Modal.Close,
            textFunctionCancel: Resource.TextVi.Modal.Cancel,
            textFunctionInsert: Resource.TextVi.Modal.Insert,
            textFunctionUpdate: Resource.TextVi.Modal.Update,
            textFunctionSave: Resource.TextVi.Modal.Save,
            textFunctionAccept: Resource.TextVi.Modal.Accept,
            textFunctionYes: Resource.TextVi.Modal.Yes,
            textFunctionNo: Resource.TextVi.Modal.No,
            /* End: Tên các chức năng */
            //#endregion Data Modal

            textErrorMessage: { // Nội dung mã lỗi
                EmptyCode: Resource.TextVi.ErrorMessage.EmptyCode,
                EmptyName: Resource.TextVi.ErrorMessage.EmptyName,
                EmptyDepartmentName: Resource.TextVi.ErrorMessage.EmptyDepartmentName,
            },

            placeholder : {
                address: "VD: Số 82 Duy Tân, Dịch Vọng, Cầu Giấy, Hà Nội",
            },

            /* Một số thông tin khác */
            author: "Tuấn",
            v$: useValidate(), // Validate dữ liệu (sử dụng vuelidate)
        }   
    },


    watch: {
        functionUpdate: function(query) {
            console.log(query);
        }
    },

    computed: {
        /* Thực hiện format trường Số lượng
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        quantityFormat: {
            get: function() {
                if (this.employeeModal.quantity == null || this.employeeModal.quantity == 0 || this.employeeModal.quantity == "") return 0;
                return this.formatCurrency(parseInt(this.employeeModal.quantity));
            },
                // setter
            set: function(number) {
                number = this.formatNum(number);
                this.employeeModal.quantity = number;
            }
        },

        /* Thực hiện format trường Nguyên giá đồng thời tính lại giá trị hao mòn năm
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        costFormat: {
            get: function() {
                if (this.employeeModal.cost == null || this.employeeModal.cost == 0 || this.employeeModal.cost == "") return 0;
                return this.formatCurrency(parseInt(this.employeeModal.cost));
            },
                // setter
            set: function(number) {
                number = this.formatNum(number);
                if (number != 0 && number != null && number != '') {
                    this.employeeModal.cost = number;
                    this.employeeModal.depreciation = (this.employeeModal.depreciationRate*0.01 * this.employeeModal.cost);
                    this.employeeModal.depreciation = Math.floor(this.employeeModal.depreciation);
                } else {
                    this.employeeModal.cost = '';
                }
            }
        },

        /* Thực hiện format số năm sử dụng
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        lifeTimeFormat: {
            get: function() {
                if (this.employeeModal.lifeTime == null || this.employeeModal.lifeTime == 0 || this.employeeModal.lifeTime == "" || this.employeeModal.lifeTime == Infinity) return 0;
                return this.formatCurrency(parseInt(this.employeeModal.lifeTime));

            },
            set: function(number) {
                number = this.formatNum(number);
                if (number == null || number == 0 || number == "" || number == Infinity) {
                    this.employeeModal.lifeTime = '';
                    this.employeeModal.depreciationRate = '';
                } else {
                    this.employeeModal.lifeTime = number;
                    this.employeeModal.depreciationRate = (100 / number).toFixed(2);
                    this.employeeModal.depreciation = (parseFloat(this.employeeModal.depreciationRate)*0.01 * this.employeeModal.cost);
                    this.employeeModal.depreciation = Math.floor(this.employeeModal.depreciation);
                }
            }
        },

        /* Thực hiện format tỷ lệ hao mòn đồng thời tính lại giá trị hao mòn năm
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        depreciationRateFormat: {
            get: function() {
                let rate = this.employeeModal.depreciationRate;
                if (rate == null || rate == '0' || rate == "") 
                    return "00,00";     
                return this.formatDecimal(rate);
            },

            set: function(number) {
                let tmp = number;
                tmp = tmp.replaceAll(',', '.');
                if (tmp == null || tmp == '' || tmp == 0) {
                    this.employeeModal.depreciationRate = 0;
                    this.employeeModal.lifeTime = 0;
                    this.employeeModal.depreciation = 0;
                } else if (isNaN(this.employeeModal.lifeTime) || isNaN(tmp)) {
                    this.employeeModal.lifeTime = 0;
                    this.employeeModal.depreciation = 0;
                } else {
                    this.employeeModal.depreciationRate =  tmp;
                    this.employeeModal.depreciation = (parseFloat(tmp)*0.01 * this.employeeModal.cost);
                    this.employeeModal.depreciation = Math.floor(this.employeeModal.depreciation);
                    this.employeeModal.lifeTime = Math.floor((100 / tmp));
                }
            }
        },

        /* Tự động thêm tên tài sản khi điền mã tài sản
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        departmentSelection: {
            get: function() {
                return this.employeeModal.departmentCode;
            },

            set: function(code) {
                this.employeeModal.departmentCode = code;
                for(var i=0; i<this.departments.length; i++) {
                    if(this.departments[i].department_code == code) {
                        this.employeeModal.departmentName = this.departments[i].department_name;
                        this.employeeModal.departmentId = this.departments[i].department_id;
                        break;
                    } else {
                        this.employeeModal.departmentName = ""
                        this.employeeModal.departmentId = ""                   
                    }
                }         
            }
        },
        
        /* Tự động thêm tên tài sản khi điền mã tài sản
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        categorySelection: {
            get: function() { 
                return this.employeeModal.categoryCode;
            },

            set: function(code) {
                this.employeeModal.categoryCode = code;
                for(var i=0; i<this.categories.length; i++) {
                    if(this.categories[i].fixed_asset_category_code == code) {
                        this.employeeModal.categoryId = this.categories[i].fixed_asset_category_id;
                        this.employeeModal.categoryName = this.categories[i].fixed_asset_category_name;
                        this.employeeModal.lifeTime = this.categories[i].life_time;
                        this.employeeModal.depreciationRate = this.categories[i].depreciation_rate;
                        break;
                    } else {
                        this.employeeModal.categoryId = "";
                        this.employeeModal.categoryName = "";
                    }
                }         
            }
        }
    },
}
</script>