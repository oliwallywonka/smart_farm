import jwt from 'jsonwebtoken'

export const generateJWT = (payload) => {

    try {
        /*jwt.sign(
            payload,
            process.env.SECRETA,
            {expiresIn:3600},
            (error,token)=> {
                if(error) throw error
                return token
            }
        )*/

        return new Promise((resolve,reject)=>{
            jwt.sign(
                payload,
                process.env.SECRETA,
                {expiresIn:'24h'},
                async(err,token)=>{
                    if(err){
                        reject('can´t generate JWT')
                    }else{
                        resolve(token)
                    }
                }
            )
        })
    } catch (error) {
        console.log(error)
    }
    
}

export const checkJWT = (token) => {
    try {
        const {id} = jwt.verify(
            token,
            process.env.SECRETA
        )

        return [true,id]
    } catch (error) {
        return [false,null]
    }
}