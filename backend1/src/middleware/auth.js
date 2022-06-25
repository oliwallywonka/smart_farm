import jwt from 'jsonwebtoken'
import User from '../models/User'
import Rol from '../models/Rol'

export const verifyToken = async (req,res,next) => {
    try {
        const token = req.headers["x-access-token"]

        if(!token) return res.status(403).json({message:"No token provided"})

        const {id} = jwt.verify(
            token,
            process.env.SECRETA
        )
        
        req.userId = id

        const user = await User.findById(req.userId,{password:0})

        if(!user) return res.status(404).json({message:'no user found'})

        next()
    } catch (error) {
        return res.status(401).json({message:"Unauthorize"})
    }
}

export const isAdmin = async (req,res,next) => {
    try {
        const user = await User.findById(req.userId)
        const rolBase = await Rol.find({_id:user.rol})
        if(rolBase.rol == "admin" ) {
            next()
            return;
        }
        return res.status(403).json({message:"Invalid Rol admin Unauthorized rol"})
    } catch (error) {
        return res.status(401).json({message:"Unauthorized Token"})
    }
}

export const isFarmAdmin = async (req,res,next) => {
    try {
        const user = await User.findById(req.userId)
        const rolBase = await Rol.findById(user.rol)
        if(rolBase.rol == "farm_admin" ) {
            next()
            return;
        }
        return res.status(403).json({message:"Invalid Rol farm_admin Unauthorized rol"})
    } catch (error) {
        return res.status(401).json({message:"Unauthorized Token x"})
    }
}


export const isEmployee = async (req,res,next) => {
    try {
        const user = await User.findById(req.userId)
        const rolBase = await Rol.find({_id:user.rol})
        if(rolBase.rol == "employee" ) {
            next()
            return;
        }
        return res.status(403).json({message:"Invalid Rol employee Unauthorized rol"})
    } catch (error) {
        return res.status(401).json({message:"Unauthorized Token"})
    }
}