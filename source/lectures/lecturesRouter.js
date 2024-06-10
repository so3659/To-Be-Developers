import express from "express";
import lecturesController from "./lecturesController";

const lecturesRouter = express.Router();

lecturesRouter.get("/", (req, res) => {
    console.log("good!")});


export default lecturesRouter;
