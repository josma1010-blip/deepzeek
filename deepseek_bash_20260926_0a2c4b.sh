¡Perfecto! Aquí tienes **todos los archivos de la Fase 1** en un solo bloque, con separadores claros. Al final te doy un **script que los separa automáticamente en archivos reales y genera el `.zip`**.

---

## 📦 Bloque único con todos los archivos

Copia TODO lo que está entre `===== INICIO =====` y `===== FIN =====` a un archivo llamado `fase1.txt`.

```
===== INICIO =====
=== FILE: telcel-store/docker-compose.yml ===
version: '3.9'

services:
  postgres:
    image: postgres:16-alpine
    container_name: telcel-store-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: store_user
      POSTGRES_PASSWORD: store_password_change_me
      POSTGRES_DB: telcel_store
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  adminer:
    image: adminer:latest
    container_name: telcel-store-adminer
    restart: unless-stopped
    ports:
      - "8080:8080"
    depends_on:
      - postgres

volumes:
  postgres_data:

=== FILE: telcel-store/.env.example ===
# ========================
# BASE DE DATOS
# ========================
DATABASE_URL="postgresql://store_user:store_password_change_me@localhost:5432/telcel_store?schema=public"

# ========================
# NEXT.JS
# ========================
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="genera_uno_con_openssl_rand_base64_32"

# ========================
# APP
# ========================
NEXT_PUBLIC_APP_URL="http://localhost:3000"
NEXT_PUBLIC_STORE_NAME="Mi Tienda SIM"
NEXT_PUBLIC_WHATSAPP_NUMBER="5215500000000"

# ========================
# PAGOS (Fase 5)
# ========================
MERCADOPAGO_ACCESS_TOKEN=""
MERCADOPAGO_PUBLIC_KEY=""
MERCADOPAGO_WEBHOOK_SECRET=""
STRIPE_SECRET_KEY=""
STRIPE_WEBHOOK_SECRET=""
PAYPAL_CLIENT_ID=""
PAYPAL_CLIENT_SECRET=""

# ========================
# SMTP (Fase 6)
# ========================
SMTP_HOST=""
SMTP_PORT="587"
SMTP_USER=""
SMTP_PASSWORD=""
SMTP_FROM="no-reply@mitienda.mx"

# ========================
# SEGURIDAD
# ========================
RATE_LIMIT_MAX="100"
RATE_LIMIT_WINDOW_MS="60000"

=== FILE: telcel-store/.gitignore ===
node_modules
.next
out
.env
.env.local
.env.production
*.log
dist
build
.DS_Store
coverage
.vercel
.idea
.vscode

=== FILE: telcel-store/package.json ===
{
  "name": "telcel-store",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "prisma generate && next build",
    "start": "next start",
    "lint": "next lint",
    "db:generate": "prisma generate",
    "db:migrate": "prisma migrate dev",
    "db:push": "prisma db push",
    "db:studio": "prisma studio",
    "db:seed": "tsx prisma/seed.ts",
    "postinstall": "prisma generate"
  },
  "dependencies": {
    "@prisma/client": "^5.22.0",
    "@hookform/resolvers": "^3.9.1",
    "bcryptjs": "^2.4.3",
    "clsx": "^2.1.1",
    "date-fns": "^4.1.0",
    "next": "14.2.18",
    "next-auth": "^4.24.10",
    "nodemailer": "^6.9.16",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-hook-form": "^7.53.2",
    "tailwind-merge": "^2.5.5",
    "zod": "^3.23.8"
  },
  "devDependencies": {
    "@types/bcryptjs": "^2.4.6",
    "@types/node": "^22.10.1",
    "@types/nodemailer": "^6.4.17",
    "@types/react": "^18.3.12",
    "@types/react-dom": "^18.3.1",
    "autoprefixer": "^10.4.20",
    "eslint": "^8.57.1",
    "eslint-config-next": "14.2.18",
    "postcss": "^8.4.49",
    "prisma": "^5.22.0",
    "tailwindcss": "^3.4.16",
    "tsx": "^4.19.2",
    "typescript": "^5.7.2"
  }
}

=== FILE: telcel-store/tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [{ "name": "next" }],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}

=== FILE: telcel-store/next.config.js ===
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    remotePatterns: [
      { protocol: 'https', hostname: '**' }
    ]
  },
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
          { key: 'X-Content-Type-Options', value: 'nosniff' },
          { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
          { key: 'Permissions-Policy', value: 'camera=(), microphone=(), geolocation=()' }
        ]
      }
    ];
  }
};

module.exports = nextConfig;

=== FILE: telcel-store/postcss.config.js ===
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};

=== FILE: telcel-store/tailwind.config.ts ===
import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}'
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          50: '#eff6ff',
          100: '#dbeafe',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          900: '#1e3a8a'
        }
      },
      fontFamily: {
        sans: ['var(--font-inter)', 'system-ui', 'sans-serif']
      }
    }
  },
  plugins: []
};

export default config;

=== FILE: telcel-store/prisma/schema.prisma ===
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// =====================================================
// USUARIOS Y CLIENTES
// =====================================================

enum UserRole {
  CUSTOMER
  ADMIN
  SUPER_ADMIN
}

model User {
  id            String    @id @default(cuid())
  email         String    @unique
  emailVerified DateTime?
  passwordHash  String
  name          String?
  phone         String?
  role          UserRole  @default(CUSTOMER)
  isActive      Boolean   @default(true)
  createdAt     DateTime  @default(now())
  updatedAt     DateTime  @updatedAt

  customer  Customer?
  sessions  Session[]
  adminLogs AdminActivityLog[]

  @@index([email])
  @@map("users")
}

model Session {
  id           String   @id @default(cuid())
  sessionToken String   @unique
  userId       String
  expires      DateTime
  user         User     @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@map("sessions")
}

model Customer {
  id              String   @id @default(cuid())
  userId          String   @unique
  firstName       String?
  lastName        String?
  rfc             String?
  acceptsMarketing Boolean @default(false)
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt

  user      User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  addresses Address[]
  orders    Order[]

  @@map("customers")
}

model Address {
  id           String   @id @default(cuid())
  customerId   String
  label        String?
  fullName     String
  phone        String
  street       String
  exteriorNum  String?
  interiorNum  String?
  neighborhood String?
  city         String
  state        String
  postalCode   String
  country      String   @default("MX")
  references   String?
  isDefault    Boolean  @default(false)
  createdAt    DateTime @default(now())
  updatedAt    DateTime @updatedAt

  customer Customer @relation(fields: [customerId], references: [id], onDelete: Cascade)

  @@index([customerId])
  @@map("addresses")
}

// =====================================================
// CATÁLOGO
// =====================================================

enum ProductType {
  CHIP_FISICO
  ESIM
}

enum SaleMode {
  PREPAGO
  PORTABILIDAD
  NUEVA_LINEA
  RECARGA
}

model Category {
  id          String   @id @default(cuid())
  name        String
  slug        String   @unique
  description String?
  imageUrl    String?
  isActive    Boolean  @default(true)
  sortOrder   Int      @default(0)
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt

  products Product[]

  @@map("product_categories")
}

model Product {
  id              String      @id @default(cuid())
  sku             String      @unique
  name            String
  slug            String      @unique
  description     String      @db.Text
  shortDesc       String?
  type            ProductType
  saleMode        SaleMode
  carrier         String      @default("Telcel")
  price           Decimal     @db.Decimal(10, 2)
  comparePrice    Decimal?    @db.Decimal(10, 2)
  cost            Decimal?    @db.Decimal(10, 2)
  taxRate         Decimal     @default(0.16) @db.Decimal(5, 4)
  stock           Int         @default(0)
  lowStockAlert   Int         @default(5)
  isActive        Boolean     @default(true)
  isFeatured      Boolean     @default(false)
  metaTitle       String?
  metaDescription String?
  categoryId      String?
  createdAt       DateTime    @default(now())
  updatedAt       DateTime    @updatedAt

  category   Category?        @relation(fields: [categoryId], references: [id])
  images     ProductImage[]
  variants   ProductVariant[]
  esims      Esim[]
  orderItems OrderItem[]

  @@index([slug])
  @@index([type])
  @@index([categoryId])
  @@map("products")
}

model ProductImage {
  id        String   @id @default(cuid())
  productId String
  url       String
  alt       String?
  sortOrder Int      @default(0)
  isPrimary Boolean  @default(false)
  createdAt DateTime @default(now())

  product Product @relation(fields: [productId], references: [id], onDelete: Cascade)

  @@index([productId])
  @@map("product_images")
}

model ProductVariant {
  id         String   @id @default(cuid())
  productId  String
  name       String
  sku        String   @unique
  price      Decimal  @db.Decimal(10, 2)
  stock      Int      @default(0)
  attributes Json?
  isActive   Boolean  @default(true)
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt

  product    Product     @relation(fields: [productId], references: [id], onDelete: Cascade)
  orderItems OrderItem[]

  @@index([productId])
  @@map("product_variants")
}

// =====================================================
// INVENTARIO / eSIM
// =====================================================

enum EsimStatus {
  DISPONIBLE
  RESERVADA
  VENDIDA
  ENTREGADA
  CANCELADA
}

model Esim {
  id             String     @id @default(cuid())
  internalId     String     @unique
  iccid          String?    @unique
  activationCode String?
  qrCodeUrl      String?
  smdpAddress    String?
  matchingId     String?
  status         EsimStatus @default(DISPONIBLE)
  productId      String
  orderItemId    String?    @unique
  assignedAt     DateTime?
  soldAt         DateTime?
  deliveredAt    DateTime?
  notes          String?
  createdAt      DateTime   @default(now())
  updatedAt      DateTime   @updatedAt

  product   Product    @relation(fields: [productId], references: [id])
  orderItem OrderItem? @relation(fields: [orderItemId], references: [id])

  @@index([status])
  @@index([productId])
  @@map("esims")
}

// =====================================================
// PEDIDOS
// =====================================================

enum OrderStatus {
  PENDIENTE
  PAGO_PENDIENTE
  PAGO_APROBADO
  PAGO_RECHAZADO
  PREPARANDO
  ENVIADO
  ENTREGADO
  COMPLETADO
  CANCELADO
  REEMBOLSADO
}

enum PaymentStatus {
  PENDIENTE
  APROBADO
  RECHAZADO
  REEMBOLSADO
  CANCELADO
}

enum PaymentMethod {
  MERCADOPAGO
  STRIPE
  PAYPAL
  TRANSFERENCIA
  EFECTIVO
}

enum ShippingStatus {
  NO_APLICA
  PENDIENTE
  PREPARANDO
  ENVIADO
  EN_TRANSITO
  ENTREGADO
  DEVUELTO
}

model Order {
  id               String      @id @default(cuid())
  orderNumber      String      @unique
  customerId       String
  status           OrderStatus @default(PENDIENTE)
  subtotal         Decimal     @db.Decimal(10, 2)
  taxTotal         Decimal     @default(0) @db.Decimal(10, 2)
  shippingCost     Decimal     @default(0) @db.Decimal(10, 2)
  discountTotal    Decimal     @default(0) @db.Decimal(10, 2)
  total            Decimal     @db.Decimal(10, 2)
  currency         String      @default("MXN")
  couponId         String?
  customerNotes    String?
  adminNotes       String?
  requiresShipping Boolean     @default(false)
  createdAt        DateTime    @default(now())
  updatedAt        DateTime    @updatedAt

  customer    Customer     @relation(fields: [customerId], references: [id])
  coupon      Coupon?      @relation(fields: [couponId], references: [id])
  items       OrderItem[]
  payments    Payment[]
  shipment    Shipment?
  couponUsage CouponUsage?

  @@index([orderNumber])
  @@index([customerId])
  @@index([status])
  @@map("orders")
}

model OrderItem {
  id          String      @id @default(cuid())
  orderId     String
  productId   String
  variantId   String?
  productName String
  productType ProductType
  variantName String?
  quantity    Int
  unitPrice   Decimal     @db.Decimal(10, 2)
  totalPrice  Decimal     @db.Decimal(10, 2)
  createdAt   DateTime    @default(now())

  order   Order           @relation(fields: [orderId], references: [id], onDelete: Cascade)
  product Product         @relation(fields: [productId], references: [id])
  variant ProductVariant? @relation(fields: [variantId], references: [id])
  esim    Esim?

  @@index([orderId])
  @@map("order_items")
}

// =====================================================
// PAGOS
// =====================================================

model Payment {
  id             String        @id @default(cuid())
  orderId        String
  method         PaymentMethod
  status         PaymentStatus @default(PENDIENTE)
  amount         Decimal       @db.Decimal(10, 2)
  currency       String        @default("MXN")
  externalId     String?
  externalStatus String?
  paymentData    Json?
  paidAt         DateTime?
  createdAt      DateTime      @default(now())
  updatedAt      DateTime      @updatedAt

  order Order @relation(fields: [orderId], references: [id], onDelete: Cascade)

  @@index([orderId])
  @@index([externalId])
  @@map("payments")
}

// =====================================================
// ENVÍOS
// =====================================================

model Shipment {
  id             String         @id @default(cuid())
  orderId        String         @unique
  status         ShippingStatus @default(PENDIENTE)
  carrier        String?
  trackingNumber String?
  trackingUrl    String?
  recipientName  String?
  phone          String?
  street         String?
  city           String?
  state          String?
  postalCode     String?
  references     String?
  shippedAt      DateTime?
  deliveredAt    DateTime?
  createdAt      DateTime       @default(now())
  updatedAt      DateTime       @updatedAt

  order Order @relation(fields: [orderId], references: [id], onDelete: Cascade)

  @@map("shipments")
}

// =====================================================
// CUPONES
// =====================================================

enum DiscountType {
  PERCENTAGE
  FIXED
}

model Coupon {
  id           String       @id @default(cuid())
  code         String       @unique
  description  String?
  type         DiscountType
  value        Decimal      @db.Decimal(10, 2)
  minPurchase  Decimal?     @db.Decimal(10, 2)
  maxUses      Int?
  usedCount    Int          @default(0)
  perUserLimit Int          @default(1)
  startsAt     DateTime?
  expiresAt    DateTime?
  isActive     Boolean      @default(true)
  appliesToAll Boolean      @default(true)
  createdAt    DateTime     @default(now())
  updatedAt    DateTime     @updatedAt

  orders Order[]
  usages CouponUsage[]

  @@index([code])
  @@map("coupons")
}

model CouponUsage {
  id       String   @id @default(cuid())
  couponId String
  orderId  String   @unique
  userId   String?
  usedAt   DateTime @default(now())

  coupon Coupon @relation(fields: [couponId], references: [id])
  order  Order  @relation(fields: [orderId], references: [id], onDelete: Cascade)

  @@index([couponId])
  @@map("coupon_usage")
}

// =====================================================
// NOTIFICACIONES
// =====================================================

enum NotificationType {
  ORDER_CREATED
  PAYMENT_APPROVED
  PAYMENT_REJECTED
  ORDER_SHIPPED
  ORDER_DELIVERED
  ESIM_DELIVERED
  PASSWORD_RESET
  WELCOME
}

model Notification {
  id        String           @id @default(cuid())
  userId    String?
  orderId   String?
  type      NotificationType
  channel   String
  recipient String
  subject   String?
  body      String?          @db.Text
  sentAt    DateTime?
  error     String?
  createdAt DateTime         @default(now())

  @@index([userId])
  @@index([orderId])
  @@map("notifications")
}

// =====================================================
// ADMINISTRACIÓN
// =====================================================

model AdminActivityLog {
  id         String   @id @default(cuid())
  userId     String
  action     String
  entityType String?
  entityId   String?
  metadata   Json?
  ipAddress  String?
  userAgent  String?
  createdAt  DateTime @default(now())

  user User @relation(fields: [userId], references: [id])

  @@index([userId])
  @@index([createdAt])
  @@map("admin_activity_logs")
}

model Setting {
  id        String   @id @default(cuid())
  key       String   @unique
  value     String   @db.Text
  category  String   @default("general")
  updatedAt DateTime @updatedAt

  @@map("settings")
}

=== FILE: telcel-store/src/lib/prisma.ts ===
import { PrismaClient } from '@prisma/client';

const globalForPrisma = globalThis as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error']
  });

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;

=== FILE: telcel-store/src/lib/utils.ts ===
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function formatCurrency(amount: number | string, currency = 'MXN') {
  const value = typeof amount === 'string' ? parseFloat(amount) : amount;
  return new Intl.NumberFormat('es-MX', {
    style: 'currency',
    currency
  }).format(value);
}

export function generateOrderNumber() {
  const date = new Date();
  const y = date.getFullYear();
  const m = String(date.getMonth() + 1).padStart(2, '0');
  const d = String(date.getDate()).padStart(2, '0');
  const rand = Math.floor(Math.random() * 90000) + 10000;
  return `ORD-${y}${m}${d}-${rand}`;
}

export function slugify(text: string) {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

=== FILE: telcel-store/src/app/globals.css ===
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --font-inter: 'Inter', system-ui, sans-serif;
}

html, body {
  height: 100%;
}

body {
  @apply bg-slate-50 text-slate-900 antialiased;
}

.btn-primary {
  @apply inline-flex items-center justify-center rounded-lg bg-brand-600 px-5 py-3 font-semibold text-white transition hover:bg-brand-700 disabled:opacity-50;
}

.btn-secondary {
  @apply inline-flex items-center justify-center rounded-lg border border-slate-300 bg-white px-5 py-3 font-semibold text-slate-700 transition hover:bg-slate-50;
}

.card {
  @apply rounded-xl border border-slate-200 bg-white p-6 shadow-sm;
}

.input {
  @apply w-full rounded-lg border border-slate-300 px-4 py-3 text-sm focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-100;
}

=== FILE: telcel-store/src/app/layout.tsx ===
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' });

export const metadata: Metadata = {
  title: {
    default: process.env.NEXT_PUBLIC_STORE_NAME || 'Mi Tienda SIM',
    template: `%s | ${process.env.NEXT_PUBLIC_STORE_NAME || 'Mi Tienda SIM'}`
  },
  description: 'Compra chips físicos y eSIM de Telcel en México. Envío rápido y activación guiada.'
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es-MX" className={inter.variable}>
      <body>{children}</body>
    </html>
  );
}

=== FILE: telcel-store/src/app/page.tsx ===
export default function HomePage() {
  return (
    <main className="mx-auto max-w-6xl px-4 py-16">
      <h1 className="text-4xl font-bold text-slate-900">
        {process.env.NEXT_PUBLIC_STORE_NAME || 'Mi Tienda SIM'}
      </h1>
      <p className="mt-4 text-lg text-slate-600">
        Fase 1 lista. Base de datos, estructura y configuración inicial funcionando.
      </p>
    </main>
  );
}

=== FILE: telcel-store/README.md ===
# Mi Tienda SIM — Tienda online de chips y eSIM Telcel

Proyecto de e-commerce construido con Next.js 14, TypeScript, Prisma y PostgreSQL.

## 🚀 Fase 1 — Setup inicial

### Requisitos

- Node.js 18+
- Docker (para PostgreSQL local)
- npm o pnpm

### Instalación

```bash
# 1. Copiar variables de entorno
cp .env.example .env

