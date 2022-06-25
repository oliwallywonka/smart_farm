import {Schema , model} from 'mongoose'

const doorStatusSchema = Schema({
    door:{
        type:Schema.Types.ObjectId,
        ref:'Door'
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

export default model('DoorStatus',doorStatusSchema)