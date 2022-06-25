import {Schema , model} from 'mongoose'

const temperatureReadSchema = Schema({
    temperature_sensor:{
        type:Schema.Types.ObjectId,
        ref:'TemperatureSensor'
    },
    temperature:{
        type:Number
    },
    date:{
        type:Date,
        default:Date.now()
    }
})

export default model('TemperatureRead',temperatureReadSchema)