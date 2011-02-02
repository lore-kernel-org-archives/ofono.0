Content-Type: multipart/mixed; boundary="===============4943589226011197433=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] ifx: remove setting to offline during modem enable
Date: Wed, 02 Feb 2011 08:52:51 -0800
Message-ID: <1296665571-2209-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4943589226011197433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ifx.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 411c012..ae53193 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -345,23 +345,6 @@ error:
 	ofono_modem_set_powered(modem, FALSE);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct ifx_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("");
-
-	if (!ok) {
-		shutdown_device(data);
-		ofono_modem_set_powered(modem, FALSE);
-		return;
-	}
-
-	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
-					xgendata_query, modem, NULL);
-}
-
 static gboolean dlc_setup(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -378,8 +361,8 @@ static gboolean dlc_setup(gpointer user_data)
 	g_at_chat_set_slave(data->dlcs[GPRS2_DLC], data->dlcs[NETREG_DLC]);
 	g_at_chat_set_slave(data->dlcs[GPRS3_DLC], data->dlcs[NETREG_DLC]);
 =

-	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D4", NULL,
-					cfun_enable, modem, NULL);
+	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
+					xgendata_query, modem, NULL);
 =

 	data->dlc_init_source =3D 0;
 =

-- =

1.7.0.4


--===============4943589226011197433==--

