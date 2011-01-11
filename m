Content-Type: multipart/mixed; boundary="===============0376509377301400177=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] coding-style: Use void if function has no parameters
Date: Tue, 11 Jan 2011 23:39:30 +0100
Message-ID: <1294785570-2901-1-git-send-email-sjurbren@gmail.com>
In-Reply-To: <4D2CD1FE.4070601@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0376509377301400177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
Marcel, Denis,

Here is the patch, please apply it if you agree. I'm easy :-)

Regards,
Sjur

 doc/coding-style.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 3bee240..40bb36b 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -279,6 +279,21 @@ memset(stuff, 0, sizeof(*stuff));
 memset(stuff, 0, sizeof *stuff); // Wrong
 =

 =

+M15: Use void if function has no parameters
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+A function with no parameters must use void in the parameter list.
+
+Example:
+1)
+void foo(void)
+{
+}
+
+2)
+void foo()	// Wrong
+{
+}
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.0.4


--===============0376509377301400177==--

