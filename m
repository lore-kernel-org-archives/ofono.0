Content-Type: multipart/mixed; boundary="===============2484475785421497285=="
MIME-Version: 1.0
From: dragos@endocode.com
Subject: [PATCH 19/19] ubloxmodem: add routed mode support
Date: Wed, 09 Mar 2016 17:06:23 +0100
Message-ID: <1457539583-9109-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2484475785421497285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongsu Park <dongsu@endocode.com>

Routed mode needs a different treatment than bridged mode:

* UIPCONF needs to be used for reading the interface ip configuratuion.
The spec says that DHCP should work on that interface but it doesn't. So
we read the first ip in the dhcp range and use that.

* CGCONTRDP: only APN and DNS configuration is read
---
 drivers/ubloxmodem/gprs-context.c | 151 ++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index bc100d6..4040a07 100644
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
@@ -250,6 +251,65 @@ static void cgcontrdp_bridge_cb(gboolean ok, GAtResult=
 *result, gpointer user_da
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

+static void cgcontrdp_router_cb(gboolean ok, GAtResult *result, gpointer u=
ser_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+
+	const char *dns[2+1] =3D { NULL, NULL, NULL };
+	const char *apn =3D NULL;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		callback_with_error(gcd, result);
+
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
+		/* skip cid, bearer_id */
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+
+		/* read apn */
+		if (!g_at_result_iter_next_string(&iter, &apn))
+			break;
+
+		/* skip laddrnetmask, gw */
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+
+		/* read dns servers */
+		if (!g_at_result_iter_next_string(&iter, &dns[0]))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &dns[1]))
+			break;
+	}
+
+	set_gprs_context_interface(gc);
+
+	if (dns[0])
+		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+
+	if (gcd->active_context =3D=3D ublox_data.default_context_id) {
+		/*
+		 * Only for automatic default context: the APN set by the user
+		 * might not be the correct one because the default context was
+		 * used instead.
+		 */
+		ofono_gprs_context_set_apn(gc, apn);
+		strcpy(gcd->apn, apn);
+	}
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+	return;
+}
+
 static int ublox_read_ip_config_bridge(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
@@ -262,11 +322,100 @@ static int ublox_read_ip_config_bridge(struct ofono_=
gprs_context *gc)
 =

 }
 =

+static void read_uipconf_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	const char *gw, *netmask, *ipaddr, *dhcp_range_start, *dhcp_range_end;
+	gboolean found =3D FALSE;
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		release_context_id(gcd->active_context);
+		callback_with_error(gcd, result);
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
+	/* read ip configuration info */
+	snprintf(buf, sizeof(buf), "AT+CGCONTRDP");
+	if (g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
+				cgcontrdp_router_cb, gc, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static int ublox_read_ip_config_router(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	/* read ip configuration info */
+	snprintf(buf, sizeof(buf), "AT+UIPCONF?");
+	return g_at_chat_send(gcd->chat, buf, uipconf_prefix,
+				read_uipconf_cb, gc, NULL);
+
+}
+
 static void ublox_post_activation(struct ofono_gprs_context *gc)
 {
+	struct ofono_modem *modem;
+	const char *network_mode;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	int ret =3D 0;
+
+	modem =3D ofono_gprs_context_get_modem(gc);
+	network_mode =3D ofono_modem_get_string(modem, "NetworkMode");
+
+	if (g_str_equal(network_mode, "routed"))
+		ret =3D ublox_read_ip_config_router(gc) ;
+	else
+		ret =3D ublox_read_ip_config_bridge(gc);
 =

-	if (ublox_read_ip_config_bridge(gc) < 0)
+	if (ret <=3D 0)
 		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

-- =

2.5.0


--===============2484475785421497285==--

