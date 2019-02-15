Content-Type: multipart/mixed; boundary="===============8942392449383603419=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] xmm7modem: data channel setup for xmm7modem
Date: Fri, 15 Feb 2019 17:13:59 +0530
Message-ID: <1550231039-28842-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8942392449383603419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added the implementation required to setup data channel in
ifxmodem gprs-context driver for xmm7modem vendor
---
 drivers/ifxmodem/gprs-context.c | 43 +++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 7f3628b..278d507 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -260,6 +260,22 @@ error:
 	failed_setup(gc, NULL, TRUE);
 }
 =

+static void cgdata_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Failed to establish session");
+		failed_setup(gc, result, TRUE);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
 static void cgcontrdp_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -269,8 +285,11 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	const char *laddrnetmask =3D NULL;
 	const char *gw =3D NULL;
-	const char *interface;
 	const char *dns[3];
+	const char *ctrlpath;
+	char *datapath;
+	char buf[100];
+	const char *interface;
 =

 	DBG("ok %d", ok);
 =

@@ -327,9 +346,13 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	DBG("DNS2: %s\n", gcd->dns2);
 	DBG("Gateway: %s\n", gcd->gateway);
 =

-	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
+	interface =3D ofono_gprs_context_get_interface(gc);
+
+	sprintf(buf, "%s%c", ofono_modem_get_string(modem, "DataPath"),
+					interface[strlen(interface)-1]);
+	datapath =3D g_strdup(buf);
 =

-	ofono_gprs_context_set_interface(gc, interface);
 	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
 =

 	if (gcd->netmask[0])
@@ -340,7 +363,19 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
 =

-	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+	sprintf(buf, "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u", ctrlpath,
+				datapath, gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%u", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, cgdata_cb,
+						gc, NULL) > 0) {
+		g_free(datapath);
+		return;
+	}
+
+	g_free(datapath);
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

 static void ifx_read_settings(struct ofono_gprs_context *gc)
-- =

1.9.1


--===============8942392449383603419==--

