Content-Type: multipart/mixed; boundary="===============2064314022643149679=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/7] gatresult: strip trailing spaces from unquoted strings
Date: Tue, 16 Jul 2019 21:10:47 +0200
Message-ID: <20190716191053.71990-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2064314022643149679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some vendors might print trailing spaces after unsolicited result codes.
Avoid duplicating and stripping the string after calling
g_at_result_iter_next_unquoted_string() by stripping the spaces in
gatresult instead.
---
 gatchat/gatresult.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 2659db28..883b4105 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -111,6 +111,7 @@ gboolean g_at_result_iter_next_unquoted_string(GAtResul=
tIter *iter,
 	unsigned int pos;
 	unsigned int end;
 	unsigned int len;
+	unsigned int stripped;
 	char *line;
 =

 	if (iter =3D=3D NULL)
@@ -139,7 +140,12 @@ gboolean g_at_result_iter_next_unquoted_string(GAtResu=
ltIter *iter,
 	while (end < len && line[end] !=3D ',' && line[end] !=3D ')')
 		end +=3D 1;
 =

-	iter->buf[end] =3D '\0';
+	stripped =3D end;
+
+	while (line[stripped - 1] =3D=3D ' ')
+		stripped -=3D 1;
+
+	iter->buf[stripped] =3D '\0';
 =

 out:
 	iter->line_pos =3D skip_to_next_field(line, end, len);
-- =

2.22.0


--===============2064314022643149679==--

