import {Router} from 'express'
import {check} from 'express-validator'
import {signIn,signUp,renewToken} from '../controllers/authController'
import {validateRequest} from '../middleware/validateRequest';
import * as auth from '../middleware/auth'
const router = Router()

router.post(
    '/signup',
    [
        check('user','User is required').not().isEmpty(),
        check('email','Valid Email is required').isEmail(),
        check('password','Password min length is 6').isLength({min:6})
    ],
    validateRequest,
    signUp
)

router.post(
    '/signin',
    [
        check('email','Valid Email is required').isEmail(),
        check('password','Password min length is 6').isLength({min:6})
    ],
    validateRequest,
    signIn
)

router.get(
    '/renew',
    auth.verifyToken,
    renewToken,

)

export default router