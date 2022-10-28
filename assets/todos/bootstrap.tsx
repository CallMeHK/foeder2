import React from "react";
import * as ReactDOM from 'react-dom/client'
import { App } from './src/App'

const greeting = document.querySelector("body");
const root = ReactDOM.createRoot(greeting);
root.render(<App />);
