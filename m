Content-Type: multipart/mixed; boundary="===============3790048100013762287=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Scrap PINs in memory when no longer needed.
Date: Sun, 05 Jul 2009 16:38:14 +0200
Message-ID: <1246804694-10212-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3790048100013762287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zero memory holding PINs/passwords where trivially doable.  Other
places can pontentially hold passwords but in this patch we don't
touch them if we're not sure, maybe we should.
---
 drivers/atmodem/call-barring.c |   19 ++++++++++++++-----
 drivers/atmodem/call-meter.c   |   37 ++++++++++++++++++++++++++-----------
 src/ussd.c                     |    3 +++
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/atmodem/call-barring.c b/drivers/atmodem/call-barring.c
index f0ba18e..c659371 100644
--- a/drivers/atmodem/call-barring.c
+++ b/drivers/atmodem/call-barring.c
@@ -124,6 +124,7 @@ static void at_call_barring_set(struct ofono_modem *mod=
em, const char *lock,
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
 	char buf[64];
 	int len;
+	guint id;
 =

 	if (!cbd || strlen(lock) !=3D 2 || (cls && !passwd))
 		goto error;
@@ -138,8 +139,11 @@ static void at_call_barring_set(struct ofono_modem *mo=
dem, const char *lock,
 					",%i", cls);
 	}
 =

-	if (g_at_chat_send(at->parser, buf, none_prefix,
-				clck_set_cb, cbd, g_free) > 0)
+	id =3D g_at_chat_send(at->parser, buf, none_prefix,
+				clck_set_cb, cbd, g_free);
+	memset(buf, 0, len);
+
+	if (id > 0)
 		return;
 =

 error:
@@ -171,15 +175,20 @@ static void at_call_barring_set_passwd(struct ofono_m=
odem *modem,
 	struct at_data *at =3D ofono_modem_userdata(modem);
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
 	char buf[64];
+	guint id;
+	int len;
 =

 	if (!cbd || strlen(lock) !=3D 2)
 		goto error;
 =

-	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
+	len =3D snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
 			lock, old_passwd, new_passwd);
 =

-	if (g_at_chat_send(at->parser, buf, none_prefix,
-				cpwd_set_cb, cbd, g_free) > 0)
+	id =3D g_at_chat_send(at->parser, buf, none_prefix,
+				cpwd_set_cb, cbd, g_free);
+	memset(buf, 0, len);
+
+	if (id > 0)
 		return;
 =

 error:
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index e7c55c3..cff27a5 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -175,14 +175,19 @@ static void at_cacm_set(struct ofono_modem *modem, co=
nst char *passwd,
 	struct at_data *at =3D ofono_modem_userdata(modem);
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
 	char buf[64];
+	guint id;
+	int len;
 =

 	if (!cbd)
 		goto error;
 =

-	snprintf(buf, sizeof(buf), "AT+CACM=3D\"%s\"", passwd);
+	len =3D snprintf(buf, sizeof(buf), "AT+CACM=3D\"%s\"", passwd);
 =

-	if (g_at_chat_send(at->parser, buf, none_prefix,
-				generic_set_cb, cbd, g_free) > 0)
+	id =3D g_at_chat_send(at->parser, buf, none_prefix,
+				generic_set_cb, cbd, g_free);
+	memset(buf, 0, len);
+
+	if (id > 0)
 		return;
 =

 error:
@@ -219,20 +224,25 @@ error:
 	}
 }
 =

-static void at_camm_set(struct ofono_modem *modem,	int accmax, const char =
*passwd,
-			ofono_generic_cb_t cb, void *data)
+static void at_camm_set(struct ofono_modem *modem, int accmax,
+			const char *passwd, ofono_generic_cb_t cb, void *data)
 {
 	struct at_data *at =3D ofono_modem_userdata(modem);
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
 	char buf[64];
+	guint id;
+	int len;
 =

 	if (!cbd)
 		goto error;
 =

-	sprintf(buf, "AT+CAMM=3D\"%06X\",\"%s\"", accmax, passwd);
+	len =3D sprintf(buf, "AT+CAMM=3D\"%06X\",\"%s\"", accmax, passwd);
 =

-	if (g_at_chat_send(at->parser, buf, none_prefix,
-				generic_set_cb, cbd, g_free) > 0)
+	id =3D g_at_chat_send(at->parser, buf, none_prefix,
+				generic_set_cb, cbd, g_free);
+	memset(buf, 0, len);
+
+	if (id > 0)
 		return;
 =

 error:
@@ -313,15 +323,20 @@ static void at_cpuc_set(struct ofono_modem *modem, co=
nst char *currency,
 	struct at_data *at =3D ofono_modem_userdata(modem);
 	struct cb_data *cbd =3D cb_data_new(modem, cb, data);
 	char buf[64];
+	guint id;
+	int len;
 =

 	if (!cbd)
 		goto error;
 =

-	snprintf(buf, sizeof(buf), "AT+CPUC=3D\"%s\",\"%f\",\"%s\"",
+	len =3D snprintf(buf, sizeof(buf), "AT+CPUC=3D\"%s\",\"%f\",\"%s\"",
 			currency, ppu, passwd);
 =

-	if (g_at_chat_send(at->parser, buf, none_prefix,
-				generic_set_cb, cbd, g_free) > 0)
+	id =3D g_at_chat_send(at->parser, buf, none_prefix,
+				generic_set_cb, cbd, g_free);
+	memset(buf, 0, len);
+
+	if (id > 0)
 		return;
 =

 error:
diff --git a/src/ussd.c b/src/ussd.c
index 97c3304..08b9b52 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -322,6 +322,9 @@ static gboolean recognized_control_string(struct ofono_=
modem *modem,
 		if (recognized_passwd_change_string(modem, type, sc,
 					sia, sib, sic, sid, dn, msg)) {
 			ret =3D TRUE;
+			memset(sib, 0, strlen(sib));
+			memset(sic, 0, strlen(sic));
+			memset(sid, 0, strlen(sid));
 			goto out;
 		}
 =

-- =

1.6.0


--===============3790048100013762287==--

