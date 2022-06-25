import Door from '../models/Door'

export const getDoors = async (req,res) => {
    try {
        const id = req.params.id

        const doors = await Door.find({
            farm:id
        })

        return res.status(200).json({doors})

    } catch (error) {
        res.status(500).send('Server error')
    }
}

export const createDoor = async(req,res) => {
    try {
        const {idFarm} = req.body
        const newDoor = new Door()

        newDoor.farm = idFarm

        await newDoor.save()

        return res.status(201).json({msg:'Door created'})

    } catch (error) {
        res.status(500).send('hubo un error')
    }
}
