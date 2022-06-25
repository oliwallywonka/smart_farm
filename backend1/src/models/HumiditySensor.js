import {Schema , model} from 'mongoose'

const humiditySensorSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    humidity:{
        type:Number,
        default:0
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('HumiditySensor',humiditySensorSchema)