import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createWhaterSensor,getWhaterSensors} from '../controllers/farmWhaterController'

const router = Router()

router.get(
    '/:id',
    getWhaterSensors
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createWhaterSensor
)


export default router