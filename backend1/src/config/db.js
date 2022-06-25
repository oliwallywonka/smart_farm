import mongoose from 'mongoose'

require('dotenv').config({path:'.env'})

const connectDB = async ()=> {
    try {
        await mongoose.connect(process.env.DB_MONGO,{
            useNewUrlParser:true,
            useUnifiedTopology: true,
            useFindAndModify: true,
            useCreateIndex:true
        })

        console.log('DB connected')

    } catch (error) {
        console.log(error)
        process.exit(1) // Detener la app
    }
}

export default connectDB