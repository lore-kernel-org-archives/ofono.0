Content-Type: multipart/mixed; boundary="===============3325814438068787295=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 10/11] cdmamodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:43 -0800
Message-ID: <1296308084-3726-11-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3325814438068787295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/devinfo.c   |   16 ----------------
 drivers/cdmamodem/voicecall.c |    4 ----
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
index dfc7fd5..9603e05 100644
--- a/drivers/cdmamodem/devinfo.c
+++ b/drivers/cdmamodem/devinfo.c
@@ -65,15 +65,11 @@ static void cdma_query_manufacturer(struct ofono_devinf=
o *info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "AT+GMI";
 =

 	if (g_at_chat_send(chat, "AT+GMI", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -85,15 +81,11 @@ static void cdma_query_model(struct ofono_devinfo *info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "AT+GMM";
 =

 	if (g_at_chat_send(chat, "AT+GMM", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -105,15 +97,11 @@ static void cdma_query_revision(struct ofono_devinfo *=
info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "AT+GMR";
 =

 	if (g_at_chat_send(chat, "AT+GMR", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
@@ -125,15 +113,11 @@ static void cdma_query_serial(struct ofono_devinfo *i=
nfo,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D "AT+GSN";
 =

 	if (g_at_chat_send(chat, "AT+GSN", NULL, attr_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, data);
diff --git a/drivers/cdmamodem/voicecall.c b/drivers/cdmamodem/voicecall.c
index 94ec74b..cabed6a 100644
--- a/drivers/cdmamodem/voicecall.c
+++ b/drivers/cdmamodem/voicecall.c
@@ -54,16 +54,12 @@ static void cdma_template(const char *cmd, struct ofono=
_cdma_voicecall *vc,
 	struct voicecall_data *vd =3D ofono_cdma_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vc;
 =

 	if (g_at_chat_send(vd->chat, cmd, none_prefix,
 				result_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4


--===============3325814438068787295==--

