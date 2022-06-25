import WhaterSensor from '../models/WhaterSensor'

export const getWhaterSensors = async(req,res) => {
    try {
        const idFarm = req.params.id
        const whaterSensors = await WhaterSensor.find({
            farm:idFarm
        })

        return res.status(201).json(whaterSensors)
    } catch (error) {
        return res.status(500).send('Server error')
    }
}

export const createWhaterSensor = async (req,res)=>{
    try {
        const {idFarm} = req.body
        const newWhaterSensor = new WhaterSensor()
        newWhaterSensor.farm = idFarm
        await newWhaterSensor.save()
        return res.status(200).json({msg:'Whater sensor created'})
    } catch (error) {
        return res.status(500).send('Server error')
    }
}