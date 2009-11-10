Content-Type: multipart/mixed; boundary="===============3023174837503320680=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Properly skip over quoted values
Date: Tue, 10 Nov 2009 07:31:31 +0100
Message-ID: <1257834691-22584-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3023174837503320680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise a left paren in a string can bring an obscure segfault.
---
 gatchat/gatresult.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
index 3d07e13..688b26b 100644
--- a/gatchat/gatresult.c
+++ b/gatchat/gatresult.c
@@ -361,6 +361,17 @@ static gint skip_until(const char *line, int start, co=
nst char delim)
 		if (line[i] =3D=3D delim)
 			return i;
 =

+		if (line[i] =3D=3D '\"') {
+			i +=3D 1;
+			while (i < len && line[i] !=3D '\"')
+				i +=3D 1;
+
+			if (i < len)
+				i +=3D 1;
+
+			continue;
+		}
+
 		if (line[i] !=3D '(') {
 			i +=3D 1;
 			continue;
-- =

1.6.1


--===============3023174837503320680==--

