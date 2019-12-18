import { Controller, Request, Post, Get, Param, UseGuards, Body } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthService } from './auth/auth.service';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(
    private readonly authService: AuthService,
    private readonly appService: AppService,
  ) {}

  @Get()
  getHello() {
    return this.appService.getHello();
  }

  @UseGuards(AuthGuard('local'))
  @Post('auth/login')
  async login(@Request() req) {
    return await this.authService.login(req.user);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('me/battle')
  async getBattle(@Request() req) {
    return await this.appService.getBattle(req.user);
  }

  // @UseGuards(AuthGuard('jwt'))
  // @Get('battle/:id/all')
  // async getAll(@Request() req, @Param('id') battleId) {
  //   return await this.appService.getAll(req.user, battleId);
  // }

  @UseGuards(AuthGuard('jwt'))
  @Get('battle/:id/categories')
  async getCategories(@Request() req, @Param('id') battleId) {
    return await this.appService.getCategories(battleId);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('categories/:id/songs')
  async getSongs(@Request() req, @Param('id') categoryId) {
    return await this.appService.getSongs(req.user, categoryId);
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('categories/:id/songs')
  async addSongs(@Request() req, @Param('id') categoryId, @Body('url') songUrl) {
    return await this.appService.addSongs(req.user, categoryId, songUrl);
  }
}
