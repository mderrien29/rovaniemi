import * as rp from 'request-promise-native';

export const getToken = async (username: string, password: string) => {
  const response = await rp.post({
    uri: 'http://localhost:9001/auth/login',
    form: {username: username, password: password},
    json: true,
  });
  return response.access_token;
};

export const getBattles = async (token: string) => {
  const response = await rp.get({
    headers: {
      'User-Agent': 'client',
    },
    auth: {
      'bearer': token,
    },
    uri: 'http://localhost:9001/me/battle',
    json: true,
  });
  return response;
};

export const getCategories = async (token: string, battle: number) => {
  const response = await rp.get({
    headers: {
      'User-Agent': 'client',
    },
    auth: {
      'bearer': token,
    },
    uri: `http://localhost:9001/battle/${battle}/categories`,
    json: true,
  });
  return response;
};

export const getSongs = async (token: string, category: number) => {
  const response = await rp.get({
    headers: {
      'User-Agent': 'client',
    },
    auth: {
      'bearer': token,
    },
    uri: `http://localhost:9001/categories/${category}/songs`,
    json: true,
  });
  return response;
};

export const addSong = async (token: string, category: number, url: string) => {
  const response = await rp.post({
    headers: {
      'User-Agent': 'client',
    },
    auth: {
      'bearer': token,
    },
    uri: `http://localhost:9001/categories/${category}/songs`,
    form: {url: url,},
    json: true,
  });

  console.log(response);
};


