Content-Type: multipart/mixed; boundary="===============8747506845513023082=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 01/12] include: Expose voicecall related enums to plugins
Date: Thu, 21 Jun 2018 20:20:50 +0300
Message-ID: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8747506845513023082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/types.h b/include/types.h
index 2c64b20..a562bfe 100644
--- a/include/types.h
+++ b/include/types.h
@@ -49,6 +49,37 @@ enum ofono_clir_option {
 	OFONO_CLIR_OPTION_SUPPRESSION,
 };
 =

+/* 27.007 Section 7.6 */
+enum ofono_clip_validity {
+	OFONO_CLIP_VALIDITY_VALID =3D 0,
+	OFONO_CLIP_VALIDITY_WITHHELD,
+	OFONO_CLIP_VALIDITY_NOT_AVAILABLE
+};
+
+/* 27.007 Section 7.18 */
+enum ofono_call_status {
+	OFONO_CALL_STATUS_ACTIVE =3D 0,
+	OFONO_CALL_STATUS_HELD,
+	OFONO_CALL_STATUS_DIALING,
+	OFONO_CALL_STATUS_ALERTING,
+	OFONO_CALL_STATUS_INCOMING,
+	OFONO_CALL_STATUS_WAITING,
+	OFONO_CALL_STATUS_DISCONNECTED
+};
+
+/* 27.007 Section 7.18 */
+enum ofono_call_direction {
+	OFONO_CALL_DIRECTION_MOBILE_ORIGINATED =3D 0,
+	OFONO_CALL_DIRECTION_MOBILE_TERMINATED
+};
+
+/* 27.007 Section 7.30 */
+enum ofono_cnap_validity {
+	OFONO_CNAP_VALIDITY_VALID =3D 0,
+	OFONO_CNAP_VALIDITY_WITHHELD,
+	OFONO_CNAP_VALIDITY_NOT_AVAILABLE
+};
+
 enum ofono_error_type {
 	OFONO_ERROR_TYPE_NO_ERROR =3D 0,
 	OFONO_ERROR_TYPE_CME,
-- =

1.9.1


--===============8747506845513023082==--

