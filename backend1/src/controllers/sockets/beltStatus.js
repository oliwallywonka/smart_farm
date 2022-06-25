import BeltStatus from '../../models/BeltStatus'
import ConveyerBelt from '../../models/ConveyerBelt'
export const saveBeltStatus = async (payload) => {
    const {belt,status} = payload

    const newBelt = new BeltStatus({
        conveyer_belt:belt,
        status:status
    });

    try {

        let findBelt = await ConveyerBelt.findById(belt)

        if(!findBelt) return false

        await ConveyerBelt.findByIdAndUpdate(
            {_id: belt},
            {status: status},
            {new:true}
        )
    
        await newBelt.save()
        return true

    } catch (error) {
        return false
    }
}
