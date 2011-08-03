Content-Type: multipart/mixed; boundary="===============7389609256087837292=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] cdmamodem: Use correct prefixes to parse devinfo AT results
 correctly
Date: Wed, 03 Aug 2011 15:44:31 +0200
Message-ID: <1312379071-8035-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7389609256087837292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/devinfo.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cdmamodem/devinfo.c b/drivers/cdmamodem/devinfo.c
index 2a5813c..06b759c 100644
--- a/drivers/cdmamodem/devinfo.c
+++ b/drivers/cdmamodem/devinfo.c
@@ -67,7 +67,7 @@ static void cdma_query_manufacturer(struct ofono_devinfo =
*info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	cbd->user =3D "AT+GMI";
+	cbd->user =3D "+GMI:";
 =

 	if (g_at_chat_send(chat, "AT+GMI", NULL, attr_cb, cbd, g_free) > 0)
 		return;
@@ -83,7 +83,7 @@ static void cdma_query_model(struct ofono_devinfo *info,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	cbd->user =3D "AT+GMM";
+	cbd->user =3D "+GMM:";
 =

 	if (g_at_chat_send(chat, "AT+GMM", NULL, attr_cb, cbd, g_free) > 0)
 		return;
@@ -99,7 +99,7 @@ static void cdma_query_revision(struct ofono_devinfo *inf=
o,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	cbd->user =3D "AT+GMR";
+	cbd->user =3D "+GMR:";
 =

 	if (g_at_chat_send(chat, "AT+GMR", NULL, attr_cb, cbd, g_free) > 0)
 		return;
@@ -115,7 +115,7 @@ static void cdma_query_serial(struct ofono_devinfo *inf=
o,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	GAtChat *chat =3D ofono_devinfo_get_data(info);
 =

-	cbd->user =3D "AT+GSN";
+	cbd->user =3D "+GSN:";
 =

 	if (g_at_chat_send(chat, "AT+GSN", NULL, attr_cb, cbd, g_free) > 0)
 		return;
-- =

1.7.1


--===============7389609256087837292==--

