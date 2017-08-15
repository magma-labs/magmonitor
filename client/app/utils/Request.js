import 'es6-promise';
import 'isomorphic-fetch';
import https from 'https';
import http from 'http';
import url from 'url';

export default {
  exec(method, url, body, requestHeaders) {
    const headers = requestHeaders || {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    const request = new Request(url, {
      method: method,
      headers: headers,
      body: JSON.stringify(body),
      credentials: 'same-origin'
    });

    return fetch(request).then(response => {
      if (response.status !== 200) {
        throw new Error(`${response.status} from the server`);
      }
      return response.json();
    });
  },

  post(url, body, requestHeaders) {
    return this.exec('POST', url, body, requestHeaders);
  },

  get(url, requestHeaders) {
    return this.exec('GET', url, undefined, requestHeaders);
  }
}
