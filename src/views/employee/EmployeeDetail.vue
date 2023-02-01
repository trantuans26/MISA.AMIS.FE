<template>
    <div class="modal modal--open"
        @keyup.ctrl.shift.s="onSubmit(), this.saveAndInsert = true"
        @keyup.esc="onClose()"
        @keyup.enter="this.isShowValidationDialog = false, this.isShowValidationDialogBackend = false"
    >     
        <BLoading v-show="isShowLoadingModal" loadingClass="loading--modal"></BLoading>

        <div class="modal__main"
            @submit.prevent="onSubmit()"
        >
            <div class="modal__section modal__icon">
                <div class="modal__support"
                    :data-title="this.textTooltip.help"
                >
                    <i class="icon icon--support"></i>
                </div>
                <div class="modal__close"
                    @click="onClose()"
                    :data-title="this.textTooltip.close"
                >
                    <i class="icon icon--close"></i>
                </div>
            </div>

            <header class="modal__section modal__header">
                <div class="modal__title">{{titleModal}}</div>
                <div class="modal__checkbox modal--customer">
                    <input id="modal_input--customer" type="checkbox">
                    <label for="modal_input--customer">{{ textCustomer }}</label>
                </div>
                <div class="modal__checkbox modal--supplier">
                    <input id="modal_input--supplier" type="checkbox">
                    <label for="modal_input--supplier">{{ textSupplier }}</label>
                </div>
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
                                    :class="{'input--error': this.isShowValidity.emptyEmployeeCode && !this.employeeModal.employeeCode}"
                                    v-model.trim="this.employeeModal.employeeCode"
                                    type="text" 
                                    maxlength="20"
                                    @click="this.isShowValidity.emptyEmployeeCode = false"
                                    @blur = "this.isShowValidity.emptyEmployeeCode = true"
                                >
                                <base-message-error :text="this.textEmployeeCode"></base-message-error>
                            </div>
            
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textEmployeeName}} <em>*</em>
                                </label>
                                <input class="input input--modal" type="text"
                                    ref="employeeNameFocusing" 
                                    :class="{'input--error': this.isShowValidity.emptyEmployeeName && !this.employeeModal.employeeName}"
                                    v-model.trim="this.employeeModal.employeeName"
                                    maxlength="100"
                                    @blur ="this.isShowValidity.emptyEmployeeName = true"
                                    @click="this.isShowValidity.emptyEmployeeName = false"
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

                                <BCombobox
                                    :url= "url.department"
                                    propValue="departmentID"
                                    propCode="departmentCode"
                                    propText="departmentName"
                                    :fieldName="this.textDepartmentName"
                                    :propPlaceholder="this.placeholder.department"
                                    :setID="employeeModal.departmentID" 
                                    :setValue="employeeModal.departmentName"
                                    @getID = "employeeModal.departmentID = $event"
                                    @getCode = "employeeModal.departmentCode = $event"
                                    @getName = "employeeModal.departmentName = $event"
                                    :required="this.isShowValidity.emptyDepartmentID"
                                    @onClick="this.isShowValidity.emptyDepartmentID = $event"
                                    @onBlur="this.isShowValidity.emptyDepartmentID = $event"
                                    :addFocus="this.focusDepartment"
                                    @removeFocus="this.focusDepartment = $event"
                                    @onChange="checkChangeDepartment($event)"
                                >
                                </BCombobox>
                            </div>
                        </div>

                        <!-- Chức danh -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textJobPosition}}
                                </label>
                                <input 
                                    class="input input--modal" type="text"  
                                    v-model.trim="this.employeeModal.jobPosition"
                                    placeholder=""
                                    maxlength="100"
                                >
                                <base-message-error :text="this.textJobPosition"></base-message-error>
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
                                    <Datepicker v-model="this.employeeModal.dateOfBirth" :format="datingFormat" hidden></Datepicker>
                                    <input 
                                        type="date" 
                                        v-model="this.employeeModal.dateOfBirth"
                                        @change="checkDate()"
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
                                    <input id="gender__male" type="radio" v-model="this.employeeModal.gender" value="0"> <label for="gender__male">Nam</label>
                                    <input id="gender__female" type="radio" v-model="this.employeeModal.gender" value="1"> <label for="gender__female">Nữ</label>
                                    <input id="gender__other" type="radio" v-model="this.employeeModal.gender" value="2"> <label for="gender__other">Khác</label>
                                </div>
                            </div>
                        </div>

                        <!-- Số CMND / Ngày cấp -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label" :data-title="textTooltip.identityNumber">
                                    {{this.textIdentityNumber}}
                                </label>
                                <input 
                                    class="input input--haveicon input--modal" type="text"  
                                    v-model.trim="this.employeeModal.identityNumber"
                                    @keydown="numbersOnly(event)"
                                    @paste="formatIdentityNumber"
                                    placeholder=""
                                    maxlength="255"
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
                                    maxlength="255"
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
                                maxlength="255"
                            >
                            <base-message-error :text="this.textAddress"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label" :data-title="textTooltip.phone">
                                {{this.textPhone}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.phone"
                                @keydown="numbersOnly(event)"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error :text="this.textPhone"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label" :data-title="textTooltip.fax">
                                {{this.textFax}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.fax"
                                @keydown="numbersOnly(event)"
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error :text="this.textFax"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textEmail}}
                            </label>
                            <input
                                class="input input--modal input--220" type="text"  
                                v-model.trim="this.employeeModal.email"
                                placeholder="example@email.com"
                                maxlength="100"
                            >
                            <base-message-error :text="this.textEmail"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankNumber}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.bankNumber"
                                @keydown="numbersOnly(event)"
                                placeholder=""
                                maxlength="255"
                            >
                            <base-message-error :text="this.textBankNumber"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankName}}
                            </label>
                            <input
                                class="input input--modal input--174" type="text"  
                                v-model.trim="this.employeeModal.bankName"
                                placeholder=""
                                maxlength="255"
                            >
                            <base-message-error :text="this.textBankName"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textBankBranch}}
                            </label>
                            <input
                                class="input input--modal" type="text"  
                                v-model.trim="this.employeeModal.bankBranch"
                                placeholder=""
                                maxlength="255"
                            >
                            <base-message-error :text="this.textBankBranch"></base-message-error>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: Modal body -->

            <!-- Begin: Modal footer -->
            <footer class="modal__section modal__footer">
                <div class="modal__footer--start">
                    <button class="btn btn__save btn__save--space"
                        @click="onSubmit(), this.saveAndInsert = true"
                        :data-title="this.textTooltip.saveAndInsert"
                    > {{ this.textFunctionSaveAndInsert }}</button>
                    <div tabindex="0" class="btn btn--outline" 
                        @click="onSubmit(), this.saveAndInsert = false"
                    >{{ this.textFunctionSave }}</div> 
                </div>

                <div class="modal__footer--end">
                    <div tabindex="0" @click="onClose()" class="btn btn--outline">{{ this.textFunctionCancel }}</div> 
                    <button v-on:focus="tabRollback()" class="btn__tabRollback"></button>
                </div>
            </footer>
            <!-- END: Modal footer -->
        </div>
    </div>

    <!-- Begin: Dialog validate dữ liệu -->
    <BDialog
        v-show="this.isShowValidationDialog"
        @closeDialog="(this.isShowValidationDialog = $event), this.errorMessage = ''"
    >
        <template #icon>
            <i class="icon icon--errorDialog"></i>
        </template>

        <template #message>
            <p class="dialog__message--validate">{{this.errorMessage}}.</p>
        </template>

        <template #footer>
            <div class="dialog__footer dialog__footer--error">
                <div class="btn btn--dialog"
                    @click="closeValidationDialog()"
                >{{ this.textFunctionClose }}</div>
            </div>
        </template>
    </BDialog>
    <!-- End: Dialog validate dữ liệu -->

    <!-- Begin: Dialog check mã trùng -->
    <BDialog
        v-show="this.isShowValidationDialogBackend"
        @closeDialog="(this.isShowValidationDialogBackend = $event), this.errorMessage = ''"
    >
        <template #icon>
            <i class="icon icon--warningDialog"></i>
        </template>

        <template #message>
            <p class="dialog__message--validate">{{this.errorMessage}}.</p>
        </template>

        <template #footer>
            <div class="dialog__footer dialog__footer--warning">
                <div class="btn btn--dialog"
                    @click="closeValidationDialog()"
                >{{ this.textFunctionAccept }}</div>
            </div>
        </template>
    </BDialog>
    <!-- End: Dialog check mã trùng -->

    <!-- Begin: Dialog click icon đóng modal -->
    <BDialog
        v-show="this.isShowCloseDialog"
        @closeDialog="(closeModal($event))"
    >
        <template #icon>
            <i class="icon icon--questionDialog"></i>
        </template>

        <template #message>
            <p class="dialog__message--question">{{this.textDialog.title.change + " " + this.textDialog.text.save}}</p>
        </template>

        <template #footer>
            <div class="dialog__footer">
                <div class="dialog__footer--right">
                    <div class="btn btn--dialog margin__left--8"
                        @click="onSubmit(), closeModal(false)"
                    >{{ this.textDialog.yes }}</div>

                    <div class="btn btn--dialog btn--outline"
                        @click="closeModal(true)"
                    >{{ this.textDialog.no }}</div>
                </div>

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
import Enum from "@/lib/enum";
import Resource from "@/lib/resource";
import BDialog from "@/components/base/dialog/BDialog.vue";
import BToast from "@/components/base/toast/BToast.vue";
import BLoading from '@/components/base/loading/BLoading.vue'
import BCombobox from "@/components/base/combobox/BCombobox.vue";
import useValidate from '@vuelidate/core';
import {required} from '@vuelidate/validators';
import BaseMessageError from "@/components/base/message/BaseMessageError.vue";
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'

