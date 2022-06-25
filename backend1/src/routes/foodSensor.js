import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createFoodSensor,getFoodSensors} from '../controllers/farmFoodController'

const router = Router()

router.get(
    '/:id',
    getFoodSensors
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createFoodSensor
)


export default router