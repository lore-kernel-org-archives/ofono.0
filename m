Content-Type: multipart/mixed; boundary="===============4705023460968013443=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] xmm7modem: change to assign datapath for activated PDP
Date: Tue, 12 Feb 2019 17:22:11 +0530
Message-ID: <1549972331-2259-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4705023460968013443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed the handling of +CGCONTRDP AT command reply in ifxmodem
modem driver for XMM7MODEM vendor for routing data over the
selected path.
---
 drivers/ifxmodem/gprs-context.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 7f3628b..70d10af 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -269,8 +269,10 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	const char *laddrnetmask =3D NULL;
 	const char *gw =3D NULL;
-	const char *interface;
 	const char *dns[3];
+	const char *ctrlpath;
+	const char *datapath;
+	char buf[64];
 =

 	DBG("ok %d", ok);
 =

@@ -327,9 +329,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	DBG("DNS2: %s\n", gcd->dns2);
 	DBG("Gateway: %s\n", gcd->gateway);
 =

-	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
+	datapath =3D ofono_modem_get_string(modem, "DataPath");
 =

-	ofono_gprs_context_set_interface(gc, interface);
 	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
 =

 	if (gcd->netmask[0])
@@ -340,6 +342,12 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
 =

+	sprintf(buf, "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s%u\",2,%u", ctrlpath,
+				datapath, gcd->active_context, gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%u", gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

-- =

1.9.1


--===============4705023460968013443==--

