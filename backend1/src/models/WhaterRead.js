import {Schema , model} from 'mongoose'

const whaterReadSchema = Schema({
    whater_sensor:{
        type:Schema.Types.ObjectId,
        ref:'WhaterSensor'
    },
    whater_level:{
        type:Number,
        default:0
    },
    date:{
        type:Date,
        default:Date.now()
    }
})

export default model('WhaterRead',whaterReadSchema)