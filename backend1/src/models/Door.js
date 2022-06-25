import {Schema , model} from 'mongoose'

const doorSchema = Schema({
    farm:{
        type:Schema.Types.ObjectId,
        ref:'Farm'
    },
    status:{
        type:Boolean,
        default:false
    },
    open:{
        type:Date,
        default:Date.now()
    },
    close:{
        type:Date,
        default:Date.now()
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('Door',doorSchema)