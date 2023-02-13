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
import Resource from "@/translations/resource";

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
                            title: Resource.TextVi.Sidebar.Total,
                            style: 'total',
                            route: '/total',
                        },
                        {
                            icon: 'icon--money',
                            title: Resource.TextVi.Sidebar.Money,
                            style: 'money',
                            route: '/money',
                        },
                        {
                            icon: 'icon--deposit',
                            title: Resource.TextVi.Sidebar.Deposit,
                            style: 'deposit',
                            route: '/deposit',
                        },
                        {
                            icon: 'icon--shop',
                            title: Resource.TextVi.Sidebar.Shop,
                            style: 'shop',
                            route: '/shop',
                        },
                        {
                            icon: 'icon--sale',
                            title: Resource.TextVi.Sidebar.Sale,
                            style: 'sale',
                            route: '/sale',
                        },
                        {
                            icon: 'icon--bill',
                            title: Resource.TextVi.Sidebar.Bill,
                            style: 'bill',
                            route: '/bill',
                        },
                        {
                            icon: 'icon--store',
                            title: Resource.TextVi.Sidebar.Store,
                            style: 'store',
                            route: '/store',
                        },
                        {
                            icon: 'icon--tool',
                            title: Resource.TextVi.Sidebar.Tool,
                            style: 'tool',
                            route: '/tool',
                        },                       
                        {
                            icon: 'icon--fixedAsset',
                            title: Resource.TextVi.Sidebar.FixedAsset,
                            style: 'fixedAsset',
                            route: '/fixedAsset',
                        },
                        {
                            icon: 'icon--tax',
                            title: Resource.TextVi.Sidebar.Tax,
                            style: 'tax',
                            route: '/tax',
                        },                       
                        {
                            icon: 'icon--cost',
                            title: Resource.TextVi.Sidebar.Cost,
                            style: 'cost',
                            route: '/cost',
                        },                       
                        {
                            icon: 'icon--general',
                            title: Resource.TextVi.Sidebar.General,
                            style: 'general',
                            route: '/general',
                        },                       
                        {
                            icon: 'icon--budget',
                            title: Resource.TextVi.Sidebar.Budget,
                            style: 'budget',
                            route: '/budget',
                        },                       
                        {
                            icon: 'icon--report',
                            title: Resource.TextVi.Sidebar.Report,
                            style: 'report',
                            route: '/report',
                        },                       
                        {
                            icon: 'icon--analyst',
                            title: Resource.TextVi.Sidebar.Analyst,
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
                Date: 23/12/2022 
            */
            makeActive: function(item) {
                this.active = item;
            }
        }
    }
</script> 

<style scoped>

</style>