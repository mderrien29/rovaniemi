import { Injectable } from '@nestjs/common';
import { DbService } from '../db/db.service';

export type User = any;

@Injectable()
export class UsersService {
  private readonly users: User[];

  constructor(
    private readonly dbService: DbService
  ) {}

  async findOne(username: string): Promise<User | undefined> {
    const result = await this.dbService.query(DbService.GET_USER(username));
    console.dir(result);
    return result[0];
  }
}
