import React, { useState, useEffect } from 'react';
import './App.css';
import axios from 'axios';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

function App() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [apiInfo, setApiInfo] = useState(null);
  const [healthStatus, setHealthStatus] = useState(null);
  const [newUser, setNewUser] = useState({ name: '', email: '' });

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      
      const [usersRes, infoRes, healthRes] = await Promise.allSettled([
        axios.get(`${API_BASE_URL}/api/users`),
        axios.get(`${API_BASE_URL}/api/info`),
        axios.get(`${API_BASE_URL}/health`)
      ]);

      if (usersRes.status === 'fulfilled') {
        setUsers(usersRes.value.data.data || []);
      }
      
      if (infoRes.status === 'fulfilled') {
        setApiInfo(infoRes.value.data);
      }
      
      if (healthRes.status === 'fulfilled') {
        setHealthStatus(healthRes.value.data);
      }

      setError(null);
    } catch (err) {
      setError('Failed to connect to backend API');
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!newUser.name || !newUser.email) return;

    try {
      const response = await axios.post(`${API_BASE_URL}/api/users`, newUser);
      if (response.data.success) {
        setUsers([response.data.data, ...users]);
        setNewUser({ name: '', email: '' });
      }
    } catch (err) {
      alert('Failed to create user');
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>🚀 Azure Terraform Portfolio</h1>
        <p>Demonstrating Cloud Engineering with Modern DevOps Practices</p>
      </header>

      <main className="container">
        <section className="status-section">
          <h2>📊 System Status</h2>
          <div className="status-cards">
            <div className="status-card">
              <h3>🔗 API Connection</h3>
              <div className={`status ${error ? 'error' : 'success'}`}>
                {error ? '❌ Disconnected' : '✅ Connected'}
              </div>
            </div>
            
            {healthStatus && (
              <div className="status-card">
                <h3>💚 Health</h3>
                <div className="status success">✅ {healthStatus.status}</div>
                <small>Uptime: {Math.round(healthStatus.uptime)}s</small>
              </div>
            )}

            <div className="status-card">
              <h3>📊 Database</h3>
              <div className="status success">✅ PostgreSQL</div>
              <small>{users.length} users</small>
            </div>
          </div>
        </section>

        {apiInfo && (
          <section className="tech-section">
            <h2>🛠️ Technology Stack</h2>
            <div className="tech-grid">
              <div className="tech-card">
                <h4>☁️ Infrastructure</h4>
                <ul>
                  <li>{apiInfo.infrastructure.platform}</li>
                  <li>{apiInfo.infrastructure.container_service}</li>
                  <li>{apiInfo.infrastructure.database}</li>
                  <li>{apiInfo.infrastructure.iac}</li>
                </ul>
              </div>
              
              <div className="tech-card">
                <h4>🚀 Technologies</h4>
                <ul>
                  {apiInfo.technologies.map((tech, index) => (
                    <li key={index}>{tech}</li>
                  ))}
                </ul>
              </div>
            </div>
          </section>
        )}

        <section className="demo-section">
          <h2>👥 User Management Demo</h2>
          
          <div className="form-card">
            <h3>Add New User</h3>
            <form onSubmit={handleSubmit}>
              <input
                type="text"
                placeholder="Full Name"
                value={newUser.name}
                onChange={(e) => setNewUser({...newUser, name: e.target.value})}
                required
              />
              <input
                type="email"
                placeholder="Email Address"
                value={newUser.email}
                onChange={(e) => setNewUser({...newUser, email: e.target.value})}
                required
              />
              <button type="submit">Add User</button>
            </form>
          </div>

          <div className="users-section">
            <h3>Users ({users.length})</h3>
            {loading ? (
              <div>Loading...</div>
            ) : error ? (
              <div className="error">
                <p>{error}</p>
                <button onClick={fetchData}>Retry</button>
              </div>
            ) : (
              <div className="users-grid">
                {users.map((user) => (
                  <div key={user.id} className="user-card">
                    <h4>{user.name}</h4>
                    <p>{user.email}</p>
                    <small>{new Date(user.created_at).toLocaleDateString()}</small>
                  </div>
                ))}
              </div>
            )}
          </div>
        </section>
      </main>
    </div>
  );
}

export default App;