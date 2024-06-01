import React, { useState } from 'react';
import {
  Button,
  Form,
  Input,
  Col,
  Row,
  message
} from 'antd';
import type { FormProps } from 'antd';
import { useLocation } from 'react-router-dom';
import request from '@/utils/request';

const { TextArea } = Input;

type FieldType = {
  certID?: string;
  userID?: string;
  certTitle?: string;
  certType?: string;
  certCont?: string;
};

const queryUpdate = (params: FieldType) => {
  request('/api/upload', {
    method: 'POST',
    data: params
  })
    .then((resp) => {
      console.log(resp);
    })
    .then(() => {
      message.success('提交成功', 1);
      setTimeout(() => {
        location.assign('/list/queryTable');
      }, 1000)
    })
}

const onFinish: FormProps<FieldType>['onFinish'] = (values) => {
  console.log('Success:', values);
  queryUpdate(values);
};

const onFinishFailed: FormProps<FieldType>['onFinishFailed'] = (errorInfo) => {
  console.log('Failed:', errorInfo);
};

const getPassedId = () => {
  const { search } = useLocation();
  return new URLSearchParams(search);
}

const FormDisabledDemo: React.FC = () => {
  const certID = getPassedId().get('id');

  return (
    <>
      <Row>
      <Col span={12}>
      <Form
        labelCol={{ span: 3 }}
        wrapperCol={{ span: 12 }}
        layout="horizontal"
        style={{ maxWidth: 600 }}
        onFinish={onFinish}
        onFinishFailed={onFinishFailed}
      >

        <Form.Item<FieldType> 
          name="certID" 
          label="证书ID"
          initialValue={certID ? certID : null}>
          {certID ? (
            <
              Input 
              placeholder="证书ID，留空则随机分配"  
              defaultValue={certID}
              disabled={true}
            />
          ) : (
            <
              Input 
              placeholder="证书ID，留空则随机分配"  
              disabled={false}
            />
          )}
          
        </Form.Item>
        <Form.Item<FieldType> name="userID" label="用户ID">
          <Input placeholder="用户ID，默认为当前用户"/>
        </Form.Item>
        <Form.Item<FieldType> name="certTitle" label="证书标题">
          <Input placeholder="证书的标题"/>
        </Form.Item>
        <Form.Item<FieldType> name="certType" label="证书类型">
          <Input placeholder="证书的类型"/>
        </Form.Item>
        <Form.Item<FieldType> name="certCont" label="证书内容">
          <TextArea rows={4} placeholder="证书的具体内容"/>
        </Form.Item>

        <Form.Item wrapperCol={{ offset: 3, span: 12 }}>
          <Button type="primary" htmlType="submit">提交</Button>
        </Form.Item>

      </Form>
      </Col>
      </Row>
    </>
  );
};

export default () => <FormDisabledDemo />;
