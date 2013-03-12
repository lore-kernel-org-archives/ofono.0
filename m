Content-Type: multipart/mixed; boundary="===============7746394127625016698=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 19/20] bluetooth: Add define for SCO voice settings
Date: Tue, 12 Mar 2013 11:21:43 -0300
Message-ID: <1363098104-16467-20-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7746394127625016698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add defines for SCO voice setting (Air Coding). Air mode "Transparent
Data" shall be supported if wide band speech is supported.
---
 src/bluetooth.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/bluetooth.h b/src/bluetooth.h
index af6f02c..f2fd7d5 100644
--- a/src/bluetooth.h
+++ b/src/bluetooth.h
@@ -54,6 +54,18 @@ struct sockaddr_sco {
 	bdaddr_t	sco_bdaddr;
 };
 =

+/* SCO socket options */
+#define SCO_OPTIONS		0x01
+
+#define SCO_MODE_CVSD		0x00
+#define SCO_MODE_TRANSPARENT	0x01
+#define SCO_MODE_ENHANCED	0x02
+
+struct sco_options {
+	uint16_t mtu;
+	uint8_t mode;
+};
+
 static inline void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
-- =

1.7.11.7


--===============7746394127625016698==--

