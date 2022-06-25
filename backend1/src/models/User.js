import {Schema,model} from 'mongoose'
import bcrypt, { compare } from 'bcryptjs'
const UserSchema = Schema({
    rol:{
        type:Schema.Types.ObjectId,
        ref: 'Rol'
    },
    user:{
        type:String,
        required: true,
        trim:true
    },
    password:{
        type:String,
        required:true,
        trim:true
    },
    email:{
        type:String,
        required:true,
        trim:true
    },
    status:{
        type:Boolean,
        default:true
    }
},{
    timestamps: true,
    versionKey: false
})

UserSchema.statics.encryptPassword = async (password) => {
    const salt = await bcrypt.genSalt(10)
    return await bcrypt.hash(password,salt)
}

UserSchema.statics.comparePassword = async (password,recivedPassword) => {
    //Retorna un true o false
   return await bcrypt.compare(password,recivedPassword)
}

export default model('User',UserSchema)