import {Schema , model} from 'mongoose'

const foodSensorSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    food_level:{
        type:Number,
        default:0
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('FoodSensor',foodSensorSchema)