// Connect to MongoDB
print ( "starting init script" )
conn = new Mongo();

// Create a database instance
db = conn.getDB("admin");

db.auth('admin', 'MONGO1234567890');

db = conn.getDB("spice");

db.createUser({
  user: 'spice-admin',
  pwd: 'DATAHUB1234567890',
  roles: [
    {
      role: 'dbOwner',
      db: 'spice',
    },
  ],
});

print ( "completed init script" )
