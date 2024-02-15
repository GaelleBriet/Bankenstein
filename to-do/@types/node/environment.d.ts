declare global {
  namespace NodeJS {
    interface ProcessEnv {
      NODE_ENV: "development" | "production" | "test";
      PORT?: number;
      SESSION_SECRET?: string;
    }
  }
}
