import {Schema , model} from 'mongoose'

const temperatureSensorSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    temperature:{
        type:Number,
        default:0
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('TemperatureSensor',temperatureSensorSchema)