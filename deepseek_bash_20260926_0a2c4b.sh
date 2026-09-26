# 1. Crear el proyecto Next.js (dentro de la carpeta que quieras)
npx create-next-app@latest telcel-store --typescript --tailwind --app --src-dir --import-alias "@/*"

cd telcel-store

# 2. Instalar dependencias adicionales
npm install @prisma/client next-auth bcryptjs nodemailer zod react-hook-form @hookform/resolvers clsx tailwind-merge date-fns
npm install -D prisma tsx @types/bcryptjs @types/nodemailer

# 3. Copiar los archivos de arriba:
#    - docker-compose.yml
#    - .env.example  (renombrarlo a .env)
#    - prisma/schema.prisma
#    - package.json  (reemplazar el generado)

# 4. Levantar PostgreSQL
docker compose up -d

# 5. Generar cliente Prisma y crear las tablas
npx prisma generate
npx prisma migrate dev --name init

# 6. Ver la BD (opcional)
npx prisma studio   # http://localhost:5555

# 7. Arrancar el proyecto
npm run dev         # http://localhost:3000