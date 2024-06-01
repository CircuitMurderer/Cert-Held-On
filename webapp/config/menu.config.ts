export default [
  {
    title: '主页',
    link: '/dashboard',
    key: 'dashboard',
    icon: '',
    children: [],
  },
  {
    title: '证书查询',
    link: '/list',
    key: 'list',
    icon: '',
    children: [
      {
        title: '证书列表',
        link: '/list/queryTable',
        key: 'queryTable',
        icon: '',
        children: [],
      },
    ],
  },
  {
    title: '证书功能',
    link: '/func',
    key: 'func',
    icon: '',
    children: [
      {
        title: '证书更新',
        link: '/func/update',
        key: 'update',
        icon: '',
        children: [],
      },
      {
        title: '证书认证',
        link: '/func/verify',
        key: 'verify',
        icon: '',
        children: [],
      },
    ],
  },
];
