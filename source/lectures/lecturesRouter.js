import express from "express";
import lecturesController from "./lecturesController";

const lecturesRouter = express.Router();

lecturesRouter.get("/");

export default lecturesRouter;
