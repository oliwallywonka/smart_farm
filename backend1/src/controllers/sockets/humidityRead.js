import HumidityRead from '../../models/HumidityRead'
import HumiditySensor from '../../models/HumiditySensor'

export const saveHumidityRead = async (payload) => {
    const {sensor,humidity} = payload
    const newHumidity = new HumidityRead({
        humidity_sensor:sensor,
        humidity:humidity
    });

    try {
        const findHumiditySensor = await HumiditySensor.findById(sensor)
        if(!findHumiditySensor) return false
        await HumiditySensor.findByIdAndUpdate(
            {_id:sensor},
            {humidity:humidity}
        )
        await newHumidity.save()
        return true
    } catch (error) {
        return false
    }

}