Content-Type: multipart/mixed; boundary="===============0640868852719670272=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/6] huaweimodem: always cache ^SYSCFG values when supported
Date: Thu, 09 Dec 2010 14:43:39 -0200
Message-ID: <1291913020-3103-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0640868852719670272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When modem is supported, we need to cache the current values returned by
^SYSCFG command early on initialization. This will be used in future
for frequency band selection that depends on the value of 'mode' property.
---
 drivers/huaweimodem/radio-settings.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 38c0f3d..1281d8b 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -180,13 +180,24 @@ static void syscfg_support_cb(gboolean ok, GAtResult =
*result,
 				gpointer user_data)
 {
 	struct ofono_radio_settings *rs =3D user_data;
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
 =

-	if (!ok) {
-		ofono_radio_settings_remove(rs);
-		return;
-	}
+	if (!ok)
+		goto error_not_supported;
+
+	if (!syscfg_query_parse(rsd, result))
+		goto error_parsing;
 =

 	ofono_radio_settings_register(rs);
+
+	return;
+
+error_parsing:
+	ofono_warn("Radio settings is supported, but it was not " \
+			"possible to parse modem response");
+
+error_not_supported:
+	ofono_radio_settings_remove(rs);
 }
 =

 static int huawei_radio_settings_probe(struct ofono_radio_settings *rs,
@@ -203,7 +214,7 @@ static int huawei_radio_settings_probe(struct ofono_rad=
io_settings *rs,
 =

 	ofono_radio_settings_set_data(rs, rsd);
 =

-	g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", syscfg_prefix,
+	g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
 					syscfg_support_cb, rs, NULL);
 =

 	return 0;
-- =

1.7.3.3


--===============0640868852719670272==--

