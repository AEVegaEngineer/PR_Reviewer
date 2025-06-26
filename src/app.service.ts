import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getWebsocket(): string {
    return 'Hello web socket!';
  }
}
