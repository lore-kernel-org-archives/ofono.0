Content-Type: multipart/mixed; boundary="===============3085021448067360897=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH] ubloxmodem: gprscontext: adapt for newer firmware
Date: Wed, 16 Nov 2016 16:54:22 +0100
Message-ID: <1479311662-12996-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3085021448067360897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The U-Blox documentation specifies the following:
* get interface ip and dns from +CGDCONTRDP
* get gw ip and netmask from +UIPADDR

However, different firmware versions have different befaviour:

* On newer firmware, +UIPADDR returns error. But it's possible to configure
gateway ip =3D=3D ipterface ip (read from CGDCONTRDP).

* On older firmware, we can actually use the commands specified in the
docs.

This patch runs +CGDCONTRDP, configures everything and then tries to run
+UIPADDR. In that works, reconfigures gw ip and netmask.
---
 drivers/ubloxmodem/gprs-context.c | 51 +++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index 3069e88..61b4090 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -43,6 +43,7 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
+static const char *uipaddr_prefix[] =3D { "+UIPADDR:", NULL };
 =

 struct gprs_context_data {
 	GAtChat *chat;
@@ -51,6 +52,44 @@ struct gprs_context_data {
 	void *cb_data;
 };
 =

+static void uipaddr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+
+	const char *gw =3D NULL;
+	const char *netmask =3D NULL;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+UIPADDR:")) {
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+
+		if (!g_at_result_iter_next_string(&iter, &gw))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &netmask))
+			break;
+	}
+
+	if (gw)
+		ofono_gprs_context_set_ipv4_gateway(gc, gw);
+
+	if (netmask)
+		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
 /*
  * CGCONTRDP returns addr + netmask in the same string in the form
  * of "a.b.c.d.m.m.m.m" for IPv4. IPv6 is not supported so we ignore it.
@@ -113,6 +152,7 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	const char *laddrnetmask =3D NULL;
 	const char *gw =3D NULL;
 	const char *dns[3] =3D { NULL, NULL, NULL };
+	char buf[64];
 =

 	DBG("ok %d", ok);
 =

@@ -159,7 +199,18 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	if (dns[0])
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
 =

+	/* Some older versions of Toby L2 need to issue AT+UIPADDR to get the
+	 * the correct gateway and netmask. The newer version will return an
+	 * empty ok reply.
+	 */
+	snprintf(buf, sizeof(buf), "AT+UIPADDR=3D%u", gcd->active_context);
+	if (g_at_chat_send(gcd->chat, buf, uipaddr_prefix,
+				uipaddr_cb, gc, NULL) > 0)
+		return;
+
+	/* Even if UIPADDR failed, we still have enough data. */
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
 }
 =

 static int ublox_send_cgcontrdp(struct ofono_gprs_context *gc)
-- =

2.7.4


--===============3085021448067360897==--

