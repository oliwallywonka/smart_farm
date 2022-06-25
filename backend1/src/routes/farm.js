import {Router} from 'express'
import {check} from 'express-validator'
import * as farm from '../controllers/farmController'
import {validateRequest} from '../middleware/validateRequest'
import * as auth from '../middleware/auth'

const router = Router()

router.put(
    '/',
    [
        check('idFarm','idFarm is required').not().isEmpty()
    ],
    validateRequest,
    [
        auth.verifyToken
    ],
    farm.updateFarm
)

router.post(
    '/',
    [
        check('userid','userid is required').not().isEmpty(),
        check('name','name is required').not().isEmpty()
    ],
    validateRequest,
    [
        auth.verifyToken,
        auth.isFarmAdmin
    ],
    farm.createFarm
)

router.get(
    '/',
    [
        auth.verifyToken,
        auth.isFarmAdmin
    ],
    farm.getFarm
)

export default router