Content-Type: multipart/mixed; boundary="===============8694221730480278668=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 1/4] simfs: Added support for ISim file systems
Date: Wed, 08 Nov 2017 09:23:50 -0800
Message-ID: <1510161833-8867-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8694221730480278668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simfilesystem.cpp | 100 +++++++++++++++++++++++++++++++++++++++-------=
----
 src/simfilesystem.h   |  11 +++++-
 2 files changed, 89 insertions(+), 22 deletions(-)

diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index a23d0a0..0e5c2a9 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -133,7 +133,20 @@ static SimFileInfo const knownFiles[] =3D
     {0,             0,          0,             0,         FILE_TYPE_TRANSP=
ARENT}
 };
 =

-SimFileSystem::SimFileSystem( SimRules *rules, SimXmlNode& e )
+static SimFileInfo const isimFiles[] =3D
+{
+    // TS 31.103
+    {"6F02",        0,     "EFimpi",        0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6F03",        0,     "EFdomain",      0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6FAD",        0,     "EFad",          0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6F06",        0,     "EFarr",         0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6F07",        0,     "EFist",         0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6F09",        0,     "EFpcscf",       0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {"6FD5",        0,     "EFgbabp",       0x14ff44,  FILE_TYPE_TRANSPARE=
NT},
+    {0,             0,          0,             0,         FILE_TYPE_TRANSP=
ARENT}
+};
+
+SimFileSystem::SimFileSystem( SimRules *rules, SimXmlNode& e, enum file_sy=
stem_type fstype )
     : QObject( rules )
 {
     this->rules =3D rules;
@@ -141,7 +154,12 @@ SimFileSystem::SimFileSystem( SimRules *rules, SimXmlN=
ode& e )
     currentItem =3D rootItem;
 =

     // Create all of the standard directories.
-    const SimFileInfo *info =3D knownFiles;
+    const SimFileInfo *info;
+    if (fstype =3D=3D FILE_SYSTEM_TYPE_ISIM) {
+        info =3D isimFiles;
+    } else {
+        info =3D knownFiles;
+    }
     SimFileItem *dirItem =3D 0;
     while ( info->fileid ) {
         QString fileid =3D info->fileid;
@@ -162,20 +180,33 @@ SimFileSystem::SimFileSystem( SimRules *rules, SimXml=
Node& e )
             QString fileid =3D resolveFileId( name );
             int access =3D findItemAccess( name );
             enum file_type type =3D findItemFileType( name );
-            SimFileItem *parent =3D findItemParent( fileid );
-            if ( parent ) {
-                SimFileItem *item;
-                item =3D findItem( fileid.right(4) );
-                if ( !item )
-                    item =3D new SimFileItem( fileid.right(4), parent, acc=
ess, type );
-                else
-                    qDebug() << "File" << name << "defined multiple times";
-                item->setContents( data );
-                QString size =3D child->getAttribute( "recordsize" );
-                if ( !size.isEmpty() )
-                    item->setRecordSize( size.toInt() );
+
+            if ( fstype =3D=3D FILE_SYSTEM_TYPE_DEFAULT) {
+                SimFileItem *parent =3D findItemParent( fileid );
+                if ( parent ) {
+                    SimFileItem *item;
+                    item =3D findItem( fileid.right(4) );
+                    if ( !item )
+                        item =3D new SimFileItem( fileid.right(4), parent,=
 access, type );
+                    else
+                        qDebug() << "File" << name << "defined multiple ti=
mes";
+                    item->setContents( data );
+                    QString size =3D child->getAttribute( "recordsize" );
+                    if ( !size.isEmpty() )
+                        item->setRecordSize( size.toInt() );
+                } else {
+                    qDebug() << "Could not find parent for" << name;
+                }
             } else {
-                qDebug() << "Could not find parent for" << name;
+                /*
+                 * ISIM files wont have a parent dir set, so they are hand=
led
+                 * differently.
+                 */
+                QString name =3D child->getAttribute( "name" );
+                QByteArray data =3D QAtUtils::fromHex( child->contents );
+                QString fileid =3D resolveISimFileId( name );
+                SimFileItem *item =3D new SimFileItem( fileid.right(4), ro=
otItem, access, type);
+                item->setContents( data );
             }
         } else {
             qDebug() << "Unknown filesystem command <" << child->tag << ">=
";
@@ -184,7 +215,8 @@ SimFileSystem::SimFileSystem( SimRules *rules, SimXmlNo=
de& e )
     }
 =

     /* Select DFgsm initially */
-    currentItem =3D findItem("7F20");
+    if ( fstype =3D=3D FILE_SYSTEM_TYPE_DEFAULT )
+        currentItem =3D findItem("7F20");
 }
 =

 SimFileSystem::~SimFileSystem()
@@ -192,7 +224,7 @@ SimFileSystem::~SimFileSystem()
     delete rootItem;
 }
 =

