import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createDoor,getDoors} from '../controllers/doorController'

const router = Router()

router.get(
    '/:id',
    validateRequest,
    getDoors
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createDoor
)


export default router