Content-Type: multipart/mixed; boundary="===============3337754748539689398=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] Fix power down of hfpmodem
Date: Thu, 04 Feb 2010 02:37:18 -0200
Message-ID: <1265258238-30559-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3337754748539689398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I was using hfp_disable directly to shutdown the modem. It's wrong, we
should call ofono_modem_set_powered(modem, FALSE) for that.
---
 plugins/hfp.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 0e2e359..122a336 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -66,7 +66,6 @@ static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static DBusConnection *connection;
 =

-static int hfp_disable(struct ofono_modem *modem);
 static void hfp_remove(struct ofono_modem *modem);
 =

 static void hfp_debug(const char *str, void *user_data)
@@ -140,7 +139,7 @@ static void cmer_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	if (!ok) {
-		hfp_disable(modem);
+		ofono_modem_set_powered(modem, FALSE);
 		return;
 	}
 =

@@ -198,10 +197,9 @@ static gboolean hfp_enable_timeout(gpointer user)
 {
 	struct ofono_modem *modem =3D user;
 =

-	if (ofono_modem_get_powered(modem))
-		return FALSE;
+	if (!ofono_modem_get_powered(modem))
+		ofono_modem_set_powered(modem, FALSE);
 =

-	hfp_disable(modem);
 	return FALSE;
 }
 =

@@ -242,7 +240,7 @@ static void cind_status_cb(gboolean ok, GAtResult *resu=
lt,
 	return;
 =

 error:
-	hfp_disable(modem);
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static void cind_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -302,7 +300,7 @@ static void cind_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	return;
 =

 error:
-	hfp_disable(modem);
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static void brsf_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -326,7 +324,7 @@ static void brsf_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	return;
 =

 error:
-	hfp_disable(modem);
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 /* either oFono or Phone could request SLC connection */
@@ -769,8 +767,6 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 	g_source_remove(data->at_timeout);
 =

-	ofono_modem_set_powered(modem, FALSE);
-
 	hfp_disconnect_ofono_handsfree(modem);
 	return 0;
 }
-- =

1.6.4.4


--===============3337754748539689398==--

