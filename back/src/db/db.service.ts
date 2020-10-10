import { Injectable } from '@nestjs/common';
import { createConnection, Connection } from 'mysql';

@Injectable()
export class DbService {
  db: Connection;

  constructor() {
    this.db = createConnection({
      host: process.env.ROVANIEMI_DB_HOST,
      user: process.env.ROVANIEMI_DB_USER,
      password: process.env.ROVANIEMI_DB_PASSWORD,
      database: process.env.ROVANIEMI_DB_NAME,
    });
  }

  static GET_USER(username: string): string {
    return `SELECT * FROM USER WHERE name='${username}'`;
  }

  static GET_BATTLE(userId): string {
    return `SELECT b.id, b.name FROM USER_BATTLE as u_b, BATTLE AS b WHERE u_b.userId=${userId} AND b.id=u_b.battleId`;
  }

  static GET_CATEGORIES(battleId): string {
    return `SELECT c.id, c.name FROM BATTLE as b, CATEGORY as c WHERE b.id=c.battleId AND b.id=${battleId}`;
  }

  static GET_SONGS(categoryId): string {
    return `SELECT s.id, s.url, u.name, s.userId FROM USER as u, CATEGORY as c, SONG as s WHERE c.id=s.categoryId AND c.id=${categoryId} AND u.id=s.userId`;
  }

  static GET_ALL(userId, battleId): string {
    return `SELECT * FROM BATTLE as b, CATEGORY as c, SONG as s WHERE b.id=${battleId} AND c.battleId=b.id AND c.id=s.categoryId`; // tslint:disable-line
  }

  static INSERT_SONG(userId, categoryId, songUrl): string {
    return `INSERT INTO SONG (id, userId, categoryId, url) VALUES (NULL, '${userId}', '${categoryId}', '${songUrl}')`;
  }

  static DELETE_SONG(userId, categoryId): string {
    return `DELETE FROM SONG WHERE EXISTS (SELECT * FROM SONG WHERE userId=${userId} AND categoryId=${categoryId}) AND userId='${userId}' AND categoryId='${categoryId}'`;
  }


  query(query: string): Promise<any[]> {
    return new Promise((resolve, reject) => {
      this.db.query(query, (err: Error, res) => {
        if (err) {
          console.log(err);
          resolve(undefined);
        }

        console.log(res);
        resolve(res);
      });
    });
  }
}
