import {Schema , model} from 'mongoose'

const foodReadSchema = Schema({
    food_sensor:{
        type:Schema.Types.ObjectId,
        ref:'FoodSensor'
    },
    food_level:{
        type:Number
    },
    date:{
        type:Date,
        default:Date.now()
    }
})

export default model('FoodRead',foodReadSchema)