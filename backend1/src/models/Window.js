import {Schema , model} from 'mongoose'

const windowSchema = Schema({
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

export default model('Window',windowSchema)