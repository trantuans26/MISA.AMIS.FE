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
                    >
                    <i class="icon icon--search"></i>
                </div>
                <div class="table__reset" data-title="Tải lại dữ liệu"><i class="icon icon--reset"></i></div>
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
                                    <input class="checkbox" type="checkbox" v-model.trim='selectAll'>
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
                                    :class="{'table__row--checked': checkBackground(employee.EmployeeId)}"             
                                >
                                    <td class="table__col table__col--center table__col--check">
                                        <input class="checkbox" type="checkbox" v-model='selectedEmployeeByIds' :value="employee.EmployeeId">
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
                                        <span class="table__col--more">
                                            <i class="icon icon--functiondown"></i>
                                        </span>
                                    </td>
                                </tr> 
                            </tbody>
                        </table>
                    </div>
                </table>

                <div class="table__footer" 
                >
                    <span class="table__record">Tổng số: <b>28</b> bản ghi</span>
                    <div class="table__page">
                        <div class="table__size">
                            <div class="table__sizeIcon">
                                <i class="icon icon--caretdown"></i>
                            </div>
                            <input class="input table__sizeInput" 
                                type="text"
                                v-bind:value="this.filter.pageSize + ` bản ghi trên 1 trang`"
                                readonly
                            >
                        </div>

                        <div class="table__number">
                            <span class="table__previous">Trước</span>
                            <span class="table__subnumber" tabindex="1">1</span>
                            <span class="table__subnumber" tabindex="1">2</span>
                            <span class="table__next">Sau</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <EmployeeDetail v-show="isDisplayModal"></EmployeeDetail>
</template>

<script>
import axios from "axios";
import Resource from "@/lib/resource";
/* import TheDelete from "@/components/function/delete/TheDelete.vue"; */
/* import moment from 'moment' */
import Enum from "../../lib/enum.js";
import useValidate from '@vuelidate/core'
import {required} from '@vuelidate/validators'
import EmployeeDetail from "./EmployeeDetail.vue";
/* import TheLoading from "@/components/base/loading/TheLoading.vue"; */
/* import BaseMessageError from "@/components/base/message/BaseMessageError.vue"; */

