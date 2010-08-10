Content-Type: multipart/mixed; boundary="===============3145672363853575694=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/10] netreg: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:42 +0800
Message-ID: <1281451429-17257-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3145672363853575694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifications when removing network registeration driver.
---
 drivers/atmodem/network-registration.c |   49 ++++++++++++++++++++--------=
---
 1 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b8ec012..8b52bbe 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -57,6 +57,9 @@ struct netreg_data {
 	int signal_max; /* max strength reported via CIND */
 	int tech;
 	unsigned int vendor;
+	guint ciev_id;
+	guint creg_id;
+	guint vendor_id;
 };
 =

 struct tech_query {
@@ -945,10 +948,10 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 =

 	g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
 			NULL, NULL, NULL);
-	g_at_chat_register(nd->chat, "+CIEV:",
-				ciev_notify, FALSE, netreg, NULL);
-	g_at_chat_register(nd->chat, "+CREG:",
-				creg_notify, FALSE, netreg, NULL);
+	nd->ciev_id =3D g_at_chat_register(nd->chat, "+CIEV:", ciev_notify,
+						FALSE, netreg, NULL);
+	nd->creg_id =3D g_at_chat_register(nd->chat, "+CREG:", creg_notify,
+						FALSE, netreg, NULL);
 =

 	ofono_netreg_register(netreg);
 	return;
@@ -975,22 +978,25 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	switch (nd->vendor) {
 	case OFONO_VENDOR_PHONESIM:
-		g_at_chat_register(nd->chat, "+CSQ:",
-					csq_notify, FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "+CSQ:",
+							csq_notify,
+							FALSE, netreg, NULL);
 		break;
 	case OFONO_VENDOR_CALYPSO:
 		g_at_chat_send(nd->chat, "AT%CSQ=3D1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_register(nd->chat, "%CSQ:", calypso_csq_notify,
-					FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "%CSQ:",
+							calypso_csq_notify,
+							FALSE, netreg, NULL);
 		break;
 	case OFONO_VENDOR_OPTION_HSO:
 		g_at_chat_send(nd->chat, "AT_OSSYS=3D1", none_prefix,
 				NULL, NULL, NULL);
 		g_at_chat_send(nd->chat, "AT_OSQI=3D1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_register(nd->chat, "_OSIGQ:", option_osigq_notify,
-					FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "_OSIGQ:",
+							option_osigq_notify,
+							FALSE, netreg, NULL);
 =

 		g_at_chat_send(nd->chat, "AT_OSSYS?", none_prefix,
 				NULL, NULL, NULL);
@@ -1000,8 +1006,9 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	case OFONO_VENDOR_MBM:
 		g_at_chat_send(nd->chat, "AT*ERINFO=3D1", none_prefix,
 				NULL, NULL, NULL);
-		g_at_chat_register(nd->chat, "*ERINFO:", mbm_erinfo_notify,
-					FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "*ERINFO:",
+							mbm_erinfo_notify,
+							FALSE, netreg, NULL);
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
 		return;
@@ -1011,12 +1018,14 @@ static void at_creg_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 		 * of technology changes, but register a handle for
 		 * CNTI so we get notified by any query.
 		 */
-		g_at_chat_register(nd->chat, "$CNTI:", nw_cnti_notify,
-					FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "$CNTI:",
+							nw_cnti_notify,
+							FALSE, netreg, NULL);
 		break;
 	case OFONO_VENDOR_HUAWEI:
-		g_at_chat_register(nd->chat, "^RSSI:", huawei_rssi_notify,
-					FALSE, netreg, NULL);
+		nd->vendor_id =3D g_at_chat_register(nd->chat, "^RSSI:",
+							huawei_rssi_notify,
+							FALSE, netreg, NULL);
 		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
@@ -1024,8 +1033,8 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		return;
 	}
 =

-	g_at_chat_register(nd->chat, "+CREG:",
-				creg_notify, FALSE, netreg, NULL);
+	nd->creg_id =3D g_at_chat_register(nd->chat, "+CREG:", creg_notify,
+						FALSE, netreg, NULL);
 	ofono_netreg_register(netreg);
 }
 =

@@ -1098,6 +1107,10 @@ static void at_netreg_remove(struct ofono_netreg *ne=
treg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+	g_at_chat_unregister(nd->chat, nd->ciev_id);
+	g_at_chat_unregister(nd->chat, nd->creg_id);
+	g_at_chat_unregister(nd->chat, nd->vendor_id);
+
 	ofono_netreg_set_data(netreg, NULL);
 =

 	g_free(nd);
-- =

1.7.0.4


--===============3145672363853575694==--

