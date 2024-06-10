import express from "express";
import devsController from "./devsController";

const devsRouter = express.Router();

devsRouter.get("/report", devsController.devReport);

export default devsRouter;
