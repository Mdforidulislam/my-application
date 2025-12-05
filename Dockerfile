# 1️⃣ Base OS + Node runtime
FROM node:20-alpine

# 2️⃣ Set working directory inside container
WORKDIR /app

# 3️⃣ Copy package files first (for layer caching)
COPY package*.json ./

# 4️⃣ Install dependencies
RUN npm install

# 5️⃣ Copy rest of the source code
COPY . .

# 6️⃣ Build Next.js app
RUN npm run build

# 7️⃣ Expose default Next.js port
EXPOSE 3000

# 8️⃣ Start the app
CMD ["npm", "start"]
