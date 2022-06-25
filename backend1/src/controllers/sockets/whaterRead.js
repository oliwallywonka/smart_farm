import WhaterRead from '../../models/WhaterRead'
import WhaterSensor from '../../models/WhaterSensor'

export const saveWhaterRead = async (payload) => {
    const {sensor,whater} = payload
    const newWhater = new WhaterRead({
        whater_sensor:sensor,
        whater_level:whater
    });
    
    try {
        const findWhaterSensor = await WhaterSensor.findByIdAndUpdate(sensor)
        if(!findWhaterSensor) return false
        await WhaterSensor.findByIdAndUpdate(
            {_id:sensor},
            {whater_level:whater}
        )
        await newWhater.save()
        return true
    } catch (error) {
        return false
    }

}