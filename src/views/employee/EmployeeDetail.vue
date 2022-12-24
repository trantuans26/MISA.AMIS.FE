<template>
    <div class="modal modal--open">                     
        <div class="modal__main"
            @submit.prevent="onSubmit()"
        >
            <div class="modal__section modal__icon">
                <div class="modal__support">
                    <i class="icon icon--support"></i>
                </div>
                <div class="modal__close" @click="onClose()">
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
                                <base-message-error :text="this.textEmployeeCode"></base-message-error>
                            </div>
            
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textEmployeeName}} <em>*</em>
                                </label>
                                <input class="input input--modal" type="text"
                                    ref="employeeNameFocusing" 
                                    :class="{'input--error': this.isSubmited && !this.employeeModal.employeeName}"
                                    v-model.trim="this.employeeModal.employeeName"
                                    maxlength="255"
                                >
                                <base-message-error :text="this.textEmployeeName"></base-message-error>
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
                                    <base-message-error :text="this.textDepartmentName"></base-message-error>
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
                                <base-message-error :text="this.textPositionName"></base-message-error>
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
                                    <base-message-error :text="this.textDateOfBirth"></base-message-error>
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
                                <base-message-error :text="textIdentityNumber"></base-message-error>
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
                                    <base-message-error :text="this.textIdentityDate"></base-message-error>
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
                                <base-message-error :text="this.textIdentityPlace"></base-message-error>
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
                            <base-message-error :text="this.textAddress"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label" data-title="Điện thoại di dộng">
                                {{this.textPhone}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.phone"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error :text="this.textPhone"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label"  data-title="Điện thoại cố định">
                                {{this.textContact}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.contact"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error :text="this.textContact"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textEmail}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.email"
                                placeholder="example@email.com"
                                maxlength="50"
                            >
                            <base-message-error :text="this.textEmail"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankAccountNumber}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
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
                                class="input input--modal input--174" type="text"  
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
                                class="input input--modal" type="text"  
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
                    <button class="btn btn__save btn__save--space" @click="onSubmit(), this.saveAndInsert = true">Cất và Thêm</button>
                    <div tabindex="0" class="btn btn--outline" @click="onSubmit(), this.saveAndInsert = false">Cất</div> 
                </div>

                <div class="modal__footer--end">
                    <div tabindex="0" @click="this.closeModalAction()" class="btn btn--outline">Huỷ</div> 
                    <button v-on:focus="tabRollback()" class="btn__tabRollback"></button>
                </div>
            </footer>
            <!-- END: Modal footer -->
        </div>
    </div>

    <!-- Begin: Dialog validate dữ liệu -->
    <BDialog
        v-show="this.isShowValidate"
    >
        <template #title>
            {{ this.textDialog.title.error }}
        </template>

        <template #message>
            <p>{{this.errorMessage}}</p>
        </template>

        <template #footer>
            <div class="dialog__footer">
                <div class="btn btn--dialog btn--red"
                    @click="this.isShowValidate = false, this.errorMessage = ''"
                >{{ this.textFunctionClose }}</div>
            </div>
        </template>
    </BDialog>
    <!-- End: Dialog validate dữ liệu -->

    <!-- Begin: Dialog click icon đóng modal -->
    <BDialog
        v-show="this.isShowCloseDialog"
    >
        <template #title>
            {{ this.textDialog.title.change }}
        </template>

        <template #message>
            <p>{{this.textDialog.text.save}}</p>
        </template>

        <template #footer>
            <div class="dialog__footer">
                <div class="btn btn--dialog"
                    @click="onSubmit(), closeModal(false)"
                >{{ this.textDialog.yes }}</div>

                <div class="btn btn--dialog btn--outline"
                    @click="closeModal(true)"
                >{{ this.textDialog.no }}</div>

                <div class="btn btn--dialog btn--outline"
                    @click="closeModal(false)"
                >{{ this.textFunctionCancel }}</div>
            </div>
        </template>
    </BDialog>
    <!-- End: Dialog click icon đóng modal -->

    <!-- Begin: Toast thông báo -->
    <BToast
        v-show="this.isShowSuccessToast"
        @closeToast="this.isShowSuccessToast = false"
    >
        <template #text>
            {{ this.$parent.updateFunction ? this.textToastMessage.success.update : this.textToastMessage.success.insert }}
        </template>
    </BToast>
    <!-- End: Toast thông báo -->
</template>

<script>
import axios from "axios";
import moment from 'moment'
import Resource from "@/lib/resource";
import BDialog from "@/components/base/dialog/BDialog.vue";
import BToast from "@/components/base/toast/BToast.vue";
import useValidate from '@vuelidate/core';
import {required} from '@vuelidate/validators';
import BaseMessageError from "@/components/base/message/BaseMessageError.vue";

export default {
    name: "EmployeeDetail",
    components: {
        BaseMessageError,
        BDialog,
        BToast
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
            me.employeeModal.employeeID = me.$parent.employeeFocused.EmployeeId;
            me.employeeModal.employeeCode = me.$parent.employeeFocused.EmployeeCode;
            me.employeeModal.employeeName = me.$parent.employeeFocused.EmployeeName;
            me.employeeModal.departmentId = me.$parent.employeeFocused.DepartmentId;
            me.employeeModal.departmentCode = me.$parent.employeeFocused.DepartmentCode;
            me.employeeModal.departmentName = me.$parent.employeeFocused.DepartmentName;
            me.employeeModal.positionName = me.$parent.employeeFocused.PositionName;
            me.employeeModal.dateOfBirth = this.formatDate(me.$parent.employeeFocused.DateOfBirth);
            me.employeeModal.gender = me.$parent.employeeFocused.Gender;
            me.employeeModal.identityNumber = me.$parent.employeeFocused.IdentityNumber;
            me.employeeModal.identityDate = this.formatDate(me.$parent.employeeFocused.IdentityDate);
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
                    "employeeName": this.employeeModal.employeeName,
                    "gender": this.employeeModal.gender,
                    "dateOfBirth": this.employeeModal.dateOfBirth,
                    "phoneNumber": this.employeeModal.phoneNumber,
                    "email": this.employeeModal.email,
                    "address": this.employeeModal.address,
                    "identityNumber": this.employeeModal.identityNumber,
                    "identityDate": this.employeeModal.identityDate,
                    "identityPlace": this.employeeModal.identityPlace,
                    "departmentId": "142cb08f-7c31-21fa-8e90-67245e8b283e",
                    "telephoneNumber": this.employeeModal.phone,
                    "bankAccountNumber": this.employeeModal.bankNumber,
                    "bankName": this.employeeModal.bankName,
                    "bankBranchName": this.employeeModal.bankBranch,
                    "employeePosition": this.employeeModal.jobPosition,
                    "departmentCode": "string",
                    "departmentName": "string",
                    "createdDate": "2022-12-22T09:53:59.901Z",
                    "createdBy": "string",
                })
                .then(() => {
                    /* Close modal */
                    // Reload data
                    this.$parent.loadAPI();
                    this.loadModal();
                    if (this.saveAndInsert) {
                        this.$emit('closeModal', true)
                    } else {
                        this.$emit('showSuccessToast');
                        this.$emit('closeModal', false);
                    } 
                    this.showSuccessToast();
                })
                .catch((error) => {
                    var status = error.response.status;
                    console.error(status);
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
            try {                                   
                axios
                .put(`${Resource.Url.Employees}/${this.employeeModal.employeeID}`, {
                    "employeeCode": this.employeeModal.employeeCode,
                    "employeeName": this.employeeModal.employeeName,
                    "gender": this.employeeModal.gender,
                    "dateOfBirth": this.employeeModal.dateOfBirth,
                    "phoneNumber": this.employeeModal.phoneNumber,
                    "email": this.employeeModal.email,
                    "address": this.employeeModal.address,
                    "identityNumber": this.employeeModal.identityNumber,
                    "identityDate": this.employeeModal.identityDate,
                    "identityPlace": this.employeeModal.identityPlace,
                    "departmentId": "142cb08f-7c31-21fa-8e90-67245e8b283e",
                    "telephoneNumber": this.employeeModal.phone,
                    "bankAccountNumber": this.employeeModal.bankNumber,
                    "bankName": this.employeeModal.bankName,
                    "bankBranchName": this.employeeModal.bankBranch,
                    "employeePosition": this.employeeModal.jobPosition,
                    "departmentCode": "string",
                    "departmentName": "string",
                    "modifiedDate": "2022-12-22T09:53:59.901Z",
                    "modifiedBy": this.author,
                })
                .then(() => {
                    this.$parent.loadAPI();
                    this.loadModal();
                    if (this.saveAndInsert) {
                        this.$emit('closeModal', true)
                    } else {
                        this.$emit('showSuccessToast');
                        this.$emit('closeModal', false);
                    } 
                    this.showSuccessToast();
                })
                .catch((error) => {
                    console.error(error);
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
                    console.log('resset code');
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                })
            } catch (e) {
                console.log(e);
            }
        },
        //#endregion Call API

        //#region Modal chức năng
        /* Cất nhân viên
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        onSubmit() {
            this.isSubmited = true;
            
            try {
                if(this.validateForm()) {
                    if(this.$parent.updateFunction) {
                        this.apiUpdateEmployee();
                    } else {
                        this.apiInsertEmployee();
                    }
                }
            } catch (e) {
                console.log(e);
            }
        },
        //#endregion Modal chức năng

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
            Date: 24/12/2022 
        */
        tabRollback() {
            this.focusFirst();
        },

        /* Focus ô input đầu tiên
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        focusFirst() {
            let me = this;

            me.$nextTick(() => me.$refs.employeeCodeFocusing.focus());
        },

        /* Click huỷ trên form modal
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        onClose() {
            /* Mở cảnh báo */
            this.isShowCloseDialog = true;
        },

        /* Đóng modal khi đối số là true
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        closeModal(bool) {
            if(bool) this.closeModalAction();
            this.isShowCloseDialog = false;
        },

        /* Các nghiệp vụ khi đóng modal
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        closeModalAction() {
            this.isSubmited = false;
            this.$parent.isDisplayModal = false;
        },


        //#endregion Modal click events 

        //#region Modal xử lý hiển thị


        /* Load lại form modal trống
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        loadModal() {
            let me = this;
            me.isSubmited = false;

            me.getNewEmployeeCode();
            me.employeeModal.employeeID = '';
            me.employeeModal.employeeName = '';
            me.employeeModal.departmentId = '';
            me.employeeModal.departmentCode = '';
            me.employeeModal.departmentName = '';
            me.employeeModal.positionName = '';
            me.employeeModal.dateOfBirth = '';
            me.employeeModal.gender = 0;
            me.employeeModal.identityNumber = '';
            me.employeeModal.identityDate = '';
            me.employeeModal.identityPlace = '';
            me.employeeModal.address = '';
            me.employeeModal.phone = '';
            me.employeeModal.contact = '';
            me.employeeModal.email = '';
            me.employeeModal.bankAccountNumber = '';
            me.employeeModal.bankName = '';
            me.employeeModal.bankBranch = '';
        },

        /* Show toast thêm thành công
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/12/2022 
        */
        showSuccessToast() {
            this.isShowSuccessToast = true;
            setTimeout(() => this.isShowSuccessToast = false, 2400); 
        },
        //#endregion Modal processing ui

        //#region Modal format support
        /* formatDate
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
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
                } else if (me.v$.employeeModal.employeeName.$error) {
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
            employeeName: { required },
            departmentName: { required },
        },
    },

    data() {
        return {
            //#region Dialog 
            isShowValidate: false, // Hiển thị dialog cảnh báo lỗi validate 

            errorMessage: "", // Thông điệp hiện trong dialog cảnh báo lỗi validate
            //#endregion

            //#region Toast 
            isShowSuccessToast: false, // Hiển thị toast message

            //#endregion Toast

            //#region Data Modal 
            employeeModal: { // Dữ liệu form modal
                employeeID: '',
                employeeCode: '',
                employeeName: '',
                dateOfBirth: "",
                gender: 0,
                departmentID: "",
                identityNumber: "",
                identityDate: "",
                jobPosition: "",
                identityPlace: "",
                address: "",
                phone: "",
                contact: "",
                email: "",
                bankNumber: "",
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
            isShowCloseDialog: false, /* Hiển thị cảnh báo khi huỷ*/
            htmlToastSaveSuccess: "", /* Hiển thị thông báo lưu dữ liệu thành công */
            htmlError: "", /* Hiển thị lỗi cảnh báo input */
            isDisplayValidate: false, // Toggle thông báo validate dữ liệu
            textValidate: '', // Dữ liệu thông báo
            textExceptionMsg: "", // Thông điệp trong cảnh báo lỗi backend
            backendError: false, // Có hiển thị dialog cảnh báo lỗi từ backend không
            saveAndInsert: false, // Cất và Thêm

            //#region Tên title và các label
            titleModal: Resource.TextVi.Modal.InsertModal,
            textInsertModal: Resource.TextVi.Modal.InsertModal,
            textUpdateModal: Resource.TextVi.Modal.UpdateModal,
            textEmployeeCode: Resource.TextVi.Modal.EmployeeCode, 
            textEmployeeName: Resource.TextVi.Modal.EmployeeName,
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
            //#endregion Tên title và các label

            //#region Tên các chức năng
            textFunctionClose: Resource.TextVi.Modal.Close,
            textFunctionCancel: Resource.TextVi.Modal.Cancel,
            textFunctionInsert: Resource.TextVi.Modal.Insert,
            textFunctionUpdate: Resource.TextVi.Modal.Update,
            textFunctionSave: Resource.TextVi.Modal.Save,
            textFunctionAccept: Resource.TextVi.Modal.Accept,
            textFunctionYes: Resource.TextVi.Modal.Yes,
            textFunctionNo: Resource.TextVi.Modal.No,
            //#endregion Tên các chức năng

            //#endregion Data Modal

            textErrorMessage: { // Nội dung mã lỗi
                EmptyCode: Resource.TextVi.ErrorMessage.EmptyCode,
                EmptyName: Resource.TextVi.ErrorMessage.EmptyName,
                EmptyDepartmentName: Resource.TextVi.ErrorMessage.EmptyDepartmentName,
            },

            textToastMessage: { // Nội dung Toast
                success: {
                    title: Resource.TextVi.ToastMessage.Success.Title,
                    insert: Resource.TextVi.ToastMessage.Success.Insert,
                    update: Resource.TextVi.ToastMessage.Success.Update,
                } 
            },

            textDialog: {
                save: Resource.TextVi.Dialog.Save,
                notSave: Resource.TextVi.Dialog.NotSave,
                yes: Resource.TextVi.Dialog.Yes,
                no: Resource.TextVi.Dialog.No,
                close: Resource.TextVi.Dialog.Close,
                cancel: Resource.TextVi.Dialog.Cancel,
                accept: Resource.TextVi.Dialog.Accept,
                title: {
                    error: Resource.TextVi.Dialog.Title.Error,
                    change: Resource.TextVi.Dialog.Title.Change,
                },
                text: {
                    save: Resource.TextVi.Dialog.Text.Save,
                }
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