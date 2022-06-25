import FoodRead from '../../models/FoodRead'
import FoodSensor from '../../models/FoodSensor'

export const saveFoodRead = async (payload) => {
    const {sensor,food} = payload
    const newFood = new FoodRead({
        food_sensor:sensor,
        food_level:food
    });

    try {
        const findFoodSensor = await FoodSensor.findByIdAndUpdate(sensor)
        if(!findFoodSensor) return false
        await FoodSensor.findByIdAndUpdate(
            {_id:sensor},
            {food_level:food}
        )
        await newFood.save()
        return true
    } catch (error) {
        return false
    }

}