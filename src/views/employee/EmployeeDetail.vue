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
                                    ref="focusMe" 
                                    :class="{'input--error': this.isSubmited}"
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
                                    :class="{'input--error': this.isSubmited}"
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
                                    <input  
                                        :class="{'input--error': this.isSubmited}"
                                        class="input input--haveicon input--modal" type="text"  
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
                                    :class="{'input--error': this.isSubmited}"
                                    class="input input--modal" type="text"  
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
                                        class="input input--modal" 
                                        :class="{'input--error': this.isSubmited}" 
                                    >
                                    <base-message-error text="Ngày mua"></base-message-error>
                                </div>
                            </div>
            
                            <div class="modal__item modal__item--gender">
                                <label class="modal__label">
                                    {{this.textGender}}
                                </label>
                                <div class="modal__radio">
                                    <input type="radio" v-model="this.employeeModal.gender" value="0" checked> <p>Nam</p>
                                    <input type="radio" v-model="this.employeeModal.gender" value="1"> <p>Nữ</p>
                                    <input type="radio" v-model="this.employeeModal.gender" value="2"> <p>Khác</p>
                                </div>
                            </div>
                        </div>

                        <!-- Số CMND / Ngày cấp -->
                        <div class="modal__line">
                            <div class="modal__item modal__item--fill">
                                <label class="modal__label">
                                    {{this.textIdentityNumber}}
                                </label>
                                <input  
                                    :class="{'input--error': this.isSubmited}"
                                    class="input input--haveicon input--modal" type="text"  
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
                                        class="input input--modal" 
                                        :class="{'input--error': this.isSubmited}" 
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
                                    :class="{'input--error': this.isSubmited}"
                                    class="input input--modal" type="text"  
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
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal" type="text"  
                                :placeholder="this.placeholder.address"
                                maxlength="50"
                            >
                            <base-message-error text="Địa chỉ"></base-message-error>
                        </div>
                    </div>

                    <div class="modal__line">
                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textPhone}}
                            </label>
                            <input  
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
                                placeholder=""
                                maxlength="50"
                            >
                            <base-message-error text="ĐT di động"></base-message-error>
                        </div>

                        <div class="modal__item">
                            <label class="modal__label">
                                {{this.textContact}}
                            </label>
                            <input  
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
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
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
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
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
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
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
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
                                :class="{'input--error': this.isSubmited}"
                                class="input input--modal input--220" type="text"  
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

        <!-- Begin: Alert modal -->
        <div class="alert__box alert__box--cancel" 
            v-show="isDisplayAlert == true && this.titleModal == this.titleModalInsert || this.titleModal == this.titleModalReplication"
        >
            <div class="alert__content">
                <div class="alert__body">
                    <i class="icon icon--alert"></i>
                    <div class="alert__title">{{this.errorMsg.closeMsg}}</div>
                </div>
                <div class="alert__footer">
                    <button class="btn btn__outline" @click="closeModal(false)">Không</button>
                    <button class="btn btn__save alert__button--space" @click="closeModal(true)">
                        Huỷ bỏ
                    </button>
                </div>
            </div>
        </div>

        <div class="alert__box alert__box--update" 
            v-show="isDisplayAlert == true &&  this.titleModal == this.titleModalUpdate"
        >
            <div class="alert__content">
                <div class="alert__body">
                    <i class="icon icon--alert"></i>
                    <div class="alert__title">{{this.errorMsg.closeEditedMsg}}</div>
                </div>
                <div class="alert__footer">
                    <button class="btn btn__outline" @click="closeModal(false)">Huỷ bỏ</button>
                    <button class="btn btn__sub" @click="closeModal(true)">Không Lưu</button>
                    <button class="btn btn__save alert__button--space" @click="closeModal(false), onSubmit()">Lưu</button>
                </div>
            </div>
        </div>

        <div class="alert__box alert__box--validate"
            v-show="validateShow"
        >
            <div class="alert__content alert__content--validate">
                <div class="alert__body alert__body--validate" :style="{height: this.heightAlertValidate + 'px'}">
                    <i class="icon icon--alert"></i>
                    <div class="alert__title alert__title--validate" v-html="this.errorMessage"></div>
                </div>
                <div class="alert__footer">
                    <button class="btn btn__save alert__button--space" @click="validateShow = false, focusFirst()">Đóng</button>
                </div>
            </div>
        </div>  

        <div class="alert__box alert__box--backend" 
            v-show="validateBackendShow"
        >
            <div class="alert__content">
                <div class="alert__body">
                    <i class="icon icon--alert"></i>
                    <div class="alert__title">{{this.textExceptionMsg}}</div>
                </div>
                <div class="alert__footer">
                    <button class="btn btn__save alert__button--space" @click="validateBackendShow = false, focusFirst()">Đóng</button>
                </div>
            </div>
        </div>  
        <!-- END: Alert modal -->


    </div>
