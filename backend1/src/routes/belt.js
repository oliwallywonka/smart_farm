import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createBelt,getBelt} from '../controllers/beltController'

const router = Router()

router.get(
    '/:id',
    validateRequest,
    getBelt
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createBelt
)

export default router