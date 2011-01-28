Content-Type: multipart/mixed; boundary="===============6275249435389029576=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 5/5] nwmodem: add NULL check
Date: Fri, 28 Jan 2011 03:50:08 -0800
Message-ID: <1296215408-4946-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6275249435389029576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/nwmodem/radio-settings.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nwmodem/radio-settings.c b/drivers/nwmodem/radio-setti=
ngs.c
index b8b5719..0cf75f5 100644
--- a/drivers/nwmodem/radio-settings.c
+++ b/drivers/nwmodem/radio-settings.c
@@ -101,11 +101,13 @@ static void nw_query_rat_mode(struct ofono_radio_sett=
ings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT$NWRAT?", nwrat_prefix,
-					nwrat_query_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT$NWRAT?", nwrat_prefix,
+					nwrat_query_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void nwrat_modify_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -128,6 +130,9 @@ static void nw_set_rat_mode(struct ofono_radio_settings=
 *rs,
 	char buf[20];
 	int value =3D 0;
 =

+	if (cbd =3D=3D NULL)
+		goto error;
+
 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
 		value =3D 0;
-- =

1.7.0.4


--===============6275249435389029576==--

