import Farm from '../../models/Farm'
export const getFarm = async (id) => {
    try {
        const farm = await Farm.findOne(
            {user:id}
        )
        if(!farm){
            return null
        }
        return farm

    } catch (error) {
        return null
    }
}
