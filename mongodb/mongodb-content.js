// Connect to MongoDB
print ( "starting roles script" )
conn = new Mongo();

spicedb = conn.getDB("spice");
spicedb.auth('spice-admin', 'DATAHUB1234567890');

// 1. CREATE COLLECTIONS
spicedb.createCollection('spice_rdfjobs2')
spicedb.createCollection('spice_policies')
spicedb.createCollection('spice_policies_requests')
spicedb.createCollection('spice_notifications')
spicedb.createCollection('spice_activity_log')


// 2. CREATE ROLES
spicedb.createRole(
    {
        role: "spice_activity_log-R", 
        privileges: [
          {
            actions: [ "find" ],
            resource: { db: "spice", collection: "spice_activity_log" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_activity_log-W", 
        privileges: [
          {
            actions: [ "update", "insert", "remove" ],
            resource: { db: "spice", collection: "spice_activity_log" }
          }
        ],
        roles: []
      }
)
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
spicedb.createRole(
    {
        role: "spice_policies-R", 
        privileges: [
          {
            actions: [ "find" ],
            resource: { db: "spice", collection: "spice_policies" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_policies-W", 
        privileges: [
          {
            actions: [ "update", "insert", "remove" ],
            resource: { db: "spice", collection: "spice_policies" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_policies_requests-R", 
        privileges: [
          {
            actions: [ "find" ],
            resource: { db: "spice", collection: "spice_policies_requests" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_policies_requests-W", 
        privileges: [
          {
            actions: [ "update", "insert", "remove" ],
            resource: { db: "spice", collection: "spice_policies_requests" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_notifications-R", 
        privileges: [
          {
            actions: [ "find" ],
            resource: { db: "spice", collection: "spice_notifications" }
          }
        ],
        roles: []
      }
)
spicedb.createRole(
    {
        role: "spice_notifications-W", 
        privileges: [
          {
            actions: [ "update", "insert", "remove" ],
            resource: { db: "spice", collection: "spice_notifications" }
          }
        ],
        roles: []
      }
)

// 3. CREATE USERS
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

spicedb.createUser({
  user: 'policieskey012',
  pwd: 'policieskey012',
  roles: [
    {
      role: 'spice_policies-R',
      db: 'spice'
    },
    {
      role: 'spice_policies-W',
      db: 'spice'
    },
    {
      role: 'spice_policies_requests-R',
      db: 'spice'
    },
    {
      role: 'spice_policies_requests-W',
      db: 'spice'
    }
  ],
});

spicedb.createUser({
  user: 'notificationskey023',
  pwd: 'notificationskey023',
  roles: [
    {
      role: 'spice_notifications-R',
      db: 'spice'
    },
    {
      role: 'spice_notifications-W',
      db: 'spice'
    }
  ],
});

spicedb.createUser({
  user: 'activityreadkey220',
  pwd: 'activityreadkey220',
  roles: [
    {
      role: 'spice_activity_log-R',
      db: 'spice'
    },
  ],
});

print ( "completed roles script" )