export default {
    name: "EmployeeDetail",
    components: {
        BaseMessageError,
        BDialog,
        BToast,
        BLoading,
        BCombobox,
        Datepicker,
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
    
    setup() {
        const datingFormat = (date) => {
            const day = date.getDate();
            const month = date.getMonth() + 1;
            const year = date.getFullYear();

            return `${month}/${day}/${year}`;
        
        }

        return {
            datingFormat,
        }
    },

    /* Khởi tạo giá trị mặc định khi vào DOM thật */
    async beforeMount() {
        console.log("beforeMount form")
        let me = this;

        me.$nextTick(() => me.$refs.employeeCodeFocusing.focus());
        me.apiGetAllDepartments();

        if(me.$parent.updateFunction) {
            me.titleModal = me.textUpdateModal;
            me.employeeModal.employeeID = me.$parent.employeeFocused.employeeID;
            me.employeeModal.employeeCode = me.$parent.employeeFocused.employeeCode;
            me.employeeModal.employeeName = me.$parent.employeeFocused.employeeName;
            me.employeeModal.departmentID = me.$parent.employeeFocused.departmentID;
            me.employeeModal.departmentCode = me.$parent.employeeFocused.departmentCode;
            me.employeeModal.departmentName = me.$parent.employeeFocused.departmentName;
            me.employeeModal.jobPosition = me.$parent.employeeFocused.jobPosition;
            me.employeeModal.dateOfBirth = this.formatDate(me.$parent.employeeFocused.dateOfBirth);
            me.employeeModal.gender = me.$parent.employeeFocused.gender;
            me.employeeModal.identityNumber = me.$parent.employeeFocused.identityNumber;
            me.employeeModal.identityDate = this.formatDate(me.$parent.employeeFocused.identityDate);
            me.employeeModal.identityPlace = me.$parent.employeeFocused.identityPlace;
            me.employeeModal.address = me.$parent.employeeFocused.address;
            me.employeeModal.phone = me.$parent.employeeFocused.phone;
            me.employeeModal.fax = me.$parent.employeeFocused.fax;
            me.employeeModal.email = me.$parent.employeeFocused.email;
            me.employeeModal.bankNumber = me.$parent.employeeFocused.bankNumber;
            me.employeeModal.bankName = me.$parent.employeeFocused.bankName;
            me.employeeModal.bankBranch = me.$parent.employeeFocused.bankBranch;
        } else if(me.$parent.replicateFunction) {
            me.titleModal = me.textInsertModal;
            await me.getNewEmployeeCode();
            me.employeeModal.employeeName = me.$parent.employeeFocused.employeeName;
            me.employeeModal.departmentID = me.$parent.employeeFocused.departmentID;
            me.employeeModal.departmentCode = me.$parent.employeeFocused.departmentCode;
            me.employeeModal.departmentName = me.$parent.employeeFocused.departmentName;
            me.employeeModal.jobPosition = me.$parent.employeeFocused.jobPosition;
            me.employeeModal.dateOfBirth = this.formatDate(me.$parent.employeeFocused.dateOfBirth);
            me.employeeModal.gender = me.$parent.employeeFocused.gender;
            me.employeeModal.identityNumber = me.$parent.employeeFocused.identityNumber;
            me.employeeModal.identityDate = this.formatDate(me.$parent.employeeFocused.identityDate);
            me.employeeModal.identityPlace = me.$parent.employeeFocused.identityPlace;
            me.employeeModal.address = me.$parent.employeeFocused.address;
            me.employeeModal.phone = me.$parent.employeeFocused.phone;
            me.employeeModal.fax = me.$parent.employeeFocused.fax;
            me.employeeModal.email = me.$parent.employeeFocused.email;
            me.employeeModal.bankNumber = me.$parent.employeeFocused.bankNumber;
            me.employeeModal.bankName = me.$parent.employeeFocused.bankName;
            me.employeeModal.bankBranch = me.$parent.employeeFocused.bankBranch;
        } else {
            await me.getNewEmployeeCode();
        }

        me.employeeJSON = JSON.stringify(me.employeeModal);
        console.log(me.employeeJSON);
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
            let me = this;
            me.isShowLoadingModal = true;
            try {
                axios
                .post(Resource.Url.Employees, {
                    "employeeCode": me.employeeModal.employeeCode,
                    "employeeName": me.employeeModal.employeeName,
                    "departmentID": me.employeeModal.departmentID,
                    "jobPosition": me.employeeModal.jobPosition,
                    "dateOfBirth": me.employeeModal.dateOfBirth == '' ? null : me.employeeModal.dateOfBirth,
                    "gender": me.employeeModal.gender,
                    "phone": me.employeeModal.phoneNumber,
                    "email": me.employeeModal.email,
                    "address": me.employeeModal.address,
                    "fax": me.employeeModal.fax,
                    "identityNumber": me.employeeModal.identityNumber,
                    "identityDate": me.employeeModal.identityDate == '' ? null : me.employeeModal.identityDate,
                    "identityPlace": me.employeeModal.identityPlace,
                    "bankNumber": me.employeeModal.bankNumber,
                    "bankName": me.employeeModal.bankName,
                    "bankBranch": me.employeeModal.bankBranch,
                    "createdDate": new Date(),
                    "createdBy": this.author,
                    "modifiedDate": new Date(),
                    "modifiedBy": this.author,
                })
                .then(() => {
                    /* Close modal */
                    // Reload data
                    me.$parent.loadAPI();
                    me.loadModal();
                    if (me.saveAndInsert) {
                        me.$emit('closeModal', true)
                    } else {
                        me.$emit('showSuccessToast');
                        me.$emit('closeModal', false);
                    } 
                    
                    me.isShowLoadingModal = false;
                    me.showSuccessToast();
                })
                .catch((error) => {
                    console.log("error", error);
                    me.validateBackend(error.response);
                    me.isShowLoadingModal = false;
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
            let me = this;
            me.isShowLoadingModal = true;

            try {                                       
                axios
                .put(`${Resource.Url.Employees}/${me.employeeModal.employeeID}`, {
                    "employeeCode": me.employeeModal.employeeCode,
                    "employeeName": me.employeeModal.employeeName,
                    "departmentID": me.employeeModal.departmentID,
                    "jobPosition": me.employeeModal.jobPosition,
                    "dateOfBirth": me.employeeModal.dateOfBirth == '' ? null : me.employeeModal.dateOfBirth,
                    "gender": me.employeeModal.gender,
                    "phone": me.employeeModal.phone,
                    "email": me.employeeModal.email,
                    "address": me.employeeModal.address,
                    "fax": me.employeeModal.fax,
                    "identityNumber": me.employeeModal.identityNumber,
                    "identityDate": me.employeeModal.identityDate == '' ? null : me.employeeModal.identityDate,
                    "identityPlace": me.employeeModal.identityPlace,
                    "bankNumber": me.employeeModal.bankNumber,
                    "bankName": me.employeeModal.bankName,
                    "bankBranch": me.employeeModal.bankBranch,
                    "modifiedDate": new Date(),
                    "modifiedBy": this.author,
                })
                .then(() => {
                    me.$parent.loadAPI();
                    me.loadModal();
                    if (me.saveAndInsert) {
                        me.$emit('closeModal', true)
                    } else {
                        me.$emit('showSuccessToast');
                        me.$emit('closeModal', false);
                    } 

                    me.$parent.updateFunction = false;
                    me.isShowLoadingModal = false;
                    me.showSuccessToast();
                })
                .catch((error) => {
                    console.log(error);
                    me.validateBackend(error.response);
                    me.isShowLoadingModal = false;
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
                return axios
                .get(`${Resource.Url.Employees}/NewCode`)
                .then((resource) => {
                    me.employeeModal.employeeCode = resource.data;
                    console.log('resset code', resource);
                })
                .catch((error) => {
                    console.log('error: ', error.status);
                    me.validateBackend(error.response);

                })
            } catch (e) {
                console.log(e);
            }
        },

        /* Lấy tất cả đơn vị
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        apiGetAllDepartments() {
            let me = this;
            try {
                axios
                .get(`${Resource.Url.Departments}`)
                .then((resource) => {
                    me.departments = resource.data;
                    console.log('departments: ', me.departments);
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
        /* Ẩn dropdown đơn vị
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        hideDropdownDepartment() {
            setTimeout(() => this.isShowDropdownDepartment = false, 200); 
        },

        /* Kiểm tra đơn vị
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkChangeDepartment(departmentName) {
            let me = this; 
            let check = false;
            me.departments.forEach(department => {
                if(department.departmentName == departmentName) {
                    check = true;
                }
            });

            if(!check) {
                me.employeeModal.departmentID = '';
                me.employeeModal.departmentCode = '';
                me.employeeModal.departmentName = '';
            }
        },

        /* Kiểm tra đơn vị được chọn
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkDepartmentSelected(department) {
            if(department.departmentID == this.employeeModal.departmentID) {
                return true;
            }
            return false;
        },

        /* Get department
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        getDepartmentID(departmentID) {
            try {
                this.employeeModal.departmentID = departmentID;
                this.isShowValidity.emptyDepartmentID = false;
            } catch (error) {
                console.log(error);
            }
        },

        /**
         * set dữ liệu department
         * Author: QuangNV (19/12/2022)
         */
        departmentGetValue(departmentValue) {
        try {
            this.employee.DepartmentId = departmentValue;
            this.isDepartmentErr = false;
        } catch (error) {
            console.log(error);
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
            let me = this;
            let eJSON = JSON.stringify(me.employeeModal);

            if (me.employeeJSON != eJSON && me.$parent.updateFunction) {
                me.isShowCloseDialog = true;
            } else {
                this.closeModalAction();
            }
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
            this.$parent.updateFunction = false;
            this.$parent.replicateFunction = false;
        },


        //#endregion Modal click events 

        //#region Modal xử lý hiển thị
        /* Xử lý ngày tháng
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        checkDate() {
            if(this.employeeModal.dateOfBirth.getFullYear() > new Date().getFullYear()) {
                this.employeeModal.dateOfBirth = new Date();
            }
        },

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

            me.isShowValidity.emptyDepartmentID = false;
            me.isShowValidity.emptyEmployeeCode = false;
            me.isShowValidity.emptyEmployeeName = false;
            me.isShowValidity.invalidEmail = false;

            me.employeeModal.employeeID = '';
            me.employeeModal.employeeName = '';
            me.employeeModal.departmentID = '';
            me.employeeModal.departmentCode = '';
            me.employeeModal.departmentName = '';
            me.employeeModal.jobPosition = '';
            me.employeeModal.dateOfBirth = '';
            me.employeeModal.gender = 0;
            me.employeeModal.identityNumber = '';
            me.employeeModal.identityDate = '';
            me.employeeModal.identityPlace = '';
            me.employeeModal.address = '';
            me.employeeModal.phone = '';
            me.employeeModal.fax = '';
            me.employeeModal.email = '';
            me.employeeModal.bankNumber = '';
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

        /* ngăn ngừa paste chữ
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        preventText(value) {
            let pattern = /[0-9]/g;
            if(pattern.test(value))
                return value;
            
           /*  value.replace(pattern, ''); */
            
            return '';
                    

        },

        /* ngăn ngừa save as
            @param {}
            @returns void
            Author: Tuan 
            Date: 24/12/2022 
        */
        blockKeyWindows(e) {
            if (e.keyCode === 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
            e.preventDefault();
            // Process event...
            this.onSubmit();
            this.saveAndInsert = false;
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
                key = evt.clipboardData.getData("text/plain");
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

        /* handler key number
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
         */
        numbersOnly(e) {
            e = (e) ? e : window.event;
            var charCode = (e.which) ? e.which : e.keyCode;
            if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode !== 46) {
                e.preventDefault();
            } else {
                return true;
            }

/*             var keyCode = (e.keyCode ? e.keyCode : e.which);
            if (keyCode > 47 && keyCode < 58 || keyCode > 95 && keyCode < 107) {
                e.preventDefault();
            } */
        },
        //#endregion Modal format data

        //#region Modal validate form
        /* Tạo thông điệp cho cảnh báo mã nhân viên không được để trống
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */ 
        emptyEmployeeCodeMessage() {
            if (!this.employeeModal.employeeCode) 
                return true;
            return false;
        },

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
                    me.errorMessage += this.textErrorMessage.emptyCode;
                } else if (me.v$.employeeModal.employeeName.$error) {
                    me.errorMessage = this.textErrorMessage.emptyName;
                } else if (me.v$.employeeModal.departmentName.$error) {
                    me.errorMessage = this.textErrorMessage.emptyDepartmentName;
                }
                
                me.isShowValidationDialog = true;
                return false;
            } else {
                return true;
            } 
        },

                /* Validate dữ liệu truyền vào
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        validateBackend(response) {
            let me = this;
            if (response.status == Enum.StatusCode.BADREQUEST) {
                if (response.data.errorCode == Enum.ErrorCode.DUPLICATE_CODE) {
                    me.errorMessage = me.textErrorMessage.employeeCode +  ' <' + me.employeeModal.employeeCode + '> ' + me.textErrorMessage.duplicateCode;
                }  
            } 
            else if(response.status == Enum.StatusCode.NOTFOUND) {
                me.isShowValidationDialogBackend = true;    

            } else {
                me.errorMessage = me.textErrorMessage.BadRequest + '.';

            }
                me.isShowValidationDialogBackend = true;    
        },

        /* Focus ô input đầu tiên trả về lỗi
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        focusInvalidFirst() {
            let me = this;

            if (me.errorMessage == me.textErrorMessage.emptyCode) {
                me.$refs.employeeCodeFocusing.focus();
                me.isShowValidity.emptyEmployeeCode = false;
            }
            if (me.errorMessage == me.textErrorMessage.emptyName) {
                me.$refs.employeeNameFocusing.focus();
                me.isShowValidity.emptyEmployeeName = false;
            }
            if (me.errorMessage == me.textErrorMessage.emptyDepartmentName) {
                me.focusDepartment = true;
                me.isShowValidity.emptyDepartmentID = false;
            }
        },

        /* Đóng dialog validate input
            @param {}
            @returns void
            Author: Tuan 
            Date: 11/1/2023 
        */
        closeValidationDialog() {
            let me = this;

            me.isShowValidationDialog = false;
            me.isShowValidationDialogBackend = false;

            me.isShowValidity.emptyDepartmentID = true;
            me.isShowValidity.emptyEmployeeCode = true;
            me.isShowValidity.emptyEmployeeName = true;
            me.isShowValidity.invalidEmail = true;

            me.focusInvalidFirst();

            me.errorMessage = '';
        }
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
            isShowValidationDialog: false, // Hiển thị dialog cảnh báo lỗi validate 
            isShowValidationDialogBackend: false, // Hiển thị dialog cảnh báo lỗi phía backend
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
                departmentCode: '',
                departmentName: '',
                identityNumber: "",
                identityDate: "",
                jobPosition: "",
                identityPlace: "",
                address: "",
                phone: "",
                fax: "",
                email: "",
                bankNumber: "",
                bankName: "",
                bankBranch: "",
            },
            employeeModalTemp: { // Dữ liệu form modal temp
                employeeID: '',
                employeeCode: '',
                employeeName: '',
                dateOfBirth: "",
                gender: 0,
                departmentID: "",
                departmentCode: '',
                departmentName: '',
                identityNumber: "",
                identityDate: "",
                jobPosition: "",
                identityPlace: "",
                address: "",
                phone: "",
                fax: "",
                email: "",
                bankNumber: "",
                bankName: "",
                bankBranch: "",
            },
            employeeJSON: '',
            employeeCodeUpdate: '',

            departments: [], // Danh sách đơn vị
            departmentFocused: null, // Đơn vị được focus
            focusDepartment: false, //

            isShowValidity: { // Cảnh báo lỗi các trường nhập liệu dùng cho BaseMessageError
                emptyEmployeeCode: false,
                emptyEmployeeName: false,
                emptyDepartmentID: false,
                invalidEmail: false,
            },
            url: {
                department: Resource.Url.Departments,
                employee: Resource.Url.Employees,
            },
            notifyShow: false, // Có hiển thị dialog cảnh báo hay không
            heightAlertValidate: 1,
            errorArray: [], // Dãy chứa các lỗi validate
            validateProShow: false, // Có hiển thị dialog cảnh báo lỗi validate nghiệp vụ hay không
            hasError: false,
            isShowLoadingModal: false,
            isShowCloseDialog: false, /* Hiển thị cảnh báo khi huỷ*/
            textExceptionMsg: "", // Thông điệp trong cảnh báo lỗi backend
            backendError: false, // Có hiển thị dialog cảnh báo lỗi từ backend không
            saveAndInsert: false, // Cất và Thêm

            //#region Tên title và các label
            titleModal: Resource.TextVi.Modal.InsertModal,
            textInsertModal: Resource.TextVi.Modal.InsertModal,
            textUpdateModal: Resource.TextVi.Modal.UpdateModal,

            textCustomer: Resource.TextVi.Modal.Customer,
            textSupplier: Resource.TextVi.Modal.Supplier,

            textEmployeeCode: Resource.TextVi.Modal.EmployeeCode, 
            textEmployeeName: Resource.TextVi.Modal.EmployeeName,
            textDateOfBirth: Resource.TextVi.Modal.DateOfBirth,
            textGender: Resource.TextVi.Modal.Gender,
            textDepartmentName: Resource.TextVi.Modal.DepartmentName,
            textIdentityNumber: Resource.TextVi.Modal.IdentityNumber,
            textIdentityDate: Resource.TextVi.Modal.IdentityDate,
            textJobPosition: Resource.TextVi.Modal.JobPosition,
            textIdentityPlace: Resource.TextVi.Modal.IdentityPlace,
            textAddress: Resource.TextVi.Modal.Address,
            textPhone: Resource.TextVi.Modal.Phone,
            textFax: Resource.TextVi.Modal.Fax,
            textEmail: Resource.TextVi.Modal.Email,
            textBankNumber: Resource.TextVi.Modal.BankNumber,
            textBankName: Resource.TextVi.Modal.BankName,
            textBankBranch: Resource.TextVi.Modal.BankBranch,
            //#endregion Tên title và các label

            //#region Tên các chức năng
            textFunctionClose: Resource.TextVi.Modal.Close,
            textFunctionCancel: Resource.TextVi.Modal.Cancel,
            textFunctionUpdate: Resource.TextVi.Modal.Update,
            textFunctionSave: Resource.TextVi.Modal.Save,
            textFunctionSaveAndInsert: Resource.TextVi.Modal.SaveAndInsert,
            textFunctionAccept: Resource.TextVi.Modal.Accept,
            textFunctionYes: Resource.TextVi.Modal.Yes,
            textFunctionNo: Resource.TextVi.Modal.No,
            //#endregion Tên các chức năng

            //#region Dropdown 
            textDropdownDepartmentCode: Resource.TextVi.Dropdown.DepartmentCode,
            textDropdownDepartmentName: Resource.TextVi.Dropdown.DepartmentName,
            textDropdownNoChoice: Resource.TextVi.Dropdown.NoChoice,
            isShowDropdownDepartment: false,

            //#endregion Dropdown

            //#endregion Data Modal

            textErrorMessage: { // Nội dung mã lỗi
                emptyCode: Resource.TextVi.ErrorMessage.EmptyCode,
                emptyName: Resource.TextVi.ErrorMessage.EmptyName,
                emptyDepartmentName: Resource.TextVi.ErrorMessage.EmptyDepartmentName,
                duplicateCode: Resource.TextVi.ErrorMessage.DuplicateCode,
                employeeCode: Resource.TextVi.ErrorMessage.EmployeeCode,
                badRequest: Resource.TextVi.ErrorMessage.BadRequest,
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

            textTooltip: { // Nội dung tooltip
                identityNumber: Resource.TextVi.Tooltip.IdentityNumber,
                phone: Resource.TextVi.Tooltip.Phone,
                fax: Resource.TextVi.Tooltip.Fax,
                help: Resource.TextVi.Tooltip.Help,
                close: Resource.TextVi.Tooltip.Close,
                saveAndInsert: Resource.TextVi.Tooltip.SaveAndInsert,
            },

            placeholder : {
                address: Resource.TextVi.Modal.Placeholder.Address,
                department: Resource.TextVi.Modal.Placeholder.Department,
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
        /* Thực hiện format trường số
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        formatIdentityNumber: {
            get: function() {
                return this.employeeModal.identityNumber;
            },
            
            set: function(number) {
                var num = number;
                
                num = this.preventText(num);
                num = "abc";
                
                this.employeeModal.identityNumber = num;
            }
        },

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
        
        /* Thực hiện format trường ngày tháng
            Object
            Author: Tuan 
            Date: 30/10/2022 
        */
        dateFormat: {
            get: function() {                
                return this.employeeModal.dateOfBirth;
            },
            
            set: function() {
                if (this.employeeModal.dateOfBirth.getFullYear() > new Date().getFullYear()) 
                    this.employeeModal.dateOfBirth = new Date('1/1/2001');
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