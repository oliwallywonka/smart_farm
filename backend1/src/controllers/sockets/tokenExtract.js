

export const extractToken = (token64Token) =>{
    const buff = Buffer.from(token64Token.substring(6),'base64')
    const tokenSubstring = buff.toString('ascii')
    const token = tokenSubstring.substring(1)
    
    return token
}