import {Schema,model} from 'mongoose'

const RolSchema = Schema({
    rol:{
        type:String,
        required:true,
        trim:true
    },
    status:{
        type:Boolean,
        default:true
    }
},
{
    timestamps: true,
    versionKey: false
})

export default model('Rol',RolSchema)