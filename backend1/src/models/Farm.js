import {Schema,model} from 'mongoose'

const FarmSchema = Schema({
    user:{
        type:Schema.Types.ObjectId,
        ref:'User'
    },
    name:{
        type:String,
        required:true
    },
    open_doors:{
        type:Date,
        default:Date.now()
    },
    close_doors:{
        type:Date,
        default:Date.now()
    },
    cap_max:{
        type:Number,
        default: 0
    },
    temp_min:{
        type:Number,
        default:0
    },
    temp_max:{
        type:Number,
        default:0
    },
    humidity_min:{
        type:Number,
        default:0
    },
    humidity_max:{
        type:Number,
        default:0
    },
    status:{
        type:Boolean,
        default:true
    },
},{
    timestamps: true,
    versionKey: false
})

export default model('Farm',FarmSchema)