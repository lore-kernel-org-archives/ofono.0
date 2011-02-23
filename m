Content-Type: multipart/mixed; boundary="===============7411929809905651910=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH v2 02/18] isimodem: added codepoints for u8500
Date: Wed, 23 Feb 2011 12:43:13 +0100
Message-ID: <18ea7d76bea531ba732c1a6cac98436b0448a78f.1298460572.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7411929809905651910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/debug.c |    1 +
 drivers/isimodem/info.h  |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index c14acc2..10d0201 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -481,6 +481,7 @@ const char *info_message_id_name(enum info_message_id v=
alue)
 const char *info_subblock_name(enum info_subblock value)
 {
 	switch (value) {
+		_(INFO_SB_MODEMSW_VERSION);
 		_(INFO_SB_PRODUCT_INFO_NAME);
 		_(INFO_SB_PRODUCT_INFO_MANUFACTURER);
 		_(INFO_SB_SN_IMEI_PLAIN);
diff --git a/drivers/isimodem/info.h b/drivers/isimodem/info.h
index bdf1596..60425bf 100644
--- a/drivers/isimodem/info.h
+++ b/drivers/isimodem/info.h
@@ -27,6 +27,8 @@ extern "C" {
 #endif
 =

 #define PN_PHONE_INFO				0x1B
+#define PN_MODEM_INFO				0xC5
+
 #define PN_EPOC_INFO				98
 #define INFO_TIMEOUT				5
 =

@@ -50,6 +52,7 @@ enum info_message_id {
 };
 =

 enum info_subblock {
+	INFO_SB_MODEMSW_VERSION =3D		0x00,
 	INFO_SB_PRODUCT_INFO_NAME =3D		0x01,
 	INFO_SB_PRODUCT_INFO_MANUFACTURER =3D	0x07,
 	INFO_SB_SN_IMEI_PLAIN =3D			0x41,
-- =

1.7.3.5


--===============7411929809905651910==--

