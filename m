Content-Type: multipart/mixed; boundary="===============7063194951863847610=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 2/4] ifxmodem: support automatic context activation
Date: Wed, 13 Sep 2017 07:58:42 +0530
Message-ID: <1505269724-19622-2-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1505269724-19622-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7063194951863847610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add support for automatic context activation by adding read_settings.
It also adds detach_shutdown to make sure context is cleaned up when
network registration is lost.
---
 drivers/atmodem/vendor.h        |   1 +
 drivers/ifxmodem/gprs-context.c | 180 +++++++++++++++++++++++++++++++++++-=
----
 drivers/ifxmodem/ifxmodem.h     |   1 +
 3 files changed, 163 insertions(+), 19 deletions(-)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 71a9af7..d52ad52 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -47,4 +47,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_UBLOX,
 	OFONO_VENDOR_UBLOX_TOBY_L2,
 	OFONO_VENDOR_CINTERION,
+	OFONO_VENDOR_XMM,
 };
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 52a3672..7530c97 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -49,6 +49,7 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *xdns_prefix[] =3D { "+XDNS:", NULL };
 static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
+static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
 =

 enum state {
 	STATE_IDLE,
@@ -59,15 +60,18 @@ enum state {
 =

 struct gprs_context_data {
 	GAtChat *chat;
+	unsigned int vendor;
 	unsigned int active_context;
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtRawIP *rawip;
 	enum state state;
 	enum ofono_gprs_proto proto;
-	char address[32];
-	char dns1[32];
-	char dns2[32];
+	char address[64];
+	char gateway[64];
+	char netmask[64];
+	char dns1[64];
+	char dns2[64];
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;                                  /* Callback data */
 };
@@ -257,28 +261,146 @@ error:
 	failed_setup(gc, NULL, TRUE);
 }
 =

-static void activate_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void cgcontrdp_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_gprs_context *gc =3D user_data;
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	char buf[64];
+	GAtResultIter iter;
+
+	const char *laddrnetmask =3D NULL;
+	const char *gw =3D NULL;
+	const char *interface;
+	const char *dns[3];
 =

 	DBG("ok %d", ok);
 =

 	if (!ok) {
-		ofono_error("Unable to activate context");
-		failed_setup(gc, result, FALSE);
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+
 		return;
 	}
 =

-	sprintf(buf, "AT+CGPADDR=3D%u", gcd->active_context);
-	if (g_at_chat_send(gcd->chat, buf, cgpaddr_prefix,
-					address_cb, gc, NULL) > 0)
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
+		/* skip cid, bearer_id, apn */
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+		g_at_result_iter_skip_next(&iter);
+
+		if (!g_at_result_iter_next_string(&iter, &laddrnetmask))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &gw))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &dns[0]))
+			break;
+
+		if (!g_at_result_iter_next_string(&iter, &dns[1]))
+			break;
+	}
+
+	strncpy(gcd->dns1, dns[0], sizeof(gcd->dns1));
+	strncpy(gcd->dns2, dns[1], sizeof(gcd->dns2));
+	dns[2] =3D 0;
+
+	DBG("DNS: %s, %s\n", gcd->dns1, gcd->dns2);
+
+	if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
+					gcd->address, gcd->netmask) < 0) {
+		failed_setup(gc, NULL, TRUE);
 		return;
+	}
+
+	if (gw)
+		strncpy(gcd->gateway, gw, sizeof(gcd->gateway));
+
+	gcd->state =3D STATE_ACTIVE;
+
+	DBG("address: %s\n", gcd->address);
+	DBG("netmask: %s\n", gcd->netmask);
+	DBG("DNS1: %s\n", gcd->dns1);
+	DBG("DNS2: %s\n", gcd->dns2);
+	DBG("Gateway: %s\n", gcd->gateway);
+
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
+
+	if (gcd->netmask[0])
+		ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
+
+	if (gcd->gateway[0])
+		ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
+
+	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void ifx_read_settings(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	gcd->address[0] =3D '\0';
+	gcd->gateway[0] =3D '\0';
+	gcd->netmask[0] =3D '\0';
+	gcd->dns1[0] =3D '\0';
+	gcd->dns2[0] =3D '\0';
+
+	/* read IP configuration info */
+	if(gcd->vendor =3D=3D OFONO_VENDOR_XMM) {
+		snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
+
+		if (g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
+					cgcontrdp_cb, gc, NULL) > 0)
+			return;
+	} else {
+		sprintf(buf, "AT+CGPADDR=3D%u", gcd->active_context);
+		if (g_at_chat_send(gcd->chat, buf, cgpaddr_prefix,
+						address_cb, gc, NULL) > 0)
+			return;
+	}
 =

 	failed_setup(gc, NULL, TRUE);
 }
 =

