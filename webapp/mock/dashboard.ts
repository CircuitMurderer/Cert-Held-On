// eslint-disable-next-line import/no-extraneous-dependencies
import { Request, Response } from 'express';

export default {
  'GET /api/dashboard/card': (req: Request, res: Response) => {
    setTimeout(() => {
      res.send({
        code: '0',
        data: {
          headCount: 5,
          surveyCount: 10,
          totalCount: 3,
          deadLine: new Date().toLocaleDateString(),
          rate: 22,
          lossRate: 78,
        },
      });
    }, 1500);
    return;
  },
};
