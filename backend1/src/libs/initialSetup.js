import Rol from '../models/Rol'

export const createRols = async ( ) => {
    try {
        const count = await Rol.estimatedDocumentCount()

        if(count>0) return

        const values = await Promise.all([
            new Rol({rol:"admin"}).save(),
            new Rol({rol:"farm_admin"}).save(),
            new Rol({rol:"employee"}).save()
        ])
        console.log(values)
    } catch (error) {
        console.error(error);
    }
}