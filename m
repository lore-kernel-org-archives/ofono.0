Content-Type: multipart/mixed; boundary="===============8654762322864678440=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 7/7] ubloxmodem: add routed mode support
Date: Thu, 17 Mar 2016 13:38:33 +0100
Message-ID: <1458218313-26966-8-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8654762322864678440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongsu Park <dongsu@endocode.com>

Routed mode needs a different treatment than bridged mode:

* UIPCONF needs to be used for reading the interface ip configuratuion.
The spec says that DHCP should work on that interface but it doesn't. So
we read the first ip in the dhcp range and use that.

* CGCONTRDP: only DNS configuration is read
---
 drivers/ubloxmodem/gprs-context.c | 104 ++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 778ff85..77a85c4 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -43,6 +43,7 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
+static const char *uipconf_prefix[] =3D { "+UIPCONF:", NULL };
 =

 struct gprs_context_data {
 	GAtChat *chat;
@@ -107,6 +108,15 @@ static void set_gprs_context_interface(struct ofono_gp=
rs_context *gc)
 	ofono_gprs_context_set_interface(gc, interface);
 }
 =

+static const char *ublox_network_mode(struct ofono_gprs_context *gc)
+{
+	struct ofono_modem *modem;
+
+	modem =3D ofono_gprs_context_get_modem(gc);
+	return ofono_modem_get_string(modem, "NetworkMode");
+
+}
+
 static void cgcontrdp_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -151,13 +161,16 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	set_gprs_context_interface(gc);
 =

-	if (!laddrnetmask || set_address_and_netmask(gc, laddrnetmask) < 0) {
-		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
-		return;
-	}
+	if (g_str_equal(ublox_network_mode(gc), "bridged")) {
+		if (!laddrnetmask ||
+			set_address_and_netmask(gc, laddrnetmask) < 0) {
+			CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+			return;
+		}
 =

-	if (gw)
-		ofono_gprs_context_set_ipv4_gateway(gc, gw);
+		if (gw)
+			ofono_gprs_context_set_ipv4_gateway(gc, gw);
+	}
 =

 	if (dns[0])
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
@@ -177,11 +190,88 @@ static int ublox_send_cgcontrdp(struct ofono_gprs_con=
text *gc)
 =

 }
 =

+static void uipconf_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	const char *gw, *netmask, *ipaddr, *dhcp_range_start, *dhcp_range_end;
+	gboolean found =3D FALSE;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	/* for example, +UIPCONF: entry looks like:
+	 * +UIPCONF: "192.168.1.1","255.255.255.0","192.168.1.100",
+	 *           "192.168.1.100","fe80::48a5:b2ff:fe6f:5f86/64"
+	 */
+	while (g_at_result_iter_next(&iter, "+UIPCONF:")) {
+		if (!g_at_result_iter_next_string(&iter, &gw))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &netmask))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &dhcp_range_start))
+			continue;
+
+		if (!g_at_result_iter_next_string(&iter, &dhcp_range_end))
+			continue;
+
+		/* skip other entries like IPv6 networks */
+		found =3D TRUE;
+		break;
+	}
+
+	if (!found)
+		goto error;
+
+	if (dhcp_range_start && dhcp_range_end) {
+		/* dhcp doesn't seem to work properly, so take
+		 * first address in range.
+		 */
+		ipaddr =3D dhcp_range_start;
+		ofono_gprs_context_set_ipv4_address(gc, ipaddr, 1);
+	}
+
+	if (netmask)
+		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
+
+	if (gw)
+		ofono_gprs_context_set_ipv4_gateway(gc, gw);
+
+	/* read dns */
+	if (ublox_send_cgcontrdp(gc) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
 static void ublox_read_settings(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	int ret =3D 0;
+	char buf[64];
+
+	if (g_str_equal(ublox_network_mode(gc), "routed")) {
+		snprintf(buf, sizeof(buf), "AT+UIPCONF?");
+		ret =3D g_at_chat_send(gcd->chat, buf, uipconf_prefix,
+					uipconf_cb, gc, NULL);
+	} else
+		ret =3D ublox_send_cgcontrdp(gc);
 =

-	if (ublox_send_cgcontrdp(gc) < 0)
+	if (ret <=3D 0)
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

-- =

2.5.0


--===============8654762322864678440==--

