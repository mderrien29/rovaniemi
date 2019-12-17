import { Injectable } from '@nestjs/common';
import { DbService } from './db/db.service';

@Injectable()
export class AppService {
  constructor(
    private readonly dbService: DbService
  ) {}

  getHello(): string {
    return 'rovaniemi backend';
  }

  async getAll(user, battleId): Promise<any> {
    //todo
    return new Promise(() => []);
  }

  async getBattle(user): Promise<any> {
    return await this.dbService.query(DbService.GET_BATTLE(user.id));
  }

  async getCategories(battleId): Promise<any> {
    return await this.dbService.query(DbService.GET_CATEGORIES(battleId));
  }

  async getSongs(user, categoryId): Promise<any> {
    const songs = await this.dbService.query(DbService.GET_SONGS(categoryId));

    songs.forEach(song => {
      if (song.userId !== user) {
        song.url = '';
      }
    });

    return songs;
  }
}
