import Window from '../models/Window'

export const getWindows = async(req,res) => {
    try {
        const idFarm = req.params.id
        const windows = await Window.find({
            farm:idFarm
        })

        return res.status(200).json({windows})

    } catch (error) {
        console.log(error)
        return res.status(500).json({msg:"Error at request"})
    }

}


export const createWindow = async(req,res) => {
    try {
        const {idFarm} = req.body
        const newWindow = new Window()
        newWindow.farm = idFarm
        await newWindow.save()

        return res.status(201).json({msg:'Window Created'})
    } catch (error) {
        return res.status(500).send('error en el servidor')
    }
}