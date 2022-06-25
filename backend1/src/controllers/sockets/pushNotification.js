import {fcmAdmin} from '../../index'
import Phone from '../../models/Phone'

export const sendPushNotifications = async(id,title,body) =>{

  try {
      const tokens = []
      const phones = await Phone.find({
          user:id
      })
      for(const phone in phones){
          tokens.push(phones[phone].token)
      }
      const message = {
        notification:{
          title:title,
          body:body
        },
        tokens: tokens,
      } 
      fcmAdmin.messaging().sendMulticast(message)
      .then((response) => {
        if (response.failureCount > 0) {
          const failedTokens = [];
          response.responses.forEach((resp, idx) => {
            if (!resp.success) {
              failedTokens.push(registrationTokens[idx]);
            }
          });
          console.log('List of tokens that caused failures: ' + failedTokens);
        }
      });

    } catch (error) {
        console.log(error)
    }
}





