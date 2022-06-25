import Farm from '../models/Farm'
import User from '../models/User'
import {getDoors} from '../controllers/sockets//doorStatus'
import * as cron from 'node-cron'

import {io} from '../index'



export const createFarm = async (req,res) => {
    try {
        const {userid,name} = req.body

        const farmExist = await Farm.findOne({name:name})
        if(farmExist) return res.status(400).json({message:"Farm already exist"})

        const userExist = await User.findOne({_id:userid})
        if(!userExist) return res.status(400).json({message:"User does not exist or is not valid"})

        const newFarm = new Farm({
            user:userid,
            name:name
        })

        const savedFarm = await newFarm.save()
        res.status(201).json(savedFarm)

    } catch (error) {
        res.status(500).json({message:"server Error"})
    }
}

export const getFarm = async(req,res) =>{
    try {
        const {userId} = req
        const farm = await Farm
                        .findOne({user:userId})
                        .populate({
                            path:'user',
                            populate:{
                                path:'rol'
                            }
                        })
        if(!farm) return res.status(401).json({message:"The farm doesn exist"})

        return res.status(200).json(farm)
    
    } catch (error) {
        res.status(500).json({message:"server Error"})
    }
}

export const updateFarm = async(req,res)=>{
    const {open_doors,close_doors,idFarm,temp_min,temp_max,humidity_min,humidity_max} = req.body
    const newFarm = {}
    if(temp_min){
        newFarm.temp_min = temp_min
    }
    if(temp_max){
        newFarm.temp_max = temp_max
    }
    if(humidity_min){
        newFarm.humidity_min = temp_min
    }
    if(humidity_max){
        newFarm.humidity_max = temp_max
    }
    
    try {
        let farm = await Farm.findById(idFarm)
        if(!farm){
            return res.status(404).json({msg:'Equipo no encontrado'})
        }

        if(close_doors){
            
            newFarm.close_doors = new Date(close_doors)
            const date = `${newFarm.close_doors.getMinutes()} ${newFarm.close_doors.getHours()+4} * * *`
            console.log(date)
            cron.schedule(date,async()=>{
                const doors = await getDoors(farm._id)
                for(const door in doors){
                    let data = {
                        door : doors[door]._id,
                        status : false
                    }
                    io.to(farm.user).emit("door",JSON.stringify(data))
                }
            })
        }

        if(open_doors){
            newFarm.open_doors = new Date(open_doors)
            const date = `${newFarm.open_doors.getMinutes()} ${newFarm.open_doors.getHours()+4} * * *`
            console.log(date)
            cron.schedule(date,async()=>{
                const doors = await getDoors(farm._id)
                for(const door in doors){
                    let data = {
                        door : doors[door]._id,
                        status : true
                    }
                    io.to(farm.user).emit("door",JSON.stringify(data))
                }
            })

        }

        await Farm.findByIdAndUpdate(
            {_id:idFarm},
            {$set:newFarm},
            {new:true}
        )
        res.status(202).json({msg:'Granja Actualizada Correctamente'})
    } catch (error) {
        console.log(error)
        res.status(500).send('Error en el servidor')
        
    }
}

export const farmTimes = () => {
    const date = `${farm.close_doors.getMinutes()} ${farm.close_doors.getHours()+4} * * *`
        console.log(date)
        //const date = "40 1 * * * "
        cron.schedule(date,async()=>{
            const doors = await getDoors(farm._id)
            for(const door in doors){
                let data = {
                    door : doors[door].id,
                    status : false
                }
                console.log(doors[door])
                io.to(id).emit("door",JSON.stringify(data))
            }
        })
}