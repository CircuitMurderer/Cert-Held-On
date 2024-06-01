// eslint-disable-next-line import/no-extraneous-dependencies
import { Request, Response } from 'express';
import request from 'umi-request';

export default {
  'POST  /api/queryTableList': (req: Request, res: Response) => {
    request
      .get('http://localhost:3000/query?function=GetAllCerts')
      .then((resp) => {
        for (const item of resp) {
          item.ID = item.ID.substring(item.ID.indexOf("-") + 1);
          if (item.ExpDays === -1) {
            item.ExpDays = '无';
          } else if (item.ExpDays === -2) { 
            item.ExpDays = '永久';
          } else {
            item.ExpDays = item.ExpDays.toString() + '天';
          }

          if (item.ReqTime === '') {
            item.ReqTime = '未知'
          }
        }

        setTimeout(() => {
          res.send({
            status: 'ok',
            data: resp,
          });
        }, 1000);
      })
      .catch((e) => {
        console.log(e)
      })
  },
};
