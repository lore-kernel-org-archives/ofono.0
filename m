Content-Type: multipart/mixed; boundary="===============0072567852699252663=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 09/12] stk: Add parser for bcch channel list objects
Date: Sun, 13 Jun 2010 17:43:19 +0800
Message-ID: <1276422202-16240-9-git-send-email-yang.gu@intel.com>
In-Reply-To: <1276422202-16240-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0072567852699252663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   29 +++++++++++++++++++++++++++++
 src/stkutil.h |   10 ++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 3ca808f..1631610 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -851,6 +851,33 @@ static gboolean parse_dataobj_transaction_id(
 	return TRUE;
 }
 =

+/* Defined in TS 31.111 Section 8.29 */
+static gboolean parse_dataobj_bcch_channel_list(
+		struct comprehension_tlv_iter *iter, void *user)
+{
+	struct stk_bcch_channel_list *bcl =3D user;
+	const unsigned char *data;
+	unsigned int len =3D comprehension_tlv_iter_get_length(iter);
+	unsigned int i;
+
+	if (len < 1)
+		return FALSE;
+
+	data =3D comprehension_tlv_iter_get_data(iter);
+
+	bcl->num =3D len * 8 / 10;
+
+	for (i =3D 0; i < bcl->num; i++) {
+		unsigned int index =3D i * 10 / 8;
+		unsigned int occupied =3D i * 10 % 8;
+
+		bcl->channel[i] =3D (data[index] << (2 + occupied)) +
+					(data[index + 1] >> (6 - occupied));
+	}
+
+	return TRUE;
+}
+
 /* Defined in TS 102.223 Section 8.30 */
 static gboolean parse_dataobj_call_control_requested_action(
 		struct comprehension_tlv_iter *iter, void *user)
@@ -1966,6 +1993,8 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 		return parse_dataobj_location_status;
 	case STK_DATA_OBJECT_TYPE_TRANSACTION_ID:
 		return parse_dataobj_transaction_id;
+	case STK_DATA_OBJECT_TYPE_BCCH_CHANNEL_LIST:
+		return parse_dataobj_bcch_channel_list;
 	case STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION:
 		return parse_dataobj_call_control_requested_action;
 	case STK_DATA_OBJECT_TYPE_ICON_ID:
diff --git a/src/stkutil.h b/src/stkutil.h
index b0dcd5f..20c3c02 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -598,6 +598,16 @@ struct stk_transaction_id {
 };
 =

 /*
+ * According to 31.111 Section 8.29 the length of CTLV is 1 byte. This mea=
ns
+ * that the maximum size is 127 according to the rules of CTLVs. Each chan=
nel
+ * is represented as 10 bits, so the maximum number of channel is 127*8/10=
=3D101.
+ */
+struct stk_bcch_channel_list {
+	unsigned short channel[101];
+	unsigned int num;
+};
+
+/*
  * Defined in TS 102.223 Section 8.31
  * Icon ID denotes a file on the SIM filesystem.  Since EF cannot have rec=
ord
  * ids of 0, we use icon_id with 0 to denote empty icon_identifier objects
-- =

1.7.0.4


--===============0072567852699252663==--

