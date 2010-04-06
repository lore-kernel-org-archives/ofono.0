Content-Type: multipart/mixed; boundary="===============3649124037187285647=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 04/13] Break out stk_file iterator to parse file list objects
Date: Tue, 06 Apr 2010 18:06:38 +0800
Message-ID: <1270548407-12042-4-git-send-email-yang.gu@intel.com>
In-Reply-To: <1270548407-12042-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3649124037187285647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  166 +++++++++++++++++++++++++++++++++--------------------=
----
 1 files changed, 97 insertions(+), 69 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c249a3a..8b53e6d 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -39,6 +39,14 @@ enum stk_data_object_flag {
 	DATAOBJ_FLAG_MINIMUM =3D 2
 };
 =

+struct stk_file_iter {
+	const unsigned char *start;
+	unsigned int pos;
+	unsigned int max;
+	unsigned char len;
+	const unsigned char *file;
+};
+
 typedef gboolean (*dataobj_handler)(struct comprehension_tlv_iter *, void =
*);
 =

 /*
@@ -157,6 +165,86 @@ static gboolean parse_dataobj_common_byte_array(
 	return TRUE;
 }
 =

+static void stk_file_iter_init(struct stk_file_iter *iter,
+				const unsigned char *start, unsigned int len)
+{
+	iter->start =3D start;
+	iter->max =3D len;
+	iter->pos =3D 0;
+}
+
+static gboolean stk_file_iter_next(struct stk_file_iter *iter)
+{
+	unsigned int pos =3D iter->pos;
+	const unsigned int max =3D iter->max;
+	const unsigned char *start =3D iter->start;
+	unsigned int i;
+	unsigned char last_type;
+
+	/* SIM EFs always start with ROOT MF, 0x3f */
+	if (start[iter->pos] !=3D 0x3f)
+		return FALSE;
+
+	if (pos + 2 >=3D max)
+		return FALSE;
+
+	last_type =3D 0x3f;
+
+	for (i =3D pos + 2; i < max; i +=3D 2) {
+		/*
+		 * Check the validity of file type.
+		 * According to TS 11.11, each file id contains of two bytes,
+		 * in which the first byte is the type of file. For GSM is:
+		 * 0x3f: master file
+		 * 0x7f: 1st level dedicated file
+		 * 0x5f: 2nd level dedicated file
+		 * 0x2f: elementary file under the master file
+		 * 0x6f: elementary file under 1st level dedicated file
+		 * 0x4f: elementary file under 2nd level dedicated file
+		 */
+		switch (start[i]) {
+		case 0x2f:
+			if (last_type !=3D 0x3f)
+				return FALSE;
+			break;
+		case 0x6f:
+			if (last_type !=3D 0x7f)
+				return FALSE;
+			break;
+		case 0x4f:
+			if (last_type !=3D 0x5f)
+				return FALSE;
+			break;
+		case 0x7f:
+			if (last_type !=3D 0x3f)
+				return FALSE;
+			break;
+		case 0x5f:
+			if (last_type !=3D 0x7f)
+				return FALSE;
+			break;
+		default:
+			return FALSE;
+		}
+
+		if ((start[i] =3D=3D 0x2f) || (start[i] =3D=3D 0x6f) ||
+						(start[i] =3D=3D 0x4f)) {
+			if (i + 1 >=3D max)
+				return FALSE;
+
+			iter->file =3D start + pos;
+			iter->len =3D i - pos + 2;
+			iter->pos =3D i + 2;
+
+			return TRUE;
+		}
+
+		last_type =3D start[i];
+	}
+
+	return FALSE;
+}
+
 /* Defined in TS 102.223 Section 8.1 */
 static gboolean parse_dataobj_address(struct comprehension_tlv_iter *iter,
 					void *user)
@@ -443,10 +531,8 @@ static gboolean parse_dataobj_file_list(struct compreh=
ension_tlv_iter *iter,
 	GSList **fl =3D user;
 	const unsigned char *data;
 	unsigned int len;
-	unsigned int i;
-	unsigned int start;
 	struct stk_file *sf;
-	unsigned char last_type;
+	struct stk_file_iter sf_iter;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
 	if (len < 5)
@@ -454,77 +540,19 @@ static gboolean parse_dataobj_file_list(struct compre=
hension_tlv_iter *iter,
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 =

-	/* SIM EFs always start with ROOT MF, 0x3f */
-	if (data[1] !=3D 0x3f)
-		return FALSE;
-
-	start =3D 1;
-	last_type =3D 0x3f;
-
-	for (i =3D 3; i < len; i +=3D 2) {
-		/*
-		 * Check the validity of file type.
-		 * According to TS 11.11, each file id contains of two bytes,
-		 * in which the first byte is the type of file. For GSM is:
-		 * 0x3f: master file
-		 * 0x7f: 1st level dedicated file
-		 * 0x5f: 2nd level dedicated file
-		 * 0x2f: elementary file under the master file
-		 * 0x6f: elementary file under 1st level dedicated file
-		 * 0x4f: elementary file under 2nd level dedicated file
-		 */
-		switch (data[i]) {
-		case 0x3f:
-			if ((last_type !=3D 0x2f) && (last_type !=3D 0x6f) &&
-					(last_type !=3D 0x4f))
-				goto error;
-
-			start =3D i;
+	stk_file_iter_init(&sf_iter, data + 1, len - 1);
 =

-			break;
-		case 0x2f:
-			if (last_type !=3D 0x3f)
-				goto error;
-			break;
-		case 0x6f:
-			if (last_type !=3D 0x7f)
-				goto error;
-			break;
-		case 0x4f:
-			if (last_type !=3D 0x5f)
-				goto error;
-			break;
-		case 0x7f:
-			if (last_type !=3D 0x3f)
-				goto error;
-			break;
-		case 0x5f:
-			if (last_type !=3D 0x7f)
-				goto error;
-			break;
-		default:
+	while (stk_file_iter_next(&sf_iter)) {
+		sf =3D g_try_new0(struct stk_file, 1);
+		if (sf =3D=3D NULL)
 			goto error;
-		}
-
-		if ((data[i] =3D=3D 0x2f) || (data[i] =3D=3D 0x6f) ||
-						(data[i] =3D=3D 0x4f)) {
-			if (i + 1 >=3D len)
-				goto error;
-
-			sf =3D g_try_new0(struct stk_file, 1);
-			if (sf =3D=3D NULL)
-				goto error;
-
-			sf->len =3D i - start + 2;
-			memcpy(sf->file, data + start, i - start + 2);
-			*fl =3D g_slist_prepend(*fl, sf);
-		}
 =

-		last_type =3D data[i];
+		sf->len =3D sf_iter.len;
+		memcpy(sf->file, sf_iter.file, sf_iter.len);
+		*fl =3D g_slist_prepend(*fl, sf);
 	}
 =

-	if ((data[len - 2] !=3D 0x2f) && (data[len - 2] !=3D 0x6f) &&
-						(data[len - 2] !=3D 0x4f))
+	if (sf_iter.pos !=3D sf_iter.max)
 		goto error;
 =

 	*fl =3D g_slist_reverse(*fl);
-- =

1.6.3.3


--===============3649124037187285647==--

