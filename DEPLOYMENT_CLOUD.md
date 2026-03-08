# Full-Stack Deployment Guide for ArogyaMitra

## ⚠️ Important: GitHub Pages Limitation

**GitHub Pages does NOT support backend servers.** You cannot deploy the full ArogyaMitra application (FastAPI backend + React frontend) on GitHub Pages alone.

## 🚀 Recommended: Free Full-Stack Deployment

### Option 1: Render (Easiest)

#### Backend Deployment:
1. Sign up at https://render.com
2. Click **New +** → **Web Service**
3. Connect GitHub repository: `atharv348/Arogyamitra`
4. Configure:
   ```
   Name: arogyamitra-backend
   Root Directory: backend
   Environment: Python 3
   Build Command: pip install -r requirements.txt
   Start Command: uvicorn main:app --host 0.0.0.0 --port $PORT
   ```
5. Add Environment Variables:
   ```
   GROQ_API_KEY=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
   SECRET_KEY=arogyamitra-secret-key-production
   DATABASE_URL=sqlite:///./arogyamitra.db
   ```
6. Click **Create Web Service**
7. Your backend URL: `https://arogyamitra-backend.onrender.com`

#### Frontend Deployment:
1. Click **New +** → **Static Site**
2. Connect same repository
3. Configure:
   ```
   Name: arogyamitra
   Root Directory: frontend
   Build Command: npm install && npm run build
   Publish Directory: dist
   ```
4. Add Environment Variable:
   ```
   VITE_API_URL=https://arogyamitra-backend.onrender.com
   ```
5. Update `frontend/src/services/api.ts`:
   ```typescript
   const api = axios.create({
     baseURL: import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000',
   });
   ```
6. Your frontend URL: `https://arogyamitra.onrender.com`

---

### Option 2: Railway

1. Sign up at https://railway.app
2. Click **New Project** → **Deploy from GitHub repo**
3. Select `atharv348/Arogyamitra`
4. Railway will auto-detect both services
5. Add environment variables in Railway dashboard
6. Deploy!

---

### Option 3: Vercel (Frontend) + Render (Backend)

**Backend on Render** (same as Option 1 above)

**Frontend on Vercel:**
1. Sign up at https://vercel.com
2. Import GitHub repository
3. Configure:
   ```
   Framework Preset: Vite
   Root Directory: frontend
   Build Command: npm run build
   Output Directory: dist
   ```
4. Add environment variable:
   ```
   VITE_API_URL=https://arogyamitra-backend.onrender.com
   ```
5. Deploy!

---

## 🔧 Update API Base URL

Before deploying, update `frontend/src/services/api.ts`:

```typescript
import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000',
});

// Rest of the code remains same...
```

Add to `frontend/.env.production`:
```
VITE_API_URL=https://your-backend-url.onrender.com
```

---

## ⚡ Quick Deploy Commands

### For Render Backend:
```bash
# It uses these automatically:
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port $PORT
```

### For Frontend Build:
```bash
cd frontend
npm install
npm run build
# Output in: frontend/dist
```

---

## 🎯 After Deployment

1. Update CORS in `backend/main.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "https://arogyamitra.onrender.com",  # Your frontend URL
        "http://localhost:5173",
        "http://127.0.0.1:5173"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

2. Test your deployed app!

---

## 💰 Cost

- **Render Free Tier:** ✅ Free (server sleeps after 15 min inactivity)
- **Railway Free Tier:** ✅ $5 free credit monthly
- **Vercel Free Tier:** ✅ Free

---

## 📝 Note

For **project submission**, mention the deployment URLs:
- Backend: `https://your-backend.onrender.com`
- Frontend: `https://your-frontend.onrender.com` (or vercel)
- GitHub: https://github.com/atharv348/Arogyamitra

Or provide local setup instructions (already in README.md).
