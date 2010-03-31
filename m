Content-Type: multipart/mixed; boundary="===============3166650299688276206=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 08/11] Add enum for icon qualifier
Date: Wed, 31 Mar 2010 17:17:00 +0800
Message-ID: <1270027023-21468-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270027023-21468-7-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3166650299688276206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 9ba8138..5619211 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -296,6 +296,11 @@ enum stk_service_state {
 	STK_NO_SERVICE =3D 	0x02
 };
 =

+enum stk_icon_qualifier {
+	STK_ICON_QUALIFIER_TYPE_SELF_EXPLANATORY =3D 	0x00,
+	STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY =3D	0x01
+};
+
 /* For data object that only has a byte array with undetermined length */
 struct stk_common_byte_array {
 	unsigned char *array;
-- =

1.6.3.3


--===============3166650299688276206==--

