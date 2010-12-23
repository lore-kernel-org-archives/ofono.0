Content-Type: multipart/mixed; boundary="===============2258259348963297911=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] coding-style: mention preferred line wrap
Date: Thu, 23 Dec 2010 11:02:56 -0200
Message-ID: <1293109376-11634-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2258259348963297911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding-style.txt |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 9d7131d..c267b6b 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -75,10 +75,11 @@ Example:
 a + b;  // correct
 =

 =

-M4: Long condition
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-If your condition in if, while, for statement is too long to fit in one li=
ne,
-the new line needs to be indented not aligned with the body.
+M4: Wrap long lines
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If your condition in if, while, for statement or a function declaration is=
 too
+long to fit in one line, the new line needs to be indented not aligned wit=
h the
+body.
 =

 Example:
 1)
@@ -91,6 +92,40 @@ if (call->status =3D=3D CALL_STATUS_ACTIVE ||
 		call->status =3D=3D CALL_STATUS_HELD) {  // correct
 	ofono_dbus_dict_append();
 =

+3)
+gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
+	num sim_ust_service index) // wrong
+{
+	int a;
+	...
+}
+
+4)
+gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
+					enum sim_ust_service index) // correct
+{
+	int a;
+	...
+}
+
+If the line being wrapped is a function call or function declaration, the
+preferred style is to indent at least past the opening parenthesis. Indent=
ing
+further is acceptable as well (as long as you don't hit the 80 character
+limit).
+
+If this is not possible due to hitting the 80 character limit, then indent=
ing
+as far as possible to the right without hitting the limit is preferred.
+
+Example:
+
+1)
+gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
+		enum sim_ust_service index); // worse
+
+2)
+gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char le=
n,
+						enum sim_ust_service index); // better
+
 =

 M5: Git commit message 50/72 formatting
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.3.4


--===============2258259348963297911==--

