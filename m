Content-Type: multipart/mixed; boundary="===============6642924380777196853=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 8/9] Add the macro for icon qualifier
Date: Tue, 30 Mar 2010 00:24:43 +0800
Message-ID: <1269879884-12741-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269879884-12741-7-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6642924380777196853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index b85592c..08a5355 100644
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
 struct stk_common_byte_array {
 	unsigned int len;
 	unsigned char *array;
-- =

1.6.3.3


--===============6642924380777196853==--

