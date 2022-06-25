import {Schema , model} from 'mongoose'

const conveyerBeltSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    status:{
        type:Boolean,
        default:false
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('ConveyerBelt',conveyerBeltSchema)