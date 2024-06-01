import React, { useState } from 'react';
import {
  Button,
  Form,
  Input,
  Col,
  Row,
  InputNumber,
  Select
} from 'antd';
import type { FormProps } from 'antd';
import { useLocation } from 'react-router-dom';
import request from '@/utils/request';

type FieldType = {
  certID?: string;
  status?: string;
  expDays?: number;
};

const queryVerify = (params: FieldType) => {
  request('/api/verify', {
    method: 'POST',
    data: params
  })
  .then((resp) => {
    console.log(resp);
  });
}

const onFinish: FormProps<FieldType>['onFinish'] = (values) => {
  queryVerify(values);
  console.log('Success:', values);
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
        <Form.Item<FieldType> name="status" label="证书状态">
          <Select>
            <Select.Option value="Valid">有效</Select.Option>
            <Select.Option value="Invalid">无效</Select.Option>
            <Select.Option value="Outdate">过期</Select.Option>
            <Select.Option value="Revoke">撤销</Select.Option>
          </Select>
        </Form.Item>
 
        <Form.Item<FieldType> 
          name="expDays" 
          label="有效期"
          initialValue={0}
        >
          <InputNumber defaultValue={0}/>
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
