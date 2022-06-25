import {Schema , model} from 'mongoose'

const beltStatusSchema = Schema({
    conveyer_belt:{
        type:Schema.Types.ObjectId,
        ref:'ConveyerBelt'
    },
    status:{
        type:Boolean,
        default:false
    },
    date:{
        type:Date,
        default:Date.now()
    }
})

export default model('BeltStatus',beltStatusSchema)