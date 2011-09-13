Content-Type: multipart/mixed; boundary="===============0387276863208187739=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 21/24] sap: retrigger bluetooth GetProperties call
Date: Tue, 13 Sep 2011 15:58:29 -0300
Message-ID: <1315940312-1238-21-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-20-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0387276863208187739==
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
index 9ac558e..73b8d59 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -896,6 +896,12 @@ static void bluetooth_unref(void)
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
index 089c32f..c26a969 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -62,6 +62,7 @@ struct server;
 =

 typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
 =

+void bluetooth_get_properties();
 int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
diff --git a/plugins/sap.c b/plugins/sap.c
index 10b2386..81e4e32 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -69,6 +69,8 @@ int bluetooth_sap_client_register(struct bluetooth_sap_dr=
iver *sap,
 =

 	g_hash_table_insert(sap_hw_hash, modem, sap);
 =

+	bluetooth_get_properties();
+
 	return 0;
 }
 =

-- =

1.7.6.2


--===============0387276863208187739==--

