import express from 'express'
import SocketIO from 'socket.io'
import http from 'http'

import {createRols} from './libs/initialSetup'
import {socket} from './socket/sockets'

//Importar sockets
import {disconnect,message} from './socket/sockets'


//Importar ROUTERS
import authRoute from './routes/auth'
import farmRoute from './routes/farm'
import humidityRoute from './routes/humiditySensor'
import temperatureRoute from './routes/temperatureSensor'
import foodRoute from './routes/foodSensor'
import whaterRoute from './routes/whaterSensor'
import doorRoute from './routes/door'
import windowRoute from './routes/window'
import beltRoute from './routes/belt'
import phoneRoute from './routes/phone'

import connectDB from './config/db'

import * as admin from 'firebase-admin'

//Crear el servidor
const app = express()

//Conectar a la base de dato
connectDB()

createRols()

//Habilitar express.json
app.use(express.json({extended:true}))

//Puerto de la app
const PORT = process.env.PORT || 8000

//Cors
app.use((req,res,next)=>{
    res.header('Access-Control-Allow-Origin','*')
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method')
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE')
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE')
    next();

})

//importar rutas
//app.use('/api/usuarios',require('./routes/usuarios'))
app.use('/api/auth',authRoute)
app.use('/api/farm',farmRoute)
app.use('/api/humidity',humidityRoute)
app.use('/api/temperature',temperatureRoute)
app.use('/api/whater',whaterRoute)
app.use('/api/food',foodRoute)
app.use('/api/door',doorRoute)
app.use('/api/window',windowRoute)
app.use('/api/belt',beltRoute)
app.use('/api/phone',phoneRoute)

const serviceAccount = require ("../smart-farm-583f3-firebase-adminsdk-mb7p0-413eab36c7.json")

export const fcmAdmin = admin.initializeApp({
    credential:admin.credential.cert(serviceAccount),   
})

const server = http.createServer(app)

//Websockets
export const io = SocketIO(server)
socket()
// arrancar la app
server.listen(PORT,()=>{
    console.log (`El servidor esta funcionando en el puerto ${PORT}`)
})



