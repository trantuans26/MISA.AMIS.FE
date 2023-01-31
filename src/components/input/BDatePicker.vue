<template>
    <Datepicker 
        v-model="date" 
        :format="format"
        :enable-time-picker="false"
        
    ></Datepicker>
</template>

<script>
    import Datepicker from '@vuepic/vue-datepicker';
    import '@vuepic/vue-datepicker/dist/main.css'
// Example using a custom format function
import { ref } from 'vue';

    export default {
        components: { Datepicker },

        props: {
            Date: {
                type: Date,
                default: new Date()
            }
        },

        setup() {
            const date = ref(new Date());
            // In case of a range picker, you'll receive [Date, Date]
            const format = (date) => {
                const day = date.getDate();
                const month = date.getMonth() + 1;
                const year = date.getFullYear();

                return `${day}/${month}/${year}`;
            }
            
            return {
                date,
                format,
            }
        },

        data() {
            return {
                value: new Date(),
            }
        },
    }
</script>