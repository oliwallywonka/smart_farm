import {Schema,model} from 'mongoose'

const PhoneSchema = Schema({
    user:{
        type:Schema.Types.ObjectId,
        ref:'User'
    },
    token:{
        type:String
    }
},{
    timestamps: true,
    versionKey: false
})

export default model('Phone',PhoneSchema)