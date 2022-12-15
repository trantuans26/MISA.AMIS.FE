<template>
    <div id="sidebar">
        <!-- BEGIN: Sidebar ở trạng thái thu nhỏ -->
        <div class="sidebar sidebar--minimize" 
          :class="{display: !isDisplay}"
        >
            <div class="sidebar__top">
                <div class="sidebar__logo" 
                    @click="this.$emit('sidebarToggle', true)"
                    >
                    <i class="icon icon--menu2"></i>  
                </div>

                <ul class="sidebar__list" 
                    :class="active"
                    @click.prevent
                >
                    <li class="sidebar__item" 
                        v-for='item in this.sidebar.items'
                        @click="makeActive(item.style)"
                        :key="item"
                        :class="item.style"
                        :data-title="item.title"
                    >
                        <router-link :to="item.route">
                            <div class="sidebar__icon">
                                <i class="icon" :class="item.icon"></i>
                            </div>
                        </router-link>
                    </li>
                </ul>
            </div>
        </div>
        <!-- END: Sidebar ở trạng thái thu nhỏ -->

        <!-- BEGIN:  Sidebar ở trạng thái mở rộng -->
        <div class="sidebar sidebar--maximum" 
            :class="{display: isDisplay}"
        >
            <div class="sidebar__top">
                <div class="sidebar__logo" @click="active = 'logo'">
                    <i class="icon icon--home"></i>  
                    <router-link class="sidebar__logo--link" to="/">
                        <img 
                            src="../../assets/icons/Logo_Module_TiengViet_White.66947422.svg" 
                            class="icon--logo"
                        >
                    </router-link>
                </div>

                <ul class="sidebar__list" 
                    :class="active"
                    @click.prevent
                >
                    <li class="sidebar__item" 
                        v-for='item in this.sidebar.items'
                        @click="makeActive(item.style)"
                        :key="item"
                        :class="item.style"
                        :data-title="item.title"
                    >
                        <router-link :to="item.route">
                            <div class="sidebar__icon">
                                <i class="icon" :class="item.icon"></i>
                            </div>
                            <p>{{item.title}}</p>
                        </router-link>
                    </li>
                </ul>
            </div>
        </div>
        <!-- END Sidebar ở trạng thái mở rộng -->
    </div>
</template>

<script>

    export default {
        name: 'TheSidebar',
        props: [
            'isDisplay',
        ],
        data() {
            return {
                normal: false,
                active: 'logo',
                sidebar: {
                    items: [
                        {
                            icon: 'icon--total',
                            title: 'Tổng quan',
                            style: 'total',
                            route: '/total',
                        },
                        {
                            icon: 'icon--money',
                            title: 'Tiền mặt',
                            style: 'money',
                            route: '/money',
                        },
                        {
                            icon: 'icon--deposit',
                            title: 'Tiền gửi',
                            style: 'deposit',
                            route: '/deposit',
                        },
                        {
                            icon: 'icon--shop',
                            title: 'Mua hàng',
                            style: 'shop',
                            route: '/shop',
                        },
                        {
                            icon: 'icon--sale',
                            title: 'Bán hàng',
                            style: 'sale',
                            route: '/sale',
                        },
                        {
                            icon: 'icon--bill',
                            title: 'Quản lý hoá đơn',
                            style: 'bill',
                            route: '/bill',
                        },
                        {
                            icon: 'icon--store',
                            title: 'Kho',
                            style: 'store',
                            route: '/store',
                        },
                        {
                            icon: 'icon--tool',
                            title: 'Công cụ dụng cụ',
                            style: 'tool',
                            route: '/tool',
                        },                       
                        {
                            icon: 'icon--fixedAsset',
                            title: 'Tài sản cố định',
                            style: 'fixedAsset',
                            route: '/fixedAsset',
                        },
                        {
                            icon: 'icon--tax',
                            title: 'Thuế',
                            style: 'tax',
                            route: '/tax',
                        },                       
                        {
                            icon: 'icon--cost',
                            title: 'Giá thành',
                            style: 'cost',
                            route: '/cost',
                        },                       
                        {
                            icon: 'icon--general',
                            title: 'Tổng hợp',
                            style: 'general',
                            route: '/general',
                        },                       
                        {
                            icon: 'icon--budget',
                            title: 'Ngân sách',
                            style: 'budget',
                            route: '/budget',
                        },                       
                        {
                            icon: 'icon--report',
                            title: 'Báo cáo',
                            style: 'report',
                            route: '/report',
                        },                       
                        {
                            icon: 'icon--analyst',
                            title: 'Phân tích tài chính',
                            style: 'analyst',
                            route: '/analyst',
                        },
                    ],
                },
            }
        },
        methods: {
            
            zoom() {
                this.normal = true;
                this.$emit('toggle', true);
            },

            /* Click sidebar__item
            @param {item}
            @returns void
            Author: Tuan 
            Date: 23/10/2022 
            */
            makeActive: function(item) {
                this.active = item;
            }
        }
    }
</script> 

<style scoped>

</style>