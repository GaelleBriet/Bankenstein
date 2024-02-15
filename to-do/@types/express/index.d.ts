declare namespace Express {
  export interface Request {
    session: {
      user?: {
        id: number
        email: string
        password: string
      }
    };
  }
}
