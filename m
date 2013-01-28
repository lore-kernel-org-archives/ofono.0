Content-Type: multipart/mixed; boundary="===============4069198666983164976=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 6/9] bluez5: Add RFCOMM socket address declaration
Date: Mon, 28 Jan 2013 11:44:16 -0300
Message-ID: <1359384259-5384-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4069198666983164976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a copy of Bluetooth RFCOMM socket declaration.
---
 plugins/bluez5.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 2d70fbf..ba1b529 100644
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


--===============4069198666983164976==--