+static void ifx_gprs_read_settings(struct ofono_gprs_context *gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	DBG("cid %u", cid);
+
+	gcd->active_context =3D cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	ifx_read_settings(gc);
+}
+
+static void activate_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable to activate context");
+		failed_setup(gc, result, FALSE);
+		return;
+	}
+
+	ifx_read_settings(gc);
+}
+
 static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -387,7 +509,8 @@ static void deactivate_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
 =

-	g_at_chat_resume(gcd->chat);
+	if (gcd->vendor !=3D OFONO_VENDOR_XMM)
+		g_at_chat_resume(gcd->chat);
 =

 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
@@ -409,11 +532,25 @@ static void ifx_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 	g_at_rawip_shutdown(gcd->rawip);
 =

 	sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
-	if (g_at_chat_send(chat, buf, none_prefix,
+
+	if (gcd->vendor =3D=3D OFONO_VENDOR_XMM) {
+		if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				deactivate_cb, gc, NULL) > 0)
-		return;
+			return;
+	} else {
+		if (g_at_chat_send(chat, buf, none_prefix,
+				deactivate_cb, gc, NULL) > 0)
+			return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
 =

-	CALLBACK_WITH_SUCCESS(cb, data);
+static void ifx_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+						unsigned int cid)
+{
+	DBG("");
+	ifx_gprs_deactivate_primary(gc, cid, NULL, NULL);
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
@@ -451,14 +588,13 @@ static void cgev_notify(GAtResult *result, gpointer u=
ser_data)
 =

 		g_at_rawip_unref(gcd->rawip);
 		gcd->rawip =3D NULL;
+		g_at_chat_resume(gcd->chat);
 	}
 =

 	ofono_gprs_context_deactivated(gc, gcd->active_context);
 =

 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
-
-	g_at_chat_resume(gcd->chat);
 }
 =

 static int ifx_gprs_context_probe(struct ofono_gprs_context *gc,
@@ -475,18 +611,22 @@ static int ifx_gprs_context_probe(struct ofono_gprs_c=
ontext *gc,
 		return -ENODEV;
 	}
 =

-	if (g_at_chat_get_slave(chat) =3D=3D NULL)
-		return -EINVAL;
+	if (vendor !=3D OFONO_VENDOR_XMM) {
+		if (g_at_chat_get_slave(chat) =3D=3D NULL)
+			return -EINVAL;
+	}
 =

 	gcd =3D g_try_new0(struct gprs_context_data, 1);
 	if (gcd =3D=3D NULL)
 		return -ENOMEM;
 =

+	gcd->vendor =3D vendor;
 	gcd->chat =3D g_at_chat_clone(chat);
 =

 	ofono_gprs_context_set_data(gc, gcd);
 =

-	chat =3D g_at_chat_get_slave(gcd->chat);
+	if (vendor !=3D OFONO_VENDOR_XMM)
+		chat =3D g_at_chat_get_slave(gcd->chat);
 =

 	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
 =

@@ -516,6 +656,8 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D ifx_gprs_context_remove,
 	.activate_primary	=3D ifx_gprs_activate_primary,
 	.deactivate_primary	=3D ifx_gprs_deactivate_primary,
+	.read_settings		=3D ifx_gprs_read_settings,
+	.detach_shutdown	=3D ifx_gprs_detach_shutdown
 };
 =

 void ifx_gprs_context_init(void)
diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
index 43badc9..7f6d870 100644
--- a/drivers/ifxmodem/ifxmodem.h
+++ b/drivers/ifxmodem/ifxmodem.h
@@ -20,6 +20,7 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
 =

 extern void ifx_voicecall_init(void);
 extern void ifx_voicecall_exit(void);
-- =

1.9.1


--===============7063194951863847610==--

