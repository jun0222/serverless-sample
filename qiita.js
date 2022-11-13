import axios from "axios";

export const hello = async (event, context, callback) => {
  const res = await axios({
    method: "get",
    url: process.env.endpoint,
    params: {
      page: 1,
      per_page: 100,
    },
  });

  const result = [];
  if (res.data) {
    Promise.all(
      res.data.map(async (element) => {
        const record = {
          id: element.id,
          title: element.title,
          url: element.url,
          likes_count: element.likes_count,
          created_at: element.created_at,
          updated_at: element.updated_at,
          tags: element.tags,
        };
        result.push(record);
      })
    );
  }

  callback(null, {
    message: "qiita article data success.",
    data: result,
    event,
  });
};
