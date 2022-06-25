import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createHumiditySensor,getHumiditySensors} from '../controllers/farmHumidityController'

const router = Router()

router.get(
    '/:id',
    getHumiditySensors
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createHumiditySensor
)


export default router