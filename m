Content-Type: multipart/mixed; boundary="===============7372181392267797337=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/8] qmi: add WDS parameter definition
Date: Tue, 11 Apr 2017 10:18:12 +0200
Message-ID: <20170411081818.19544-3-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7372181392267797337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/wds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/qmimodem/wds.h b/drivers/qmimodem/wds.h
index 4843f92..e03d177 100644
--- a/drivers/qmimodem/wds.h
+++ b/drivers/qmimodem/wds.h
@@ -62,6 +62,7 @@ struct qmi_wds_notify_conn_status {
 #define QMI_WDS_RESULT_SECONDARY_DNS		0x16	/* uint32 IPv4 */
 #define QMI_WDS_RESULT_IP_ADDRESS		0x1e	/* uint32 IPv4 */
 #define QMI_WDS_RESULT_GATEWAY			0x20	/* uint32 IPv4 */
+#define QMI_WDS_RESULT_GATEWAY_NETMASK		0x21	/* uint32 IPv4 */
 #define QMI_WDS_RESULT_IP_FAMILY		0x2b	/* uint8 */
 =

 #define QMI_WDS_PDP_TYPE_IPV4			0x00
-- =

2.9.3


--===============7372181392267797337==--

