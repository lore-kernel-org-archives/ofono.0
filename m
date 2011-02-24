Content-Type: multipart/mixed; boundary="===============9159918394666502829=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] gatchat: add g_at_result_iter_next_number_default API
Date: Thu, 24 Feb 2011 18:16:05 +0100
Message-ID: <1298567766-17745-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298567766-17745-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9159918394666502829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatresult.c |   30 ++++++++++++++++++++++++++++++
 gatchat/gatresult.h |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 8a6dfae..f992486 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -292,6 +292,36 @@ gboolean g_at_result_iter_next_number(GAtResultIter *i=
ter, gint *number)
 	return TRUE;
 }
 =

+gboolean g_at_result_iter_next_number_default(GAtResultIter *iter, gint df=
lt,
+						gint *number)
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
+
+		if (number)
+			*number =3D dflt;
+
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
index a74741f..f498c86 100644
--- a/gatchat/gatresult.h
+++ b/gatchat/gatresult.h
@@ -58,6 +58,8 @@ gboolean g_at_result_iter_next_string(GAtResultIter *iter=
, const char **str);
 gboolean g_at_result_iter_next_unquoted_string(GAtResultIter *iter,
 						const char **str);
 gboolean g_at_result_iter_next_number(GAtResultIter *iter, gint *number);
+gboolean g_at_result_iter_next_number_default(GAtResultIter *iter, gint df=
lt,
+						gint *number);
 gboolean g_at_result_iter_next_hexstring(GAtResultIter *iter,
 		const guint8 **str, gint *length);
 =

-- =

1.7.1


--===============9159918394666502829==--

