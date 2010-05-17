Content-Type: multipart/mixed; boundary="===============9175605203767990993=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 4/6] Move create_path() to bluetooth plugin
Date: Sun, 16 May 2010 23:11:37 -0300
Message-ID: <1274062299-4938-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274062299-4938-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9175605203767990993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   22 ++++++++++++++++++++++
 plugins/bluetooth.h |    1 +
 plugins/hfp.c       |   25 +------------------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index fc89579..49d1b5e 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -40,6 +40,28 @@ static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 =

+void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,=
 char *buf, int size)
+{
+	int i, j;
+
+	for (i =3D 0, j =3D 0; adapter_addr[j] && i < size - 1; j++)
+		if (adapter_addr[j] >=3D '0' && adapter_addr[j] <=3D '9')
+			buf[i++] =3D adapter_addr[j];
+		else if (adapter_addr[j] >=3D 'A' && adapter_addr[j] <=3D 'F')
+			buf[i++] =3D adapter_addr[j];
+
+	if (i < size - 1)
+		buf[i++] =3D '_';
+
+	for (j =3D 0; dev_addr[j] && i < size - 1; j++)
+		if (dev_addr[j] >=3D '0' && dev_addr[j] <=3D '9')
+			buf[i++] =3D dev_addr[j];
+		else if (dev_addr[j] >=3D 'A' && dev_addr[j] <=3D 'F')
+			buf[i++] =3D dev_addr[j];
+
+	buf[i] =3D '\0';
+}
+
 static int send_method_call_with_reply(const char *dest, const char *path,
 				const char *interface, const char *method,
 				DBusPendingCallNotifyFunction cb,
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 99bd617..4019daa 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -43,5 +43,6 @@ struct bluetooth_profile {
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

+void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,=
 char *buf, int size);
 =

 #endif /* __BLUETOOTH_H */
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 6fd3464..c2b3711 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -448,29 +448,6 @@ static GDBusMethodTable agent_methods[] =3D {
 	{ NULL, NULL, NULL, NULL }
 };
 =

-static void create_path(const char *dev_addr, const char *adapter_addr,
-			char *buf, int size)
-{
-	int i, j;
-
-	for (i =3D 0, j =3D 0; adapter_addr[j] && i < size - 1; j++)
-		if (adapter_addr[j] >=3D '0' && adapter_addr[j] <=3D '9')
-			buf[i++] =3D adapter_addr[j];
-		else if (adapter_addr[j] >=3D 'A' && adapter_addr[j] <=3D 'F')
-			buf[i++] =3D adapter_addr[j];
-
-	if (i < size - 1)
-		buf[i++] =3D '_';
-
-	for (j =3D 0; dev_addr[j] && i < size - 1; j++)
-		if (dev_addr[j] >=3D '0' && dev_addr[j] <=3D '9')
-			buf[i++] =3D dev_addr[j];
-		else if (dev_addr[j] >=3D 'A' && dev_addr[j] <=3D 'F')
-			buf[i++] =3D dev_addr[j];
-
-	buf[i] =3D '\0';
-}
-
 static int hfp_create_modem(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -486,7 +463,7 @@ static int hfp_create_modem(const char *device, const c=
har *dev_addr,
 			device, dev_addr, adapter_addr);
 =

 	strcpy(buf, "hfp/");
-	create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
 =

 	modem =3D ofono_modem_create(buf, "hfp");
 	if (modem =3D=3D NULL)
-- =

1.7.1


--===============9175605203767990993==--

