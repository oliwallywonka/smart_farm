import {Router} from 'express'
import {getRols,createRol,getRol,editRol,activateRol,desactivateRol} from '../controllers/rolController'

const router = Router()

router.get(
    '/',
    getRols
)

router.post(
    '/',
    createRol
)

router.get(
    '/:id',
    getRol
)

router.put(
    '/:id',
    editRol
)

router.put(
    '/:id/activate',
    activateRol
)

router.delete(
    '/:id/desactivate',
    desactivateRol
)