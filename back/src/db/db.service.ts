import { Injectable } from '@nestjs/common';
import { createConnection } from 'mysql';
import { DbUser } from '../app.model';

@Injectable()
export class DbService {
  db: any;

  static GET_USER(username: string): string {
    return `SELECT * FROM USER WHERE name='${username}'`;
  }

  static GET_BATTLE(userId): string {
    return `SELECT b.* FROM USER_BATTLE as u_b, BATTLE AS b WHERE u_b.userId=${userId} AND b.id=u_b.battleId`;
  }

  static GET_CATEGORIES(battleId): string {
    return `SELECT c.* FROM BATTLE as b, CATEGORY as c WHERE b.id=c.battleId AND b.id=${battleId}`;
  }

  static GET_SONGS(categoryId): string {
    return `SELECT s.* FROM CATEGORY as c, SONG as s WHERE b.id=s.category.id AND c.id=${categoryId}`;
  }

  constructor() {
    this.db = createConnection({
      host: process.env.ROVANIEMI_DB_HOST,
      user: process.env.ROVANIEMI_DB_USER,
      password: process.env.ROVANIEMI_DB_PASSWORD,
      database: process.env.ROVANIEMI_DB_NAME,
    });
  }

  query(query: string): Promise<any[]> {
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
