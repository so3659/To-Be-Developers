import express from "express";
import cors from "cors";
import { response } from "./response";
import baseResponse from "./baseResponeStatus";
import lecturesRouter from "../source/lectures/lecturesRouter";
import devsRouter from "../source/developers/devsRouter";
import swaggerUi from "swagger-ui-express";
import yaml from "js-yaml";
import fs from "fs";

const app = express();

/*
const swaggerSpec = yaml.load(
    fs.readFileSync("./src/swagger/swagger.yaml", "utf8"),
);
*/

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get("/health", (req, res) =>
    res.status(200).send(response(baseResponse.SUCCESS, "Hello World!")),
);

app.use("/lectures", lecturesRouter);
app.use("/devs", devsRouter);
//app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

export default app;
