#!/usr/bin/env python3
"""
ArogyaMitra Setup Checker
This script checks if your project is configured correctly
"""

import os
import sys
from pathlib import Path

def check_env_file():
    """Check if .env file exists and has required keys"""
    env_path = Path(__file__).parent / "backend" / ".env"
    
    print("🔍 Checking .env file...")
    if not env_path.exists():
        print("❌ .env file not found in backend folder!")
        print("   Create backend/.env with your GROQ_API_KEY")
        return False
    
    print("✅ .env file exists")
    
    # Check if GROQ_API_KEY is set
    with open(env_path, 'r') as f:
        content = f.read()
        if "GROQ_API_KEY" not in content:
            print("❌ GROQ_API_KEY not found in .env file")
            return False
        if "your-groq-api-key-here" in content:
            print("⚠️  GROQ_API_KEY is still set to placeholder value")
            print("   Get your key from: https://console.groq.com/")
            return False
    
    print("✅ GROQ_API_KEY is configured")
    return True

def check_dependencies():
    """Check if required packages are installed"""
    print("\n🔍 Checking Python dependencies...")
    
    required_packages = [
        'fastapi',
        'uvicorn',
        'groq',
        'sqlalchemy',
        'python-jose',
        'passlib'
    ]
    
    missing = []
    for package in required_packages:
        try:
            __import__(package.replace('-', '_'))
            print(f"✅ {package}")
        except ImportError:
            print(f"❌ {package} not installed")
            missing.append(package)
    
    if missing:
        print("\n⚠️  Install missing packages:")
        print(f"   cd backend && pip install -r requirements.txt")
        return False
    
    return True

def check_groq_connection():
    """Test Groq API connection"""
    print("\n🔍 Testing Groq API connection...")
    
    try:
        from dotenv import load_dotenv
        load_dotenv("backend/.env")
        
        api_key = os.getenv("GROQ_API_KEY")
        if not api_key or api_key == "your-groq-api-key-here":
            print("❌ GROQ_API_KEY not properly set")
            return False
        
        from groq import Groq
        client = Groq(api_key=api_key)
        
        # Test with a simple request
        response = client.chat.completions.create(
            messages=[{"role": "user", "content": "Hi"}],
            model="llama-3.3-70b-versatile",
            max_tokens=10
        )
        
        print("✅ Groq API connection successful!")
        print(f"   Response: {response.choices[0].message.content[:50]}...")
        return True
        
    except Exception as e:
        print(f"❌ Groq API connection failed: {str(e)}")
        print("   Check your API key at: https://console.groq.com/")
        return False

def main():
    print("=" * 60)
    print("    ArogyaMitra Setup Checker")
    print("=" * 60)
    print()
    
    checks = [
        check_env_file(),
        check_dependencies(),
        check_groq_connection()
    ]
    
    print("\n" + "=" * 60)
    if all(checks):
        print("✅ All checks passed! You're ready to run:")
        print("   .\\run aromi")
    else:
        print("⚠️  Some checks failed. Please fix the issues above.")
    print("=" * 60)

if __name__ == "__main__":
    main()
