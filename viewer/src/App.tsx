// import React from 'react';
// import logo from './logo.svg';
import './App.css';
import 'antd/dist/reset.css'
import { Button, Space, DatePicker, version } from 'antd';

/* 
function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}
*/

const MyButt = () => (
    <Button type="primary">Button</Button>
);

const App = () => (
  <div className="App">
    <h1>AntD ver: {version}.</h1>
    <h2>This is a APP.</h2>
    <Space>
      <DatePicker />
      <MyButt />
    </Space>
  </div>
);

export default App;
