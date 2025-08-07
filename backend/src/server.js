const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Database connection
const pool = new Pool({
  host: process.env.DB_HOST,
  database: process.env.DB_NAME || 'portfoliodb',
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  port: 5432,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
});

// Test database connection on startup
async function testDbConnection() {
  try {
    const client = await pool.connect();
    console.log('✅ Database connected successfully');
    
    // Create users table if it doesn't exist
    await client.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    
    // Insert sample data if table is empty
    const { rows } = await client.query('SELECT COUNT(*) FROM users');
    if (parseInt(rows[0].count) === 0) {
      await client.query(`
        INSERT INTO users (name, email) VALUES 
        ('John Doe', 'john@example.com'),
        ('Jane Smith', 'jane@example.com'),
        ('Cloud Engineer', 'engineer@example.com')
      `);
      console.log('✅ Sample data inserted');
    }
    
    client.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
  }
}

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'Portfolio Backend API',
    version: '1.0.0',
    status: 'healthy',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
    memory: process.memoryUsage(),
    database: 'connected'
  });
});

// Users API endpoints
app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users ORDER BY created_at DESC');
    res.json({
      success: true,
      data: result.rows,
      count: result.rows.length
    });
  } catch (err) {
    console.error('Error fetching users:', err);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch users',
      message: err.message
    });
  }
});

app.post('/api/users', async (req, res) => {
  try {
    const { name, email } = req.body;
    
    if (!name || !email) {
      return res.status(400).json({
        success: false,
        error: 'Name and email are required'
      });
    }
    
    const result = await pool.query(
      'INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *',
      [name, email]
    );
    
    res.status(201).json({
      success: true,
      data: result.rows[0],
      message: 'User created successfully'
    });
  } catch (err) {
    console.error('Error creating user:', err);
    
    if (err.code === '23505') {
      return res.status(409).json({
        success: false,
        error: 'Email already exists'
      });
    }
    
    res.status(500).json({
      success: false,
      error: 'Failed to create user',
      message: err.message
    });
  }
});

// Demo endpoint
app.get('/api/info', (req, res) => {
  res.json({
    project: 'Azure Terraform Portfolio',
    technologies: [
      'Azure Container Instances',
      'Terraform',
      'PostgreSQL',
      'Node.js',
      'Docker'
    ],
    infrastructure: {
      platform: 'Microsoft Azure',
      container_service: 'Azure Container Instances',
      database: 'PostgreSQL Flexible Server',
      networking: 'Virtual Network with Subnets',
      iac: 'Terraform'
    }
  });
});

// Start server
app.listen(PORT, '0.0.0.0', async () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
  await testDbConnection();
});

module.exports = app;