Content-Type: multipart/mixed; boundary="===============5342612510005395242=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/5] hsomodem: add NULL check
Date: Fri, 28 Jan 2011 03:50:05 -0800
Message-ID: <1296215408-4946-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5342612510005395242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hsomodem/radio-settings.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hsomodem/radio-settings.c b/drivers/hsomodem/radio-set=
tings.c
index cefd415..a761d44 100644
--- a/drivers/hsomodem/radio-settings.c
+++ b/drivers/hsomodem/radio-settings.c
@@ -103,11 +103,13 @@ static void hso_query_rat_mode(struct ofono_radio_set=
tings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT_OPSYS?", opsys_prefix,
-					opsys_query_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT_OPSYS?", opsys_prefix,
+					opsys_query_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void opsys_modify_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -130,6 +132,9 @@ static void hso_set_rat_mode(struct ofono_radio_setting=
s *rs,
 	char buf[20];
 	int value =3D 5;
 =

+	if (cbd =3D=3D NULL)
+		goto error;
+
 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
 		value =3D 5;
-- =

1.7.0.4


--===============5342612510005395242==--

