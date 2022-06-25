import DoorStatus from '../../models/DoorStatus'
import Door from '../../models/Door'
import Farm from '../../models/Farm'

export const saveDoorStatus = async (payload) => {
    const {door , status} = payload
    const newDoor = new DoorStatus({
        door:door,
        status:status
    });
    try {
        
        let findDoor = Door.findById(door)

        if(!findDoor) return false

        await Door.findByIdAndUpdate(
            {_id:door},
            {status:status}
        )

        await newDoor.save()
        return true
    } catch (error) {
        return false
    }

}

export const getDoors = async (idFarm)=>{
    try {
        const doors = await Door.find(
            {farm:idFarm}
        )
        return doors
    } catch (error) {
        return null
    }
}