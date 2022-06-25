import {Schema , model} from 'mongoose'

const humidityReadSchema = Schema({
    humidity_sensor:{
        type:Schema.Types.ObjectId,
        ref:'HumiditySensor'
    },
    humidity:{
        type:Number
    },
    date:{
        type:Date,
        default:Date.now()
    }
})

export default model('HumidityRead',humidityReadSchema)