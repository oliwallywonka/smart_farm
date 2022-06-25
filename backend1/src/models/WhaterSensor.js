import {Schema , model} from 'mongoose'

const whaterSensorSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    whater_level:{
        type:Number,
        default:0
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('WhaterSensor',whaterSensorSchema)