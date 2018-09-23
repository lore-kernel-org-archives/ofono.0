Content-Type: multipart/mixed; boundary="===============7397702553901485672=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/gprs: added autoattach handling
Date: Sun, 23 Sep 2018 07:21:05 +0200
Message-ID: <20180923052105.7676-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7397702553901485672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of LTE modem, attaching manually is normally unneeded.
Forcing a detach (in case of gprs-context activation failure) is
actually a mistake, also because this will also trigger a technology
reselection and a possible invalid state, especially for LTE-only
modems.

This simple patch adds a flag to skip the AT+CGATT=3Dx command.
The flag is to be set by vendor-specific options.

By default the behavior remains unchanged.
---
 drivers/atmodem/gprs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 6e01738a..fc0d8aa3 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -59,6 +59,7 @@ struct gprs_data {
 	gboolean has_cereg;
 	gboolean has_c5greg;
 	gboolean nb_inds;
+	gboolean auto_attach; /* for LTE modems & co */
 	int attached;
 	int cgreg_status;
 	int cereg_status;
@@ -88,9 +89,15 @@ static void at_gprs_set_attached(struct ofono_gprs *gprs=
, int attached,
 					ofono_gprs_cb_t cb, void *data)
 {
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct cb_data *cbd;
 	char buf[64];
 =

+	if (gd->auto_attach) {
+		CALLBACK_WITH_SUCCESS(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
 	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
 =

 	if (g_at_chat_send(gd->chat, buf, none_prefix,
-- =

2.17.1


--===============7397702553901485672==--

