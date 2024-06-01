// eslint-disable-next-line import/no-extraneous-dependencies
import { Request, Response } from 'express';
import request from 'umi-request';

function genRandStr(length: number) {
  let result = '';
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const charsLen = chars.length;
  for (let i = 0; i < length; i++) {
    result += chars.charAt(Math.floor(Math.random() * charsLen));
  }
  return result;
}

export default {
  'POST  /api/upload': (req: Request, res: Response) => {
    const { certID, userID, certTitle, certType, certCont } = req.body;
    const indexKey = genRandStr(16);

    request
      .post('http://localhost:3000/invoke', {
        data: {
          function: 'SubmitReq',
          args: [
            certID,
            userID,
            certTitle, 
            certType, 
            certCont,
            indexKey
          ]
        },
        requestType: 'form',
        headers: {
          'Content-Type': 
            'application/x-www-form-urlencoded'
        },
      })
      .then((resp) => {
        setTimeout(() => {
          res.send({
            status: 'ok',
            data: resp,
          })
        }, 1000)
      })
      .catch((e) => {
        console.log(e)
      })
  }
}