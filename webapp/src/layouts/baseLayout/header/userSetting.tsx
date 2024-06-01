import React, { FC } from 'react';
import { connect, Dispatch } from 'umi';
import { ClickParam } from 'antd/es/menu';
import { Dropdown, Menu } from 'antd';
import {
  SettingOutlined,
  LogoutOutlined,
  DownOutlined,
} from '@ant-design/icons';
import { LoginModelState, GlobalModelState } from '@/models/connect';

export interface HeaderLayoutProps {
  dispatch: Dispatch;
  global: GlobalModelState;
}

const UserSettingLayout: FC<HeaderLayoutProps> = ({ global, dispatch }) => {
  const { userInfo } = global;

  function handleSubmit(event: ClickParam) {
    const { key } = event;
    if (key === 'userinfo') {
      alert(userInfo.username);
    }
    if (key === 'logout') {
      dispatch({
        type: 'login/logout',
      });
    }
  }

  const menu = (
    <Menu onClick={handleSubmit}>
      <Menu.Item key="userinfo">
        <SettingOutlined /> 用户信息

      </Menu.Item>
      <Menu.Divider />
      <Menu.Item key="logout">
        <LogoutOutlined /> 退出登录
      </Menu.Item>
    </Menu>
  );

  return (
    <div
      style={{
        width: 200,
        textAlign: 'right',
      }}
    >
      <Dropdown overlay={menu} placement="bottomRight">
        <span style={{ cursor: 'pointer', color: '#fff', fontSize: 16 }}>
          {userInfo.username} <DownOutlined />
        </span>
      </Dropdown>
    </div>
  );
};

export default connect(
  ({
    login,
    global,
  }: {
    login: LoginModelState;
    global: GlobalModelState;
  }) => ({ login, global }),
)(UserSettingLayout);
