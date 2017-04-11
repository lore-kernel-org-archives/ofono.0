Content-Type: multipart/mixed; boundary="===============0923542817158335060=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/8] qmi: retrieve GPRS context parameters
Date: Tue, 11 Apr 2017 10:18:13 +0200
Message-ID: <20170411081818.19544-4-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0923542817158335060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The GPRS context needs to be configured with connection parameters when
the bearer has been established.  This was only partially implemented, so
this patch adds additional parameters to those passed to the context.
---
 drivers/qmimodem/gprs-context.c | 52 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/wds.h          |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index da2be24..1ae2a5a 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <string.h>
+#include <arpa/inet.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -78,18 +79,67 @@ static void get_settings_cb(struct qmi_result *result, =
void *user_data)
 	struct ofono_modem *modem;
 	const char *interface;
 	uint8_t pdp_type, ip_family;
+	uint32_t ip_addr;
+	struct in_addr addr;
+	char* straddr;
+	char* apn =3D NULL;
+	const char *dns[3] =3D { NULL, NULL, NULL };
 =

 	DBG("");
 =

 	if (qmi_result_set_error(result, NULL))
 		goto done;
 =

+	apn =3D qmi_result_get_string(result, QMI_WDS_RESULT_APN);
+	if (apn) {
+		DBG("APN: %s", apn);
+	}
 	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_PDP_TYPE, &pdp_type))
 		DBG("PDP type %d", pdp_type);
 =

 	if (qmi_result_get_uint8(result, QMI_WDS_RESULT_IP_FAMILY, &ip_family))
 		DBG("IP family %d", ip_family);
 =

+	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_IP_ADDRESS, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		straddr =3D inet_ntoa(addr);
+		DBG("IP addr: %s", straddr);
+		ofono_gprs_context_set_ipv4_address(gc, straddr, 1);
+	}
+	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_GATEWAY, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		straddr =3D inet_ntoa(addr);
+		DBG("Gateway: %s", straddr);
+		ofono_gprs_context_set_ipv4_gateway(gc, straddr);
+	}
+	if (qmi_result_get_uint32(result,
+				QMI_WDS_RESULT_GATEWAY_NETMASK, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		straddr =3D inet_ntoa(addr);
+		DBG("Gateway netmask: %s", straddr);
+		ofono_gprs_context_set_ipv4_netmask(gc, straddr);
+	}
+	if (qmi_result_get_uint32(result,
+				QMI_WDS_RESULT_PRIMARY_DNS, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		dns[0] =3D inet_ntoa(addr);
+		DBG("Primary DNS: %s", dns[0]);
+	}
+	if (qmi_result_get_uint32(result,
+				QMI_WDS_RESULT_SECONDARY_DNS, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		dns[1] =3D inet_ntoa(addr);
+		DBG("Secondary DNS: %s", dns[1]);
+	}
+
+	if (dns[0])
+		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+
 done:
 	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
@@ -98,6 +148,8 @@ done:
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

+	g_free(apn);
+
 	g_free(cbd);
 }
 =

diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index e03d177..8aae996 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -58,6 +58,7 @@ struct qmi_wds_notify_conn_status {
 =

 /* Get the runtime data session settings */
 #define QMI_WDS_RESULT_PDP_TYPE			0x11	/* uint8 */
+#define QMI_WDS_RESULT_APN			0x14	/* string */
 #define QMI_WDS_RESULT_PRIMARY_DNS		0x15	/* uint32 IPv4 */
 #define QMI_WDS_RESULT_SECONDARY_DNS		0x16	/* uint32 IPv4 */
 #define QMI_WDS_RESULT_IP_ADDRESS		0x1e	/* uint32 IPv4 */
-- =

2.9.3


--===============0923542817158335060==--

