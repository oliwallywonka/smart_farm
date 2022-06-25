import TemperatureSensor from '../models/TemperatureSensor'

export const getTemperatureSensors = async(req,res) => {
    try {
        const idFarm = req.params.id
        const temperatureSensors = await TemperatureSensor.find({
            farm:idFarm
        })

        return res.status(201).json(temperatureSensors)
    } catch (error) {
        return res.status(500).send('Server error')
    }
}

export const createTemperatureSensor = async (req,res)=>{
    try {
        const {idFarm} = req.body
        const newTemperatureSensor = new TemperatureSensor()
        newTemperatureSensor.farm = idFarm
        await newTemperatureSensor.save()
        return res.status(200).json({msg:'Temperature sensor created'})
    } catch (error) {
        return res.status(500).send('Server error')
    }
}