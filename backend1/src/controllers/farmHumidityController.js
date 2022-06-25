import HumiditySensor from '../models/HumiditySensor'

export const getHumiditySensors = async(req,res) => {
    try {
        const idFarm = req.params.id
        const humiditySensors = await HumiditySensor.find({
            farm:idFarm
        })

        return res.status(201).json(humiditySensors)
    } catch (error) {
        return res.status(500).send('Server error')
    }
}

export const createHumiditySensor = async (req,res)=>{
    try {
        const {idFarm} = req.body
        const newHumiditySensor = new HumiditySensor()
        newHumiditySensor.farm = idFarm
        await newHumiditySensor.save()
        return res.status(200).json({msg:'Humidity sensor created'})
    } catch (error) {
        return res.status(500).send('Server error')
    }
}