-void SimFileSystem::crsm( const QString& args )
+bool SimFileSystem::fileAccess( const QString& args, QString& resp )
 {
     // Extract the arguments to the command.
     uint posn =3D 0;
@@ -428,13 +460,26 @@ void SimFileSystem::crsm( const QString& args )
 =

     // Send the response information.
     if ( sw1 !=3D 0 ) {
-        QString resp;
-        resp =3D "+CRSM: " + QString::number(sw1) + "," + QString::number(=
sw2);
+        resp =3D QString::number(sw1) + "," + QString::number(sw2);
         if ( !response.isEmpty() )
             resp +=3D "," + response;
-        rules->respond( resp );
     }
-    if ( ok )
+
+    return ok;
+}
+
+void SimFileSystem::crsm( const QString& args )
+{
+    bool ok;
+    QString crsm =3D "+CRSM: ";
+    QString resp;
+    ok =3D fileAccess( args, resp );
+
+    crsm +=3D resp;
+
+    rules->respond( crsm );
+
+    if (ok)
         rules->respond( "OK" );
     else
         rules->respond( "ERROR" );
@@ -526,6 +571,19 @@ QString SimFileSystem::resolveFileId( const QString& _=
fileid ) const
     }
 }
 =

+QString SimFileSystem::resolveISimFileId( const QString& name ) const
+{
+    const SimFileInfo *info =3D (const SimFileInfo *)isimFiles;
+    while ( info->fileid ) {
+        if ( name =3D=3D info->name ) {
+            QString fileid =3D info->fileid;
+            return fileid;
+        }
+        ++info;
+    }
+    return QString("");
+}
+
 int SimFileSystem::findItemAccess( const QString& _fileid ) const
 {
     QString fileid =3D _fileid;
diff --git a/src/simfilesystem.h b/src/simfilesystem.h
index 150416f..477c6c7 100644
--- a/src/simfilesystem.h
+++ b/src/simfilesystem.h
@@ -24,6 +24,11 @@
 =

 class SimFileItem;
 =

+enum file_system_type {
+    FILE_SYSTEM_TYPE_DEFAULT,
+    FILE_SYSTEM_TYPE_ISIM
+};
+
 enum file_type {
     FILE_TYPE_TRANSPARENT =3D 0,
     FILE_TYPE_LINEAR_FIXED =3D 1,
@@ -52,12 +57,14 @@ class SimFileSystem : public QObject
 {
     Q_OBJECT
 public:
-    SimFileSystem( SimRules *rules, SimXmlNode& e );
+    SimFileSystem( SimRules *rules, SimXmlNode& e, enum file_system_type t=
ype =3D FILE_SYSTEM_TYPE_DEFAULT );
     ~SimFileSystem();
 =

     // Execute an AT+CRSM command against the filesystem.
     void crsm( const QString& args );
 =

+    bool fileAccess( const QString& args, QString& resp );
+
     // Find an item with a specific id.
     SimFileItem *findItem( const QString& fileid ) const;
 =

@@ -77,6 +84,8 @@ public:
     // Resolve a file identifier to its full path from the root directory.
     QString resolveFileId( const QString& fileid ) const;
 =

+    QString resolveISimFileId( const QString& _fileid ) const;
+
 private:
     SimRules *rules;
     SimFileItem *rootItem;
-- =

2.7.4


--===============8694221730480278668==--

