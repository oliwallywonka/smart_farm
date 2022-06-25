import Phone from '../models/Phone'
import User from '../models/User'

export const createPhone = async (req,res) => {
    try {
        const {token} = req.body
        const {id} = req

        const phoneExist = await Phone.findOne({token:token})
        if(phoneExist) return res.status(400).json({message:"Token ya esta registrado"})

        const userExist = await User.findOne({_id:id})
        if(!userExist) return res.status(400).json({message:"User no existe o no esta registrado"})

        const newPhone = new Phone({
            user:id,
            token:token
        })
        
        const savedPhone = await newPhone.save()
        res.status(201).json(savedPhone)

    } catch (error) {
        console.log(error)
        res.status(500).json({message:"server Error"})
    }
}