# 2. Levantar PostgreSQL
docker compose up -d

# 3. Instalar dependencias
npm install

# 4. Generar cliente Prisma y crear tablas
npx prisma generate
npx prisma migrate dev --name init

# 5. Arrancar
npm run dev
```

Abre http://localhost:3000

### Comandos útiles

```bash
npm run dev           # Desarrollo
npm run build         # Build producción
npx prisma studio     # Ver base de datos en http://localhost:5555
docker compose down   # Apagar PostgreSQL
```

## 🗺 Roadmap

- [x] Fase 1: Estructura + Base de datos
- [ ] Fase 2: Backend + Autenticación
- [ ] Fase 3: Frontend público (tienda, carrito, checkout)
- [ ] Fase 4: Panel administrativo
- [ ] Fase 5: Pagos + Entrega de eSIM
- [ ] Fase 6: Correos, WhatsApp, SEO, Seguridad

## ⚠️ Aviso legal

Este proyecto es una tienda independiente. No está afiliada oficialmente a Telcel ni a América Móvil. Todos los productos deben comercializarse conforme a la legislación aplicable en México.
===== FIN =====
```

---

## 🛠 Script para convertir `fase1.txt` en archivos reales + ZIP

### Linux / macOS / Git Bash

Guarda este script como `unpack.sh`, en la **misma carpeta** donde tengas `fase1.txt`:

