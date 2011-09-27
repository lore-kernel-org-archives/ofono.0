Content-Type: multipart/mixed; boundary="===============6997641373846294052=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 16/21] sap: retrigger bluetooth GetProperties call
Date: Tue, 27 Sep 2011 18:04:15 -0300
Message-ID: <1317157460-17012-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-15-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6997641373846294052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

When plugging a SAP capable modem, GetProperties need to be called again
to fetch the SAP Server devices from BlueZ.
---
 plugins/bluetooth.c |    6 ++++++
 plugins/bluetooth.h |    1 +
 plugins/sap.c       |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 274d25b..573c7c8 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -900,6 +900,12 @@ static void bluetooth_unref(void)
 	g_hash_table_destroy(adapter_address_hash);
 }
 =

+void bluetooth_get_properties()
+{
+	g_hash_table_foreach(adapter_address_hash,
+				(GHFunc) get_adapter_properties, NULL);
+}
+
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
 	bluetooth_ref();
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 5457c0b..723f79b 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -61,6 +61,7 @@ struct server;
 =

 typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
 =

+void bluetooth_get_properties();
 int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
diff --git a/plugins/sap.c b/plugins/sap.c
index c8b0ef5..fbca3d8 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -71,6 +71,8 @@ int bluetooth_sap_client_register(struct bluetooth_sap_dr=
iver *sap,
 	sap_hw_modem =3D modem;
 	sap_hw_driver =3D sap;
 =

+	bluetooth_get_properties();
+
 	return 0;
 }
 =

-- =

1.7.6.2


--===============6997641373846294052==--

