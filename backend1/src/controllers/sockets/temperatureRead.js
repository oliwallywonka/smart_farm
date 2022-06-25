import TemperatureRead from '../../models/TemperatureRead'
import TemperatureSensor from '../../models/TemperatureSensor'
export const saveTemperatureRead = async (payload) => {
    const {sensor,temperature} = payload
    const newTemperature = new TemperatureRead({
        temperature_sensor:sensor,
        temperature:temperature
    });
    try {

        const findTemperatureSensor = await TemperatureSensor.findById(sensor)

        if(!findTemperatureSensor) return false

        await TemperatureSensor.findByIdAndUpdate(
            {_id:sensor},
            {temperature:temperature}
        )
        await newTemperature.save()
        return true
    } catch (error) {
        return false
    }

}