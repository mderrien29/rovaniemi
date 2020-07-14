import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { sha512 } from 'js-sha512';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async validateUser(username: string, pass: string): Promise<any> {
    const user = await this.usersService.findOne(username);
    console.log(JSON.stringify({...user, password_hash: 'REDACTED'}));
    if (user && user.password_hash === sha512(pass)) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  async login(user: any) {
    const payload = { name: user.name, id: user.id, isAdmin: user.admin };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
