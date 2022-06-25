import {Router} from 'express'
import {check} from 'express-validator'
import * as phone from '../controllers/phoneController'
import {validateRequest} from '../middleware/validateRequest'
import * as auth from '../middleware/auth'

const router = Router()

router.post(
    '/',
    [
        check('userid','userid is required').not().isEmpty()
    ],
    validateRequest,
    [
        auth.verifyToken,
    ],
    phone.createPhone
)

export default router
