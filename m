Content-Type: multipart/mixed; boundary="===============7922066535504887455=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/8] bluez5: Add RFCOMM socket address declaration
Date: Mon, 28 Jan 2013 18:11:06 -0300
Message-ID: <1359407468-5110-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359407468-5110-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7922066535504887455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a copy of Bluetooth RFCOMM socket declaration.
---
 plugins/bluez5.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 95914c2..cdbfe72 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -50,6 +50,13 @@ typedef struct {
 =

 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 =

+/* RFCOMM socket address */
+struct sockaddr_rc {
+	sa_family_t	rc_family;
+	bdaddr_t	rc_bdaddr;
+	uint8_t		rc_channel;
+};
+
 /* SCO socket address */
 struct sockaddr_sco {
 	sa_family_t	sco_family;
-- =

1.7.11.7


--===============7922066535504887455==--

