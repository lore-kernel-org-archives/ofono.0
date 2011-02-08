Content-Type: multipart/mixed; boundary="===============2634035088188443510=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 1/7] gatchat: Share utility with CDMA network driver
Date: Tue, 08 Feb 2011 13:04:54 -0800
Message-ID: <1297199100-2712-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2634035088188443510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatresult.c |   11 -----------
 gatchat/gatresult.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 8a6dfae..6bd3ff1 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -94,17 +94,6 @@ const char *g_at_result_iter_raw_line(GAtResultIter *ite=
r)
 	return line;
 }
 =

-static inline int skip_to_next_field(const char *line, int pos, int len)
-{
-	if (pos < len && line[pos] =3D=3D ',')
-		pos +=3D 1;
-
-	while (pos < len && line[pos] =3D=3D ' ')
-		pos +=3D 1;
-
-	return pos;
-}
-
 gboolean g_at_result_iter_next_unquoted_string(GAtResultIter *iter,
 						const char **str)
 {
diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
index a74741f..62a2b79 100644
--- a/gatchat/gatresult.h
+++ b/gatchat/gatresult.h
@@ -68,6 +68,17 @@ const char *g_at_result_pdu(GAtResult *result);
 =

 gint g_at_result_num_response_lines(GAtResult *result);
 =

+static inline int skip_to_next_field(const char *line, int pos, int len)
+{
+	if (pos < len && line[pos] =3D=3D ',')
+		pos +=3D 1;
+
+	while (pos < len && line[pos] =3D=3D ' ')
+		pos +=3D 1;
+
+	return pos;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.0.4


--===============2634035088188443510==--

