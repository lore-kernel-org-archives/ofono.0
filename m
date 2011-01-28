Content-Type: multipart/mixed; boundary="===============3780530023206095144=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/5] ifxmodem: add NULL check
Date: Fri, 28 Jan 2011 03:50:04 -0800
Message-ID: <1296215408-4946-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3780530023206095144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/radio-settings.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index fd590ae..6771e00 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -104,11 +104,13 @@ static void ifx_query_rat_mode(struct ofono_radio_set=
tings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT+XRAT?", xrat_prefix,
-					xrat_query_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT+XRAT?", xrat_prefix,
+					xrat_query_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void xrat_modify_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
@@ -131,6 +133,9 @@ static void ifx_set_rat_mode(struct ofono_radio_setting=
s *rs,
 	char buf[20];
 	int value =3D 1, preferred =3D 2;
 =

+	if (cbd =3D=3D NULL)
+		goto error;
+
 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
 		value =3D 1;
-- =

1.7.0.4


--===============3780530023206095144==--

