Content-Type: multipart/mixed; boundary="===============7327867597193138156=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 1/2] bluetooth: Add define for SCO voice settings
Date: Mon, 15 Apr 2013 16:03:50 -0300
Message-ID: <1366052631-19705-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366052631-19705-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7327867597193138156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Add defines for SCO voice setting (Air Coding). Air mode "Transparent
Data" shall be supported if wide band speech is supported.
---
 src/bluetooth.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/bluetooth.h b/src/bluetooth.h
index af6f02c..4421b59 100644
--- a/src/bluetooth.h
+++ b/src/bluetooth.h
@@ -54,6 +54,17 @@ struct sockaddr_sco {
 	bdaddr_t	sco_bdaddr;
 };
 =

+/* SCO socket settings */
+#define SCO_SETTINGS	0x03
+
+struct sco_settings {
+	uint16_t settings;
+};
+
+/* From Core 4.0 spec, Volume 2, Part E. Section 6.12, page 685 */
+#define SCO_SETTING_CVSD		0x0000
+#define SCO_SETTING_TRANSPARENT		0x0003
+
 static inline void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
-- =

1.8.2.1


--===============7327867597193138156==--

