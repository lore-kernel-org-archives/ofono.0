Content-Type: multipart/mixed; boundary="===============6350355827544256798=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 1/1] gatserver: Add ATS5 command feature
Date: Thu, 10 Feb 2011 14:59:42 +0100
Message-ID: <1297346382-20135-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6350355827544256798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index be9f79a..25b7ba4 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -796,6 +796,7 @@ static char *extract_line(GAtServer *p, struct ring_buf=
fer *rbuf)
 	int line_length =3D 0;
 	gboolean in_string =3D FALSE;
 	char s3 =3D p->v250.s3;
+	char s5 =3D p->v250.s5;
 	char *line;
 	int i;
 =

@@ -837,7 +838,11 @@ static char *extract_line(GAtServer *p, struct ring_bu=
ffer *rbuf)
 		if (*buf =3D=3D '"')
 			in_string =3D !in_string;
 =

-		if ((*buf =3D=3D ' ' || *buf =3D=3D '\t') && in_string =3D=3D FALSE)
+		if (*buf =3D=3D s5) {
+			if (i !=3D 0)
+				i -=3D 1;
+		}
+		else if ((*buf =3D=3D ' ' || *buf =3D=3D '\t') && in_string =3D=3D FALSE)
 			; /* Skip */
 		else if (*buf !=3D s3)
 			line[i++] =3D *buf;
-- =

1.7.1


--===============6350355827544256798==--

