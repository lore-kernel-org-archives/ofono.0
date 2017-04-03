Content-Type: multipart/mixed; boundary="===============4375168202335874568=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC qmi 1/1] qmi: retrieve GPRS context parameters
Date: Mon, 03 Apr 2017 14:38:04 +0200
Message-ID: <20170403123804.13011-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4375168202335874568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

This is an RFC because I want some guidance here.  Once the GPRS context
has been activated, we can get the connection parameters via a QMI call.
The question is, what am I supposed to do with these?

i)  Am I responsible for configuring the network interface?  Do I need
to implement all the netlink calls to do so?

ii)  Or does a connection manager like connman set up the network interface
for me based on the context parameters it retrieves via DBUS?

iii)  What about routing?  Presumably I should not just force the default
route onto the new network interface as that's the connection manager's job,
right?

A bit of guidance on how to proceed here would be appreciated.

Thanks in advance,
Jonas


 drivers/qmimodem/gprs-context.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/wds.h          |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index da2be24..7f424a8 100644
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
@@ -75,21 +76,55 @@ static void get_settings_cb(struct qmi_result *result, =
void *user_data)
 	struct cb_data *cbd =3D user_data;
 	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
 	struct ofono_modem *modem;
 	const char *interface;
 	uint8_t pdp_type, ip_family;
+	uint32_t ip_addr;
+	struct in_addr addr;
+	char* straddr;
+	char* apn;
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
+	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_PRIMARY_DNS, &ip_addr)) {
+
+		addr.s_addr =3D htonl(ip_addr);
+		DBG("Primary DNS: %s", inet_ntoa(addr));
+	}
+	if (qmi_result_get_uint32(result,QMI_WDS_RESULT_SECONDARY_DNS, &ip_addr))=
 {
+
+		addr.s_addr =3D htonl(ip_addr);
+		DBG("Secondary DNS: %s", inet_ntoa(addr));
+	}
+
 done:
 	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
@@ -98,6 +133,8 @@ done:
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

+	g_free(apn);
+
 	g_free(cbd);
 }
 =

diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 4843f92..e113743 100644
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


--===============4375168202335874568==--

