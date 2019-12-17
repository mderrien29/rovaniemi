export class ErrorResponse {
  constructor( readonly errorCode: string, readonly error: string, readonly message: string) {}
}

export class AuthResponse {
  token: string;
}

export class AuthRequest {
  username: string;
  password: string;
}

export class BattleResponse {
  battles: Battle[];
}

export class Battle {
  id: number;
  name: string;
}

export interface DbUser {
  id: number;
  admin: boolean;
  name: string;
  password_hash: string;
}
