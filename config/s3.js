import { S3Client, DeleteObjectsCommand } from "@aws-sdk/client-s3";

const s3 = new S3Client({
	credentials: {
		accessKeyId: process.env.S3_ACCESS_KEY,
		secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
	},
	region: "ap-northeast-3",
});

export const deleteS3Images = async (imageUrls) => {
	const command = new DeleteObjectsCommand({
		Bucket: "bookjam-dev-s3",
		Delete: {
			Objects: imageUrls.map((imageUrl) => ({
				Key: imageUrl.split("https://bookjam-dev-s3.s3.ap-northeast-3.amazonaws.com/")[1],
			})),
		},
	});

	const { Deleted } = await s3.send(command);

	return Deleted;
};

export default s3;
