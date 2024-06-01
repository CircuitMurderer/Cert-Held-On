import React, { FC, useEffect } from 'react';
import { connect } from 'umi';
import { Divider, Badge, Modal, message } from 'antd';
import TableComponent from '@/components/tableComponent';
import { ColumnsType } from 'antd/es/table';
import { QueryTableState, Loading } from '@/models/connect';
import FilterRegion from './components/filterRegion';
import { QueryTableProps } from './queryTable';

type RecordType = {};
const statusTextMap = [
  '有效',
  '无效',
  '待验证',
  '已过期',
  '已撤销',
  '未知状态'
];

// type RecType = {
//   ID: string,
//   UsrID: string,
//   Status: number,
//   ExpDays: number,
//   ReqTime: string,
//   IsuTime: string,
//   RvkTime: string,
//   Key: string
// };

const QueryTable: FC<QueryTableProps> = ({ dispatch, queryTable, loading }) => {
  const { queryTableSource } = queryTable;

  const jumpTo = (to: string, id: string) => {
    message.info('正在跳转……', 1);
    setTimeout(() => {
      location.assign("/func/" + to + "?id=" + id);
    }, 1000);
  }

  const showDetail = (record: any) => {
    Modal.info({
      title: (<strong>证书详情</strong>),
        content: (
          <div>
              <p><strong>证书ID：</strong>{record.ID}</p>
              <p><strong>用户ID：</strong>{record.UsrID}</p>
              <p><strong>证书状态：</strong>{statusTextMap[record.Status]}</p>
              <p><strong>有效期：</strong>{record.ExpDays}</p>
              <p><strong>申请时间：</strong>{record.ReqTime}</p>
              <p><strong>颁发时间：</strong>{record.IsuTime ? record.IsuTime : '无'}</p>
              <p><strong>撤销时间：</strong>{record.RvkTime ? record.RvkTime : '无'}</p>
              <p><strong>内容：</strong>在HTML中，要让冒号之后的文本对其，可以使用CSS样式来实现。你可以通过设置text-align: justify; 属性来对文本进行对齐，或者使用</p>
          </div>
        ),
      onOk: () => { }, //showAlert(); },
      okText: '关闭',
    });
  };

  function getStatusText(status: number) {
    if (status === 0) {
      return (
        <span>
          <Badge status="success" />
          {statusTextMap[status]}
        </span>
      );
    }

    if (status === 1) {
      return (
        <span>
          <Badge status="error" />
          {statusTextMap[status]}
        </span>
      );
    }

    if (status === 2) {
      return (
        <span>
          <Badge status="processing" />
          {statusTextMap[status]}
        </span>
      );
    }

    if (status === 3) {
      return (
        <span>
          <Badge status="warning" />
          {statusTextMap[status]}
        </span>
      );
    }

    if (status === 4) {
      return (
        <span>
          <Badge status="default" />
          {statusTextMap[status]}
        </span>
      );
    }

    return (
      <span>
        <Badge status="default" />
        {statusTextMap[5]}
      </span>
    );
  }

  useEffect(() => {
    dispatch({
      type: 'queryTable/queryTableList',
      payload: {},
    });
  }, []);

  const columns: ColumnsType<RecordType> = [
    {
      title: '证书ID',
      key: 'name',
      dataIndex: 'ID',
      ellipsis: true,
    },
    {
      title: '用户ID',
      dataIndex: 'UsrID',
    },
    {
      title: '申请时间',
      dataIndex: 'ReqTime',
    },
    {
      title: '有效期',
      dataIndex: 'ExpDays',
    },
    {
      title: '证书状态',
      dataIndex: 'Status',
      render: text => getStatusText(text),
    },
    {
      title: '操作',
      dataIndex: 'option',
      render: (_, record: any) => (
        <>
          <a
            onClick={() => {
              showDetail(record);
            }}
          >
            详情
          </a>
          <Divider type="vertical" />
          <a 
            onClick={() => {
              jumpTo('update', record.ID);
            }}
          >
            更新
          </a>
          <Divider type="vertical" />
          <a 
            onClick={() => {
              jumpTo('verify', record.ID);
            }}
          >
            认证
          </a>
        </>
      ),
    },
  ];

  return (
    <div>
      <FilterRegion />
      <TableComponent
        columns={columns}
        dataSource={queryTableSource}
        rowKey="ID"
        loading={loading}
      />
    </div>
  );
};

export default connect(
  ({
    queryTable,
    loading,
  }: {
    queryTable: QueryTableState;
    loading: Loading;
  }) => ({
    queryTable,
    loading: loading.models.queryTable,
  }),
)(QueryTable);
