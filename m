Content-Type: multipart/mixed; boundary="===============2446516062393071093=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 1/3] bluetooth: Add list of UUIDs to probe function
Date: Mon, 04 Jun 2012 16:11:30 +0200
Message-ID: <1338819092-28696-2-git-send-email-wagi@monom.org>
In-Reply-To: <1338819092-28696-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2446516062393071093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/bluetooth.c  |    2 +-
 plugins/bluetooth.c |    8 +++++---
 plugins/bluetooth.h |    2 +-
 plugins/hfp_hf.c    |    2 +-
 plugins/sap.c       |    2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
index e2e2bca..5a913cc 100644
--- a/dundee/bluetooth.c
+++ b/dundee/bluetooth.c
@@ -132,7 +132,7 @@ struct dundee_device_driver bluetooth_driver =3D {
 	.disconnect =3D bt_disconnect,
 };
 =

-static int bt_probe(const char *path, const char *dev_addr,
+static int bt_probe(GSList *uuids, const char *path, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
 	struct bluetooth_device *bt;
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index dbf79eb..0be6000 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -265,16 +265,18 @@ static void bluetooth_probe(GSList *uuids, const char=
 *path,
 				const char *device, const char *adapter,
 				const char *alias)
 {
-	for (; uuids; uuids =3D uuids->next) {
+	GSList *l;
+
+	for (l =3D uuids; l; l =3D l->next) {
 		struct bluetooth_profile *driver;
-		const char *uuid =3D uuids->data;
+		const char *uuid =3D l->data;
 		int err;
 =

 		driver =3D g_hash_table_lookup(uuid_hash, uuid);
 		if (driver =3D=3D NULL)
 			continue;
 =

-		err =3D driver->probe(path, device, adapter, alias);
+		err =3D driver->probe(uuids, path, device, adapter, alias);
 		if (err =3D=3D 0)
 			continue;
 =

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 4fc16ad..c06abf7 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -38,7 +38,7 @@
 =

 struct bluetooth_profile {
 	const char *name;
-	int (*probe)(const char *device, const char *dev_addr,
+	int (*probe)(GSList *uuids, const char *device, const char *dev_addr,
 			const char *adapter_addr, const char *alias);
 	void (*remove)(const char *prefix);
 	void (*set_alias)(const char *device, const char *);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 7c500e3..74780b7 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -206,7 +206,7 @@ static const GDBusMethodTable agent_methods[] =3D {
 	{ }
 };
 =

-static int hfp_hf_probe(const char *device, const char *dev_addr,
+static int hfp_hf_probe(GSList *uuids, const char *device, const char *dev=
_addr,
 				const char *adapter_addr, const char *alias)
 {
 	struct ofono_modem *modem;
diff --git a/plugins/sap.c b/plugins/sap.c
index d893bc1..7f728f9 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -235,7 +235,7 @@ static void sap_post_online(struct ofono_modem *modem)
 	data->sap_driver->post_online(data->hw_modem);
 }
 =

-static int bluetooth_sap_probe(const char *device, const char *dev_addr,
+static int bluetooth_sap_probe(GSList *uuds, const char *device, const cha=
r *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
 	struct ofono_modem *modem;
-- =

1.7.10.130.g36e6c


--===============2446516062393071093==--

