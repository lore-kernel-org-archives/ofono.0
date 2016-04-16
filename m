Content-Type: multipart/mixed; boundary="===============7626604131107016269=="
MIME-Version: 1.0
From: Holger Hans Peter Freyther <holger@freyther.de>
Subject: [PATCH] src/log.c: Don't crash when addr2line output contains no
 newline
Date: Sat, 16 Apr 2016 11:28:22 -0400
Message-ID: <1460820502-37815-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7626604131107016269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Harald Welte <hwelte@sysmocom.de>

---
 src/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/log.c b/src/log.c
index 6331b0d..42a2ec1 100644
--- a/src/log.c
+++ b/src/log.c
@@ -192,6 +192,8 @@ static void print_backtrace(unsigned int offset)
 		buf[len] =3D '\0';
 =

 		pos =3D strchr(buf, '\n');
+		if (!pos)
+			break;
 		*pos++ =3D '\0';
 =

 		if (strcmp(buf, "??") =3D=3D 0) {
-- =

2.6.3


--===============7626604131107016269==--

