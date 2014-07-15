Content-Type: multipart/mixed; boundary="===============1834203632375031682=="
MIME-Version: 1.0
From: Alban Crequy <alban.crequy@collabora.co.uk>
Subject: [PATCH] g_dbus_add_service_watch: better match rule for
 NameOwnerChanged
Date: Tue, 15 Jul 2014 11:29:41 +0100
Message-ID: <1405420181-9375-1-git-send-email-alban.crequy@collabora.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1834203632375031682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When subscribing to the D-Bus signal NameOwnerChanged from the bus driver,
specify the object path and the sender in the match rule. Otherwise, random
connections on the bus could impersonate the bus driver.

This patch applies to connman, ofono and pacrunner.
---
 gdbus/watch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 0f99f4f..415e7fa 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -699,7 +699,8 @@ guint g_dbus_add_service_watch(DBusConnection *connecti=
on, const char *name,
 	if (name =3D=3D NULL)
 		return 0;
 =

-	data =3D filter_data_get(connection, service_filter, NULL, NULL,
+	data =3D filter_data_get(connection, service_filter,
+				DBUS_SERVICE_DBUS, DBUS_PATH_DBUS,
 				DBUS_INTERFACE_DBUS, "NameOwnerChanged",
 				name);
 	if (data =3D=3D NULL)
-- =

1.8.5.3


--===============1834203632375031682==--