export default {
    name: "EmployeeList",
    components: {
/*         TheDelete,
        TheLoading,
        BaseMessageError, */
        EmployeeDetail,
    },
    props: [
        'sidebarmini',
    ],

    // Khởi tạo một đối instance(đối tượng), chưa thiết lập data, event
    beforeCreate() {
    },

    // Thiết lập vào data, event nhưng chưa vào DOM
    created() {
        try {
            this.isDisplayLoading = true; // Hiển thị loading data

/*             axios.get(`${Resource.Url.FixedAssetCategories}`)
            .then((resource) => {
                this.categories = resource.data;
            })
            .catch((error) => {
                console.log('error' + error.status);
            });

            axios.get(`${Resource.Url.Departments}`)
            .then((resource) => {
                this.departments = resource.data;
            })
            .catch((error) => {
                console.log('error' + error.status);
            }); */

            this.loadAPI(); 
        } catch (error) {
            console.log(error);
        }
    },
    
    /* Khởi tạo giá trị mặc định khi vào DOM thật */
    beforeMount() {
    },

    /* DOM thật */
    Mounted() {
    },

    /* Khi dữ liệu thay đổi, và trước khi render, patch lại và hiển thị ra cho người dùng */
    beforeUpdate() {
/*         this.heightAlertValidate = this.errorArray.length * 28; */
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
            Date: 10/12/2022 
        */
        loadAPI() {
            let me = this;
            try {

                axios
                .get(`${Resource.Url.Employees}`)
                .then((resource) => {
                    console.log("No filter:", resource.data);
                })
                .catch((error) => {
                    console.log('error' + error.status);
                });
 
                axios
                .get(`${Resource.Url.Employees}/filter?keyword=${me.filter.keyword}&fixedAssetCategoryId=${me.filter.fixedAssetCategoryId}&departmentId=${me.filter.departmentId}&pageSize=600&pageIndex=1`)
                .then((resource) => {
                    me.updateTotalPageIndex(resource.data.length);
                    me.employeesNoLimit = resource.data;
                    me.totalAllEmployees = resource.data.length;
                    console.log("No filter:" + resource.data);
                })
                .catch((error) => {
                    console.log('error' + error.status);
                });

                axios
                .get(`https://cukcuk.manhnv.net/api/v1/Employees/filter?pageSize=20&pageNumber=1`)
                .then((resource) => {
                    console.log("Filter:" + resource);
                })
                .catch((error) => {
                    console.log('error: ' + error.status);
                });
            } catch (e) {
                console.log(e);
            }
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
            isDisplayModal: false,
            selectedEmployeeByIds: [],

            employees: [
            {
            "EmployeeId": "b62fe573-771d-11ed-9263-00163e06abee",
            "EmployeeCode": "NV15550",
            "FirstName": null,
            "LastName": null,
            "FullName": "string",
            "Gender": null,
            "DateOfBirth": null,
            "PhoneNumber": null,
            "Email": null,
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": "2022-12-09T00:28:21",
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "203537a3-ca19-4372-b30a-cfdcd2b8e770",
            "EmployeeCode": "NV0068",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyen Van D",
            "Gender": 0,
            "DateOfBirth": null,
            "PhoneNumber": "",
            "Email": "",
            "Address": "biển sầm sơn",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "Thanh hóa",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-27T23:59:37",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "21cdb53b-b56b-4ce8-8c5f-622e8356ae6a",
            "EmployeeCode": "NV1212112",
            "FirstName": null,
            "LastName": null,
            "FullName": "Họ và tên",
            "Gender": 0,
            "DateOfBirth": "2022-10-01T00:00:00",
            "PhoneNumber": "1228391281",
            "Email": "minhhieu562k@gmail.com",
            "Address": "biển cửa lò",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "nghệ an",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "78aafe4a-67a7-2076-3bf3-eb0223d0a4f7",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Nhân Sự",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-27T23:59:54",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "247ec0a2-592b-4c89-9e2c-e8e30c3b9e29",
            "EmployeeCode": "NV1110",
            "FirstName": null,
            "LastName": null,
            "FullName": "Họ và tên",
            "Gender": 0,
            "DateOfBirth": "2011-11-11T00:00:00",
            "PhoneNumber": "01012910201",
            "Email": "minhhieu562k@gmail.com",
            "Address": "phú quốc",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "phú quốc",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "78aafe4a-67a7-2076-3bf3-eb0223d0a4f7",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Nhân Sự",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-28T00:00:14",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "286b8b65-e664-46cc-a6fc-b3ff052b5950",
            "EmployeeCode": "NV0061",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyễn Xuân Tấn San",
            "Gender": 0,
            "DateOfBirth": "2022-10-04T00:00:00",
            "PhoneNumber": "0941241234",
            "Email": "sannxt@gmail.com",
            "Address": "hạ long",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "Quảng Ninh",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-28T00:00:27",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "2a773616-be33-49c7-af41-13f371c1a770",
            "EmployeeCode": "NV12321",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyễn Văn B",
            "Gender": null,
            "DateOfBirth": null,
            "PhoneNumber": null,
            "Email": null,
            "Address": "biển nha trang",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "khánh hòa",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-28T00:00:47",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "2f982aa5-0bd4-4a48-843f-88dc0fa18a31",
            "EmployeeCode": "N01",
            "FirstName": null,
            "LastName": null,
            "FullName": "thin",
            "Gender": 3,
            "DateOfBirth": null,
            "PhoneNumber": "0986906251",
            "Email": "thin@gmail.com",
            "Address": "cầu đầu rồng",
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": "đà nẵng",
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "78aafe4a-67a7-2076-3bf3-eb0223d0a4f7",
            "PositionId": "548dce5f-5f29-4617-725d-e2ec561b0f41",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-53",
            "PositionName": "Quản trị hệ thống",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Nhân Sự",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-28T00:01:18",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "431e6443-f9e6-41ec-aa3e-961ad00e5600",
            "EmployeeCode": "1111",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyễn Văn zxc",
            "Gender": null,
            "DateOfBirth": null,
            "PhoneNumber": null,
            "Email": null,
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": "2022-11-28T00:54:34",
            "ModifiedBy": null
            },
            {
            "EmployeeId": "43324bbc-d38e-4668-9f7f-369251cceddb",
            "EmployeeCode": "N07",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nam",
            "Gender": 1,
            "DateOfBirth": "2022-10-05T00:00:00",
            "PhoneNumber": "0986752511",
            "Email": "Nam@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nữ",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "4c210ea7-d01a-49fc-b5f9-2932ac7a9b4b",
            "EmployeeCode": "N12111",
            "FirstName": null,
            "LastName": null,
            "FullName": "Test",
            "Gender": null,
            "DateOfBirth": "2022-10-27T00:00:00",
            "PhoneNumber": null,
            "Email": null,
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "4e41d456-71ac-4a0d-9bfc-d1bd9ca7ec59",
            "EmployeeCode": "NV0056",
            "FirstName": null,
            "LastName": null,
            "FullName": "San",
            "Gender": 1,
            "DateOfBirth": "2022-10-10T00:00:00",
            "PhoneNumber": null,
            "Email": null,
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nữ",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "4ef5e5ce-9f3a-4a7b-bd85-38130f451d28",
            "EmployeeCode": "N03",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyễn Văn Quân",
            "Gender": 1,
            "DateOfBirth": "2022-10-13T00:00:00",
            "PhoneNumber": "0986906251",
            "Email": "quan@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "78aafe4a-67a7-2076-3bf3-eb0223d0a4f7",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Nhân Sự",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nữ",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "50562b4f-be67-4461-8275-4022e68afd94",
            "EmployeeCode": "NV9283",
            "FirstName": null,
            "LastName": null,
            "FullName": "Lê Quang",
            "Gender": 0,
            "DateOfBirth": "2022-10-07T00:00:00",
            "PhoneNumber": "0989283849",
            "Email": "lequang@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "565025e5-bdaa-41c6-931e-2d1b86394991",
            "EmployeeCode": "NV5555",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nguyễn Văn Cương",
            "Gender": 0,
            "DateOfBirth": "2022-10-19T00:00:00",
            "PhoneNumber": "0822105506",
            "Email": "adsadasd",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "3f8e6896-4c7d-15f5-a018-75d8bd200d7c",
            "PositionId": "68daa090-552d-1bc6-e8e4-8adc5263917a",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-63",
            "PositionName": "Giám đốc",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Công Nghệ Thông Tin",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "57aacd3f-b973-4112-8979-50b514474aaa",
            "EmployeeCode": "NV111111",
            "FirstName": null,
            "LastName": null,
            "FullName": "Ho ten",
            "Gender": 1,
            "DateOfBirth": "2022-10-01T00:00:00",
            "PhoneNumber": "1212124124",
            "Email": "minhhieu562k@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "78aafe4a-67a7-2076-3bf3-eb0223d0a4f7",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Nhân Sự",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nữ",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "5b9dc168-6e5f-4c87-992a-3542542e29df",
            "EmployeeCode": "Nv123",
            "FirstName": null,
            "LastName": null,
            "FullName": "Thin",
            "Gender": 0,
            "DateOfBirth": "2022-10-05T00:00:00",
            "PhoneNumber": "0986906251",
            "Email": "thinngyen@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": "548dce5f-5f29-4617-725d-e2ec561b0f41",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-53",
            "PositionName": "Quản trị hệ thống",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "5d76fde5-3418-4121-8100-28fb996530cc",
            "EmployeeCode": "N06",
            "FirstName": null,
            "LastName": null,
            "FullName": "Nam",
            "Gender": 1,
            "DateOfBirth": "2022-09-29T00:00:00",
            "PhoneNumber": "0986906251",
            "Email": "nam@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": "589edf01-198a-4ff5-958e-fb52fd75a1d4",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-92",
            "PositionName": "Nhân viên",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nữ",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "5da4ef89-4758-4f02-9bbf-f852f7d39f68",
            "EmployeeCode": "NV0111",
            "FirstName": null,
            "LastName": null,
            "FullName": "Hứa Minh Hiếu",
            "Gender": null,
            "DateOfBirth": null,
            "PhoneNumber": null,
            "Email": null,
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": null,
            "PositionId": null,
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": null,
            "PositionName": null,
            "DepartmentCode": null,
            "DepartmentName": null,
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": null,
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "62a7c450-38c9-4e77-b375-a2fd3c42aeda",
            "EmployeeCode": "N04",
            "FirstName": null,
            "LastName": null,
            "FullName": "thin",
            "Gender": 2,
            "DateOfBirth": "2022-10-13T00:00:00",
            "PhoneNumber": "0986906251",
            "Email": "thin@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "45ac3d26-18f2-18a9-3031-644313fbb055",
            "PositionId": "548dce5f-5f29-4617-725d-e2ec561b0f41",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-53",
            "PositionName": "Quản trị hệ thống",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Hành Chính",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "(Chưa xác định)",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            },
            {
            "EmployeeId": "633a83cf-7623-40f2-8b7b-6bf2721086d1",
            "EmployeeCode": "NV025",
            "FirstName": null,
            "LastName": null,
            "FullName": "nguyễn văn cuongw",
            "Gender": 0,
            "DateOfBirth": "2022-10-05T00:00:00",
            "PhoneNumber": "0822105506",
            "Email": "nguyencuong@gmail.com",
            "Address": null,
            "IdentityNumber": null,
            "IdentityDate": null,
            "IdentityPlace": null,
            "JoinDate": null,
            "MartialStatus": null,
            "EducationalBackground": null,
            "QualificationId": null,
            "DepartmentId": "3f8e6896-4c7d-15f5-a018-75d8bd200d7c",
            "PositionId": "68daa090-552d-1bc6-e8e4-8adc5263917a",
            "NationalityId": null,
            "WorkStatus": null,
            "PersonalTaxCode": null,
            "Salary": null,
            "PositionCode": "VT-63",
            "PositionName": "Giám đốc",
            "DepartmentCode": null,
            "DepartmentName": "Phòng Công Nghệ Thông Tin",
            "QualificationName": null,
            "NationalityName": null,
            "GenderName": "Nam",
            "EducationalBackgroundName": null,
            "MartialStatusName": null,
            "CreatedDate": null,
            "CreatedBy": null,
            "ModifiedDate": null,
            "ModifiedBy": null
            }
            ],
            employeesNoLimit: [],

            filter: {
                employeeFilter: '',
                pageSize: '20',
                pageNumber: '',
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
        selectAll: {
            /*
                @param {}
                @returns this.Employees ? this.selectedEmployeesByIDs.length == this.Employees.length : false;
            */
            get: function () {
                if (this.employeesNoLimit.length != 0)
                    return this.employees ? this.selectedEmployeesByIDs.length == this.Employees.length : false;
                else return false;
            },
            /*
                @param {fixed_asset_id}
                @returns void
            */
            set: function (value) {
                var selectedEmployeesByIDs = [];

                if (value) {
                    
                    this.Employees.forEach(function (asset) {
                        selectedEmployeesByIDs.push(asset.fixed_asset_id);
                    });
                }

                this.selectedEmployeesByIDs = selectedEmployeesByIDs;
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