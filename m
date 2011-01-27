Content-Type: multipart/mixed; boundary="===============8755436542922555946=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] bluetooth: only use bluetooth_refcount in
 bluetooth_ref/bluetooth_unref
Date: Thu, 27 Jan 2011 16:05:37 +0100
Message-ID: <1296140740-11486-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1296140740-11486-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8755436542922555946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 93dd7a1..e59bd31 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -505,7 +505,7 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-static void bluetooth_ref(void)
+static int bluetooth_ref(void)
 {
 	if (bluetooth_refcount > 0)
 		goto increment;
@@ -544,13 +544,15 @@ static void bluetooth_ref(void)
 increment:
 	g_atomic_int_inc(&bluetooth_refcount);
 =

-	return;
+	return 0;
 =

 remove:
 	g_dbus_remove_watch(connection, bluetooth_watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
 	g_dbus_remove_watch(connection, property_watch);
+
+	return -EIO;
 }
 =

 static void bluetooth_unref(void)
@@ -569,10 +571,12 @@ static void bluetooth_unref(void)
 =

 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
-	bluetooth_ref();
+	int err;
+
+	err =3D bluetooth_ref();
 =

-	if (bluetooth_refcount =3D=3D 0)
-		return -EIO;
+	if (err !=3D 0)
+		return err;
 =

 	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
 =

-- =

1.7.1


--===============8755436542922555946==--

