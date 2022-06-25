import User from '../models/User'
import Rol from '../models/Rol'
import {checkJWT, generateJWT} from './jwt'

export const signUp = async (req,res) => {
    
    try {
        const {user,email,password,rol} = req.body

        const userexist = await User.findOne({email})

        if(userexist){
            return res.status(400).json({message:"User already exist"})
        }

        const newUser = new User({
            user,
            email,
            password: await User.encryptPassword(password)
        })

        /*console.log(newUser)
        res.json('singup')*/

        if(rol){
            const foundRol = await Rol.findOne({rol:rol})
            newUser.rol = foundRol._id
        }else{
            const rol = await Rol.findOne({rol:"farm_admin"})
            newUser.rol  = rol._id
        }

        const savedUser = await newUser.save()

        const payload = {
            id:savedUser._id
        }

        const token = await generateJWT(payload)

        res.status(200).json({token})
    } catch (error) {
        console.error(error)
        res.status(500).json({message:"server Error"})
    }
}

export const signIn = async (req,res) => {
    
    try {
        const userFound = await User.findOne({email:req.body.email}).populate('rol')

        console.log(userFound)

        if(!userFound) return res.status(400).json({message:"User not found"})

        const isMatch = await User.comparePassword(req.body.password,userFound.password)

        if(!isMatch) return res.status(401).json({token:null,message:"invalid password"})

        const payload = {
            id:userFound._id
        }

        const token = await generateJWT(payload)
        
        res.status(200).json({token: token})
    } catch (error) {
        console.log(error)
        res.status(500).json({message:"server Error"})
    }
}

export const renewToken = async(req,res) =>{
    try {
        const payload = {
            id:req.userId
        }

        const token = await generateJWT(payload);

        res.json({token})

    } catch (error) {
        console.log(error)
        res.status(500).json({message:"server Error"})
    }
}