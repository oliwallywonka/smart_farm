import Belt from '../models/ConveyerBelt'

export const getBelt = async (req,res)=>{
    try {
        const idFarm = req.params.id
        const belt = await Belt.findOne({
            farm:idFarm
        })
        return res.status(200).json(belt)
    } catch (error) {
        res.status(500).send('server Error')
    }
}

export const createBelt = async (req,res) => {
    try {
        const {idFarm} = req.body
        const newBelt = new Belt()
        newBelt.farm = idFarm
        await newBelt.save()
        return res.status(201).json({msg:'belt Created'})
    } catch (error) {
        console.log(error)
        res.status(500).send('Error en el servidor')
    }
}