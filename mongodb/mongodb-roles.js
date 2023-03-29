// Connect to MongoDB
print ( "starting roles script" )
conn = new Mongo();

spicedb = conn.getDB("spice");
spicedb.auth('spice-admin', 'DATAHUB1234567890');

// 'spice_rdfjobs2' 'rdfjobskey012'
// 1. CREATE COLLECTION
spicedb.createCollection('spice_rdfjobs2')
// 2. CREATE ROLE
spicedb.createRole(
    {
        role: "spice_rdfjobs2-R", 
        privileges: [
          {
            actions: [ "find" ],
            resource: { db: "spice", collection: "spice_rdfjobs2" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_rdfjobs2-W", 
        privileges: [
          {
            actions: [ "update", "insert", "remove" ],
            resource: { db: "spice", collection: "spice_rdfjobs2" }
          }
        ],
        roles: []
      }
)
// 3. CREATE USER
spicedb.createUser({
  user: 'rdfjobskey012',
  pwd: 'rdfjobskey012',
  roles: [
    {
      role: 'spice_rdfjobs2-R',
      db: 'spice'
    },
    {
      role: 'spice_rdfjobs2-W',
      db: 'spice'
    }
  ],
});
// 4. ASSIGN ROLE
//# # 'spice_policies' 'policieskey012'
//# # 'spice_policies_requests' 'policieskey012'
//# # 'spice_notifications' 'notificationskey023'
print ( "completed roles script" )