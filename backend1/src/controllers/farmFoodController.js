import FoodSensor from '../models/FoodSensor'

export const getFoodSensors = async(req,res) => {
    try {
        const idFarm = req.params.id
        const foodSensors = await FoodSensor.find({
            farm:idFarm
        })

        return res.status(201).json(foodSensors)
    } catch (error) {
        return res.status(500).send('Server error')
    }
}

export const createFoodSensor = async (req,res)=>{
    try {
        const {idFarm} = req.body
        const newFoodSensor = new FoodSensor()
        newFoodSensor.farm = idFarm
        await newFoodSensor.save()
        return res.status(200).json({msg:'Food sensor created'})
    } catch (error) {
        return res.status(500).send('Server error')
    }
}