```bash
#!/bin/bash
set -e

INPUT="fase1.txt"
[ ! -f "$INPUT" ] && { echo "❌ No se encontró $INPUT"; exit 1; }

awk '
  /^=== FILE: / {
    file=$3;
    sub(/^=== FILE: /, "");
    sub(/ ===$/, "");
    system("mkdir -p \"$(dirname \"" file "\")\"");
    out=file;
    next
  }
  /^===== (INICIO|FIN) =====$/ { next }
  { if (out != "") print > out }
' "$INPUT"

echo "✅ Archivos extraídos"
echo "📦 Generando ZIP..."

if [ -d "telcel-store" ]; then
  zip -r telcel-store.zip telcel-store -x "*/node_modules/*" "telcel-store/.next/*"
  echo "✅ ZIP generado: telcel-store.zip"
else
  echo "❌ No se creó la carpeta telcel-store. Revisa el archivo fase1.txt"
fi
```

Ejecuta:

```bash
chmod +x unpack.sh
./unpack.sh
```

### Windows — PowerShell

Guarda como `unpack.ps1`:

```powershell
$inputFile = "fase1.txt"
if (-not (Test-Path $inputFile)) {
    Write-Host "❌ No se encontró $inputFile"
    exit 1
}

$lines = Get-Content $inputFile
$currentFile = $null
$buffer = @()

foreach ($line in $lines) {
    if ($line -match '^=== FILE: (.+) ===$') {
        if ($currentFile) {
            $dir = Split-Path $currentFile -Parent
            if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
            $buffer -join "`n" | Set-Content -Path $currentFile -Encoding UTF8
        }
        $currentFile = $matches[1].Trim()
        $buffer = @()
    }
    elseif ($line -match '^===== (INICIO|FIN) =====$') {
        continue
    }
    else {
        $buffer += $line
    }
}

