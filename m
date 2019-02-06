Content-Type: multipart/mixed; boundary="===============2048182284320400050=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] xmm7modem: change to assign datapath for activated PDP
 context
Date: Wed, 06 Feb 2019 14:08:45 +0530
Message-ID: <1549442325-29860-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2048182284320400050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed the handling of CGCONTRDP AT command reply in ifxmodem
modem driver for XMM7MODEM vendor for assigning network interface
to context settings and routing data over the selected path.
---
 drivers/ifxmodem/gprs-context.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 7f3628b..676bbfa 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -49,6 +49,8 @@ static const char *none_prefix[] =3D { NULL };
 static const char *xdns_prefix[] =3D { "+XDNS:", NULL };
 static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
 static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
+static const char *net_interface[] =3D { "NetworkInterface", "NetworkInter=
face2",
+					"NetworkInterface3", NULL };
 =

 enum state {
 	STATE_IDLE,
@@ -271,6 +273,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	const char *gw =3D NULL;
 	const char *interface;
 	const char *dns[3];
+	const char *ctrlpath;
+	const char *datapath;
+	char buf[64];
 =

 	DBG("ok %d", ok);
 =

@@ -327,7 +332,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	DBG("DNS2: %s\n", gcd->dns2);
 	DBG("Gateway: %s\n", gcd->gateway);
 =

-	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	interface =3D ofono_modem_get_string(modem, net_interface[gcd->active_con=
text]);
+	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
+	datapath =3D ofono_modem_get_string(modem, "DataPath");
 =

 	ofono_gprs_context_set_interface(gc, interface);
 	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
@@ -340,6 +347,12 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
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


--===============2048182284320400050==--

