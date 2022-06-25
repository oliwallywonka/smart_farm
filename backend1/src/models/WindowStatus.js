import {Schema , model} from 'mongoose'

const windowStatusSchema = Schema({
    window:{
        type:Schema.Types.ObjectId,
        ref:'Window'
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

export default model('WindowStatus',windowStatusSchema)