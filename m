Content-Type: multipart/mixed; boundary="===============1209342905362105216=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/7] Add parser for common bool object
Date: Fri, 26 Mar 2010 00:07:34 +0800
Message-ID: <1269533256-29095-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269533256-29095-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1209342905362105216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index af1200c..ecf1301 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -50,6 +50,23 @@ struct gsm_sms_tpdu {
 	unsigned char tpdu[164];
 };
 =

+/* For data object only to indicate its existence */
+static gboolean parse_dataobj_common_bool(struct comprehension_tlv_iter *i=
ter,
+		void *user, enum stk_data_object_type type)
+{
+	gboolean *ret =3D user;
+
+	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
+		return FALSE;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 0)
+		return FALSE;
+
+	*ret =3D TRUE;
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
-- =

1.6.3.3


--===============1209342905362105216==--