</template>

<script>
import axios from "axios";
import Resource from "@/lib/resource";
import Enum from "../../lib/enum.js";
import useValidate from '@vuelidate/core'
import {required} from '@vuelidate/validators'
import BaseMessageError from "@/components/base/message/BaseMessageError.vue";

export default {
    name: "EmployeeDetail",
    components: {
        BaseMessageError,
    },

    props: [
        'employee',
    ],
    

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

        me.$nextTick(() => me.$refs.focusMe.focus());
        this.employeeModal.employeeCode = "NV-" + parseInt(Math.random()*11245);
    },

    /* DOM thật */
    mounted() {
        console.log("mounted form")

    },

    /* Khi dữ liệu thay đổi, và trước khi render, patch lại và hiển thị ra cho người dùng */
    beforeUpdate() {
        console.log("beforeUpdate form")
    },

    /*  Sử dụng khi bạn cần truy cập DOM sau khi thay đổi thuộc tính */
    updated() {
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
            Date: 30/10/2022 
        */
        loadAPI() {
        },

        //#region Method Modal 
        /* Sửa 1 tài sản
            @param {}
            @returns void
            Author: Tuan 
            Date: 17/11/2022 
        */
        updateFixedAsset() {
            try {                                   
                axios
                .put(`${Resource.Url.FixedAssets}/${this.assetModal.fixedAssetId}`, {
                    "fixed_asset_code": this.assetModal.fixedAssetCode,
                    "fixed_asset_name": this.assetModal.fixedAssetName,
                    "department_id": this.assetModal.departmentId,
                    "department_code": this.assetModal.departmentCode,
                    "department_name": this.assetModal.departmentName,
                    "fixed_asset_category_id": this.assetModal.categoryId,
                    "fixed_asset_category_code": this.assetModal.categoryCode,
                    "fixed_asset_category_name": this.assetModal.categoryName,
                    "purchase_date": this.assetModal.purchaseDate,
                    "cost": this.assetModal.cost,
                    "quantity": this.assetModal.quantity,
                    "depreciation_rate": this.assetModal.depreciationRate,
                    "tracked_year": this.assetModal.trackedYear,
                    "life_time": this.assetModal.lifeTime,
                    "production_date": this.assetModal.productionDate,
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
                .post(Resource.Url.FixedAssets, {
                    "fixed_asset_code": this.assetModal.fixedAssetCode,
                    "fixed_asset_name": this.assetModal.fixedAssetName,
                    "department_id": this.assetModal.departmentId,
                    "department_code": this.assetModal.departmentCode,
                    "department_name": this.assetModal.departmentName,
                    "fixed_asset_category_id": this.assetModal.categoryId,
                    "fixed_asset_category_code": this.assetModal.categoryCode,
                    "fixed_asset_category_name": this.assetModal.categoryName,
                    "purchase_date": this.assetModal.purchaseDate,
                    "production_date": this.assetModal.productionDate,
                    "cost": this.assetModal.cost,
                    "quantity": this.assetModal.quantity,
                    "depreciation_rate": this.assetModal.depreciationRate,
                    "tracked_year": this.assetModal.trackedYear,
                    "life_time": this.assetModal.lifeTime,
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
                    var status = error.response.status;
                    this.handleException(status);
                });
            } catch (error) {
                console.log(error);
            }
        },

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
            if(option.department_id == this.assetModal.departmentId) {
                this.assetModal.departmentId = '';
                this.assetModal.departmentCode = '';
                this.assetModal.departmentName = '';
            } else {
                this.assetModal.departmentId = option.department_id;
                this.assetModal.departmentCode = option.department_code;
                this.assetModal.departmentName = option.department_name;     
            }
        },  

        /* Đưa tài sản vào input modal
            @param {option} giá trị đc chọn trong vòng lặp for
            @returns void
            Author: Tuan 
            Modified Date: 4/11/2022 
        */
        categorySelectDrilldown(option) {
            if(option.fixed_asset_category_id == this.assetModal.categoryId) {
                this.assetModal.categoryId = '';
                this.assetModal.categoryCode = ''
                this.assetModal.categoryName = ''
            } else {
                this.assetModal.categoryId = option.fixed_asset_category_id;
                this.assetModal.categoryCode = option.fixed_asset_category_code;
                this.assetModal.categoryName = option.fixed_asset_category_name;     
                this.assetModal.depreciationRate = option.depreciation_rate;
                this.assetModal.lifeTime = option.life_time;
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

            me.$nextTick(() => me.$refs.focusMe.focus());
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
                if (this.titleModal == this.titleModalInsert || this.titleModal == this.titleModalReplication) {
                    if(this.validateForm()) {
                        this.insertFixedAsset();
                    }
                } else if(this.titleModal == this.titleModalUpdate) {
                    if(this.validateForm()) {
                        this.updateFixedAsset();
                    }
                }
            } catch (e) {
                console.log(e);
            }
        },
        //#endregion Modal processing ui

        
        //#region Modal format support

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

        /** format tiền
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022
         */
        formatCurrency(value) {
            if (value == null || value == 0 || value == "") return "0";
            let num = this.formatNum(value + "") + "";
            return num.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        },

        /** format tỷ lệ
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022
         */
        formatDecimal(number) {
            try {
                if (number != null) {
                    let arrayStrig = number.toString(10).split(".");
                    if (arrayStrig[1] != null) {
                        return arrayStrig[0] + "," + arrayStrig[1];
                    } else {
                        return arrayStrig[0];
                    }
                }
            } catch (error) {
                console.log(error);
            }
        },

        /** format số
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022
         */
        formatNum(value) {
            if (value == null || value == 0 || value == "") return "0";
            let num = value.replace(/[^0-9-]+/g, "");
            return parseInt(num);
        },
        
        /* Định dạng dữ liệu cho giá (200000 => 200.000)
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        format(number) {
            let val = (number/1).toFixed(0)
            if (number && !isNaN(number)) {
                return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
            } else 
                return number;
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

        /* Cập nhật giá trị hao mòn năm
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        pdateDepreciationYear() {
            return this.formatCurrency(parseInt(this.assetModal.depreciation));
        },
        //#endregion Modal format data

        //#region Modal validate form
        /* Tạo thông điệp cho cảnh báo lỗi
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
            let check = false;
            for (var i = 0; i < this.assetsNoLimit.length; i++) {
                if(this.assetModal.fixedAssetCode == this.assetsNoLimit[i].fixed_asset_code) {
                    check = true;
                    this.v$.$error = true;
                    break;
                }
            }

            if (this.fixedAssetCodeUpdate == this.assetModal.fixedAssetCode) {
                check = false;
                this.v$.$error = false;  
            }

            this.v$.$validate()
            if (this.v$.$error) {
                this.errorArray = []
                if (check) this.errorArray.push(Resource.ErrorMsg.ValidateDuplicateCode);
                if (this.v$.assetModal.fixedAssetCode.$error) this.errorArray.push(Resource.IsEmpty.code);
                if (this.v$.assetModal.fixedAssetName.$error) this.errorArray.push(Resource.IsEmpty.name);
                if (this.v$.assetModal.departmentCode.$error) this.errorArray.push(Resource.IsEmpty.department);
                if (this.v$.assetModal.categoryCode.$error) this.errorArray.push(Resource.IsEmpty.category);
                if (this.v$.assetModal.quantity.$error) this.errorArray.push(Resource.IsEmpty.quantity);
                if (this.v$.assetModal.cost.$error) this.errorArray.push(Resource.IsEmpty.cost);
                if (this.v$.assetModal.depreciationRate.$error) this.errorArray.push(Resource.IsEmpty.depreciation_rate);
                if (this.v$.assetModal.lifeTime.$error) this.errorArray.push(Resource.IsEmpty.life_time);
                if (this.v$.assetModal.purchaseDate.$error) this.errorArray.push(Resource.IsEmpty.purchase_date);
                if (this.v$.assetModal.productionDate.$error) this.errorArray.push(Resource.IsEmpty.production_date);
                this.createValidateMessage()
                this.validateShow = true
                return false;
            } else if(this.assetModal.depreciation > this.assetModal.cost) {
                this.errorMessage = Resource.ErrorMsg.DepreciationYearLessThanOrEqualToCost;
                this.validateShow = true;
                return false;
            } else if (this.assetModal.depreciationRate != parseFloat((1/this.assetModal.lifeTime)*100).toFixed(2)) {
                this.errorMessage = Resource.ErrorMsg.DepreciationRateEqualToOneDevideLifeTime;
                this.validateShow = true;
                return false;
            } else {
                return true;
            } 
        },

        /* Validate input trống
            @param {}
            @returns void
            Author: Tuan 
            Date: 10/12/2022 
        */
        checkValidInputEmpty(value) {
            try {
                if(value == undefined){
                    return false;
                }
                else if (value == null) {
                    return false;
                }
                else if(value == ""){
                    return false;
                }
                else {
                    return true;
                }
            } catch (error) {
                console.log(error);
            }
        },
        //#endregion Modal validate input
        //#endregion Method Modal
    
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
            //#endregion Table

            //#region Data Modal 
            notifyShow: false, // Có hiển thị dialog cảnh báo hay không
            v$: useValidate(), // Validate dữ liệu (sử dụng vuelidate)
            heightAlertValidate: 1,
            errorArray: [], // Dãy chứa các lỗi validate
            errorMessage: "", // Thông điệp hiện trong dialog cảnh báo lỗi validate
            validateShow: false, // Có hiển thị dialog cảnh báo lỗi validate thiếu hay không
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
            /* Begin: Tên các nội dung trong form */
            titleModal: Resource.TextVi.Modal.UpdateModal,
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
            /* End: Tên các nội dung trong form */
            employeeModal: { // Dữ liệu form modal
                employeeID: '',
                employeeCode: '',
                fullName: '',
                dateOfBirth: "",
                gender: "",
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
            //#endregion Data Modal

            errorMsg: {
                closeMsg: Resource.ErrorMsg.CloseMsg,
                closeEditedMsg: Resource.ErrorMsg.CloseEditedMsg,
            },

            placeholder : {
                address: "VD: Số 82 Duy Tân, Dịch Vọng, Cầu Giấy, Hà Nội",
            },
        }   
    },

    validations: {
        // Các trường cần validate thiếu
        employeeModal: { 
            employeeCode: { required },
            fullName: { required },
            dateOfBirth: { required },
            gender: { required },
            departmentName: { required },
            identityNumber: { required },
            identityDate: { required },
            positionName: { required },
            identityPlace: { required },
            address: { required },
            phone: { required },
            contact: { required },
            email: { required },
            bankAccountNumber: { required },
            bankName: { required },
            bankBranch: { required },
        },
    },

    computed: {
        /* Thực hiện format trường Số lượng
            Object
            Author: Tuan 
            Date: 30/10/2022 
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
            Date: 30/10/2022 
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
            Date: 30/10/2022 
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
            Date: 30/10/2022 
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
            Date: 30/10/2022 
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
            Date: 30/10/2022 
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