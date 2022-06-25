import {Schema , model} from 'mongoose'

const watherTankSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    porcent:{
        type:Number,
        default:0
    },
    max_capacity:{
        type:Number,
        default:0
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('WatherTank',watherTankSchema)