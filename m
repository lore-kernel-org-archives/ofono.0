Content-Type: multipart/mixed; boundary="===============8348975520323990856=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] coding-style M14: parenthesis around sizeof arg
Date: Fri, 03 Dec 2010 11:05:28 +0200
Message-ID: <1291367128-21358-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8348975520323990856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/coding-style.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 9dfdc09..9d7131d 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -230,6 +230,20 @@ array =3D g_try_new0(int, 20);
 if (array =3D=3D NULL)	// Correct
 	return;
 =

+
+M14: Always use parenthesis with sizeof
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The expression argument to the sizeof operator should always be in
+parenthesis, too.
+
+Example:
+1)
+memset(stuff, 0, sizeof(*stuff));
+
+2)
+memset(stuff, 0, sizeof *stuff); // Wrong
+
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.1


--===============8348975520323990856==--

