import {Router} from 'express'
import {check} from 'express-validator'
import {validateRequest} from '../middleware/validateRequest';
import {createWindow,getWindows} from '../controllers/windowController'

const router = Router()

router.get(
    '/:id',
    validateRequest,
    getWindows
)

router.post(
    '/',
    [
        check('idFarm').not().isEmpty()
    ],
    validateRequest,
    createWindow
)


export default router