// eslint-disable-next-line import/no-extraneous-dependencies
import { Request, Response } from 'express';
import request from 'umi-request';

export default {
  'POST  /api/verify': (req: Request, res: Response) => {
    const { certID, status, expDays } = req.body;

    request
      .post('http://localhost:3000/invoke', {
        data: {
          function: 'VerifyCert',
          args: [
            certID,
            status,
            expDays
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