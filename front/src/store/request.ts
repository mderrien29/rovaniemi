import * as rp from 'request-promise-native';

// should be a config option
const host = `${window.location.protocol}/${window.location.hostname}:9001`;
console.log(host);

export const getToken = async (username: string, password: string) => {
  const response = await rp.post({
    uri: `${host}/auth/login`,
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
    uri: `${host}/me/battle`,
    json: true,
  });

  console.dir(response);
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
    uri: `${host}/battle/${battle}/categories`,
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
    uri: `${host}/categories/${category}/songs`,
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
    uri: `${host}/categories/${category}/songs`,
    form: {url: url,},
    json: true,
  });

  console.log(response);
};


