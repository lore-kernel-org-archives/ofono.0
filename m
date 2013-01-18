Content-Type: multipart/mixed; boundary="===============5089556158737625730=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH 1/2] qmimodem: add uim message types
Date: Fri, 18 Jan 2013 09:51:08 +0100
Message-ID: <1358499069-13103-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5089556158737625730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

Define message types for verify pin and card status indication.
---
 drivers/qmimodem/uim.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 8f123e7..73e9c94 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -24,10 +24,13 @@
 #define QMI_UIM_WRITE_TRANSPARENT	34	/* Write data */
 #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
 #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
+#define QMI_UIM_VERIFY_PIN		38      /* Verify PIN*/
 =

 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
 #define QMI_UIM_GET_CARD_STATUS		47	/* Get card status */
 =

+#define QMI_UIM_CARD_STATUS_IND		50	/* Card status indication*/
+
 =

 /* Register for indications */
 #define QMI_UIM_PARAM_EVENT_MASK	0x01	/* uint32 */
-- =

1.7.9.5


--===============5089556158737625730==--

