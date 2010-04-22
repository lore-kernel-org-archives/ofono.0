Content-Type: multipart/mixed; boundary="===============0680578046859914621=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 12/13] Add parser for activate descriptor objects
Date: Thu, 22 Apr 2010 23:12:29 +0800
Message-ID: <1271949150-9085-12-git-send-email-yang.gu@intel.com>
In-Reply-To: <1271949150-9085-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0680578046859914621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a0c0d25..75b0035 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -1783,6 +1783,26 @@ static gboolean parse_dataobj_registry_application_d=
ata(
 	return TRUE;
 }
 =

+/* Defined in TS 102.223 Section 8.89 */
+static gboolean parse_dataobj_activate_descriptor(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	unsigned char *byte =3D user;
+	const unsigned char *data;
+
+	if (comprehension_tlv_iter_get_length(iter) !=3D 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	if (data[0] !=3D 0x01)
+		return FALSE;
+
+	*byte =3D data[0];
+
+	return TRUE;
+}
+
 static dataobj_handler handler_for_type(enum stk_data_object_type type)
 {
 	switch (type) {
@@ -1948,6 +1968,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_last_envelope;
 	case STK_DATA_OBJECT_TYPE_REGISTRY_APPLICATION_DATA:
 		return parse_dataobj_registry_application_data;
+	case STK_DATA_OBJECT_TYPE_ACTIVATE_DESCRIPTOR:
+		return parse_dataobj_activate_descriptor;
 	default:
 		return NULL;
 	};
-- =

1.7.0.4


--===============0680578046859914621==--

