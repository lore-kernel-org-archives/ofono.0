Content-Type: multipart/mixed; boundary="===============7302059913933437543=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 2/4] bluetooth: move uuid to struct bluetooth_profile
Date: Sun, 18 Jul 2010 19:57:27 -0300
Message-ID: <1279493849-22930-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279493849-22930-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7302059913933437543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |    4 ++--
 plugins/bluetooth.h |    4 ++--
 plugins/hfp.c       |    3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 1079838..f74c9c5 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -482,7 +482,7 @@ static guint adapter_added_watch;
 static guint adapter_removed_watch;
 static guint property_watch;
 =

-int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+int bluetooth_register_uuid(struct bluetooth_profile *profile)
 {
 	int err;
 =

@@ -522,7 +522,7 @@ int bluetooth_register_uuid(const char *uuid, struct bl=
uetooth_profile *profile)
 						g_free, g_free);
 =

 done:
-	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+	g_hash_table_insert(uuid_hash, g_strdup(profile->uuid), profile);
 =

 	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
 				manager_properties_cb, NULL, NULL, -1,
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index fb0d841..1cb950b 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -30,14 +30,14 @@
 =

 struct bluetooth_profile {
 	const char *name;
+	const char *uuid;
 	int (*create)(const char *device, const char *dev_addr,
 			const char *adapter_addr, const char *alias);
 	void (*remove_all)();
 	void (*set_alias)(const char *device, const char *);
 };
 =

-int bluetooth_register_uuid(const char *uuid,
-				struct bluetooth_profile *profile);
+int bluetooth_register_uuid(struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
diff --git a/plugins/hfp.c b/plugins/hfp.c
index b6cd415..76923f0 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -674,6 +674,7 @@ static struct ofono_modem_driver hfp_driver =3D {
 =

 static struct bluetooth_profile hfp_profile =3D {
 	.name		=3D "hfp",
+	.uuid		=3D HFP_AG_UUID,
 	.create		=3D hfp_create_modem,
 	.remove_all	=3D hfp_remove_all_modem,
 	.set_alias	=3D hfp_set_alias,
@@ -692,7 +693,7 @@ static int hfp_init()
 	if (err < 0)
 		return err;
 =

-	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_profile);
+	err =3D bluetooth_register_uuid(&hfp_profile);
 	if (err < 0) {
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
-- =

1.7.1.1


--===============7302059913933437543==--

