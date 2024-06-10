import express from "express";
import devsController from "./devsController";

const devsRouter = express.Router();

devsRouter.get("/");

export default devsRouter;
