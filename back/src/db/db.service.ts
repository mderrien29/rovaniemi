import { Injectable } from '@nestjs/common';
import { createConnection } from 'mysql';
import { DbUser } from '../app.model';

@Injectable()
export class DbService {
  db: any;

  static GET_USER(username: string): string {
    return `SELECT * FROM USER WHERE name='${username}'`;
  }

  constructor() {
    this.db = createConnection({
      host: process.env.ROVANIEMI_DB_HOST,
      user: process.env.ROVANIEMI_DB_USER,
      password: process.env.ROVANIEMI_DB_PASSWORD,
      database: process.env.ROVANIEMI_DB_NAME,
    });
  }

  query(query: string): Promise<DbUser> {
    return new Promise((resolve, reject) => {
      this.db.query(query, (err: Error, res) => {
        if (err) {
          console.log(err);
          resolve(undefined);
        }
        resolve(res);
      });
    });
  }
}
