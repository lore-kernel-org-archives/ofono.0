Content-Type: multipart/mixed; boundary="===============6145359222733030869=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Fix: Change order of CMER and CIND in SLC connection
Date: Wed, 25 Nov 2009 13:47:16 +0800
Message-ID: <1259128036-19125-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6145359222733030869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These two patches fix AT command order issue during service level
connection to comply with HFP v1.5 spec.

The first patch is to change order from CIND=3D?, CMER, CIND? to
CIND=3D?, CIND?, CMER.
---
 plugins/hfp.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index fc29ad9..6e630e8 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -63,6 +63,22 @@ static void hfp_debug(const char *str, void *user_data)
 	ofono_info("%s", str);
 }
 =

+static void cmer_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	if (!ok) {
+		hfp_disable(modem);
+		return;
+	}
+
+	ofono_info("Service level connection established");
+	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cind_status_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -95,30 +111,14 @@ static void cind_status_cb(gboolean ok, GAtResult *res=
ult,
 		index +=3D 1;
 	}
 =

-	ofono_info("Service level connection established");
-	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
-
-	ofono_modem_set_powered(modem, TRUE);
+	g_at_chat_send(data->chat, "AT+CMER=3D3,0,0,1", cmer_prefix,
+				cmer_cb, modem, NULL);
 	return;
 =

 error:
 	hfp_disable(modem);
 }
 =

-static void cmer_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	if (!ok) {
-		hfp_disable(modem);
-		return;
-	}
-
-	g_at_chat_send(data->chat, "AT+CIND?", cind_prefix,
-			cind_status_cb, modem, NULL);
-}
-
 static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -171,8 +171,8 @@ static void cind_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 		index +=3D 1;
 	}
 =

-	g_at_chat_send(data->chat, "AT+CMER=3D3,0,0,1", cmer_prefix,
-				cmer_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT+CIND?", cind_prefix,
+			cind_status_cb, modem, NULL);
 	return;
 =

 error:
-- =

1.6.2.5


--===============6145359222733030869==--