if ($currentFile) {
    $dir = Split-Path $currentFile -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $buffer -join "`n" | Set-Content -Path $currentFile -Encoding UTF8
}

Write-Host "✅ Archivos extraídos"
Compress-Archive -Path ".\telcel-store" -DestinationPath ".\telcel-store.zip" -Force
Write-Host "✅ ZIP generado: telcel-store.zip"
```

Ejecuta (en PowerShell, dentro de la carpeta donde pusiste `fase1.txt`):

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\unpack.ps1
```

---

## ✅ Resultado esperado

Después de correr el script tendrás:

```
telcel-store/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
├── next.config.js
├── postcss.config.js
├── tailwind.config.ts
├── README.md
├── prisma/
│   └── schema.prisma
└── src/
    ├── app/
    │   ├── globals.css
    │   ├── layout.tsx
    │   └── page.tsx
    └── lib/
        ├── prisma.ts
        └── utils.ts

telcel-store.zip   ← tu ZIP listo
```

---

## 👉 Siguientes pasos

1. Ejecuta el script.
2. Sigue el `README.md` para levantar el proyecto.
3. Verifica que `npx prisma migrate dev --name init` te cree las tablas sin errores.

Cuando confirmes que la **Fase 1 quedó funcionando**, dime:

> **"fase 2"**

Y te entrego el **bloque único de la Fase 2** (Backend + Autenticación con NextAuth, registro, login, middleware de protección, validaciones Zod). Igual con separadores `=== FILE: ... ===` para que lo desempaquetes con el mismo script. 🚀

¿Algún error al desempaquetar o al hacer `migrate`? Avísame y lo resolvemos antes de seguir.
