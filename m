Content-Type: multipart/mixed; boundary="===============7232499394777270313=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 4/5] stemodem: add NULL check
Date: Fri, 28 Jan 2011 03:50:07 -0800
Message-ID: <1296215408-4946-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7232499394777270313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/radio-settings.c |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 5b50126..337a19c 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -139,11 +139,13 @@ static void ste_query_rat_mode(struct ofono_radio_set=
tings *rs,
 	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (g_at_chat_send(rsd->chat, "AT+CFUN?", cfun_prefix,
-					rat_query_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, -1, data);
-		g_free(cbd);
-	}
+	if (cbd && g_at_chat_send(rsd->chat, "AT+CFUN?", cfun_prefix,
+					rat_query_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void rat_modify_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -172,19 +174,22 @@ static void ste_set_rat_mode(struct ofono_radio_setti=
ngs *rs,
 	char buf[20];
 	enum ste_radio_mode value;
 =

-	if (!ofono_mode_to_ste_mode(mode, &value)) {
-		CALLBACK_WITH_FAILURE(cb, data);
-		g_free(cbd);
-		return;
-	}
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (!ofono_mode_to_ste_mode(mode, &value))
+		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CFUN=3D%u", value);
 =

 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
-					rat_modify_cb, cbd, g_free) =3D=3D 0) {
-		CALLBACK_WITH_FAILURE(cb, data);
-		g_free(cbd);
-	}
+					rat_modify_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static int ste_radio_settings_probe(struct ofono_radio_settings *rs,
-- =

1.7.0.4


--===============7232499394777270313==--

