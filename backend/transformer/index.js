exports.handler = async (event) => {
  for (const record of event.Records ?? []) {
    // placeholder to keep infra working; real logic will be added later
    console.log("received", record.s3?.object?.key);
  }
  return { statusCode: 200 };
};

