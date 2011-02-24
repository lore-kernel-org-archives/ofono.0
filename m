Content-Type: multipart/mixed; boundary="===============2043049354048238869=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] gatchat: add g_at_result_iter_next_number_or_void API
Date: Thu, 24 Feb 2011 16:46:33 +0100
Message-ID: <1298562394-11475-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298562394-11475-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2043049354048238869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatresult.c |   25 +++++++++++++++++++++++++
 gatchat/gatresult.h |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 8a6dfae..0003f0b 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -292,6 +292,31 @@ gboolean g_at_result_iter_next_number(GAtResultIter *i=
ter, gint *number)
 	return TRUE;
 }
 =

+gboolean g_at_result_iter_next_number_or_void(GAtResultIter *iter, gint *n=
umber)
+{
+	unsigned int pos;
+	int len;
+	char *line;
+
+	if (iter =3D=3D NULL)
+		return FALSE;
+
+	if (iter->l =3D=3D NULL)
+		return FALSE;
+
+	line =3D iter->l->data;
+	len =3D strlen(line);
+
+	pos =3D skip_to_next_field(line, iter->line_pos, len);
+
+	if (pos !=3D iter->line_pos) {
+		iter->line_pos =3D pos;
+		return TRUE;
+	}
+
+	return g_at_result_iter_next_number(iter, number);
+}
+
 gboolean g_at_result_iter_next_range(GAtResultIter *iter, gint *min, gint =
*max)
 {
 	int pos;
diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
index a74741f..7803ca1 100644
--- a/gatchat/gatresult.h
+++ b/gatchat/gatresult.h
@@ -58,6 +58,8 @@ gboolean g_at_result_iter_next_string(GAtResultIter *iter=
, const char **str);
 gboolean g_at_result_iter_next_unquoted_string(GAtResultIter *iter,
 						const char **str);
 gboolean g_at_result_iter_next_number(GAtResultIter *iter, gint *number);
+gboolean g_at_result_iter_next_number_or_void(GAtResultIter *iter,
+						gint *number);
 gboolean g_at_result_iter_next_hexstring(GAtResultIter *iter,
 		const guint8 **str, gint *length);
 =

-- =

1.7.1


--===============2043049354048238869==--

