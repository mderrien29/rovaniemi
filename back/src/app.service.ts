import { Injectable } from '@nestjs/common';
import { DbService } from './db/db.service';

@Injectable()
export class AppService {
  constructor(private readonly dbService: DbService) {}

  getHello(): string {
    return 'rovaniemi backend';
  }

  async getAll(user, battleId): Promise<any> {
    const results = await this.dbService.query(
      DbService.GET_ALL(user.id, battleId),
    );

    return results;
  }

  async getBattle(user): Promise<any> {
    return await this.dbService.query(DbService.GET_BATTLE(user.id));
  }

  async getCategories(battleId): Promise<any> {
    return await this.dbService.query(DbService.GET_CATEGORIES(battleId));
  }

  async getSongs(user, categoryId): Promise<any> {
    let songs = await this.dbService.query(DbService.GET_SONGS(categoryId));
    console.log(songs)

    songs = this.hideSongs(user, songs);
    console.log(songs)

    return songs;
  }

  async addSongs(user, categoryId, songUrl): Promise<any> {
    await this.dbService.query(
      DbService.DELETE_SONG(user.id, categoryId)
    );

    return await this.dbService.query(
      DbService.INSERT_SONG(user.id, categoryId, songUrl),
    );
  }

  private hideSongs(user, songs): any[] {
    songs.forEach(song => {
      if (!user.isAdmin && song.userId !== user.id) {
        song.url = '';
      }
    });

    return songs;
  }
}
