Content-Type: multipart/mixed; boundary="===============2250040588567795072=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/9] include: Add definitions for phone number types
Date: Tue, 13 Oct 2015 18:07:51 +0200
Message-ID: <1444752478-18198-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2250040588567795072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/types.h b/include/types.h
index 9a7dfd9..2c64b20 100644
--- a/include/types.h
+++ b/include/types.h
@@ -73,6 +73,12 @@ struct ofono_error {
 #define OFONO_MAX_PHONE_NUMBER_LENGTH 80
 #define OFONO_MAX_CALLER_NAME_LENGTH 80
 =

+/* Number types, 3GPP TS 24.008 subclause 10.5.4.7, octect 3 */
+/* Unknown, ISDN numbering plan */
+#define OFONO_NUMBER_TYPE_UNKNOWN 129
+/* International, ISDN numbering plan */
+#define OFONO_NUMBER_TYPE_INTERNATIONAL 145
+
 struct ofono_phone_number {
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
 	int type;
-- =

2.1.4


--===============2250040588567795072==--

