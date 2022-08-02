import React from "react";
import * as ReactDOM from 'react-dom/client'
import { App } from "./App";

const greeting = document.getElementById("greeting");
const root = ReactDOM.createRoot(greeting);
root.render(<App />);
