import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest'
import {verifyToken} from '../middleware/auth'
import {createTemperatureSensor,getTemperatureSensors} from '../controllers/farmTemperatureController'

const router = Router()

router.get(
    '/:id',
    verifyToken,
    getTemperatureSensors
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createTemperatureSensor
)


export default router