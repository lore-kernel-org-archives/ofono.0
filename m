Content-Type: multipart/mixed; boundary="===============7377905992733903659=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH] coding-style: Add exception to M12 rule for external enums
Date: Wed, 17 Nov 2010 08:09:12 +0100
Message-ID: <1289977754-7530-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7377905992733903659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 doc/coding-style.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 6fa355e..fb43891 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -205,6 +205,10 @@ default:  // wrong
 	break;
 }
 =

+However if the enum comes from an external header file outside ofono
+we cannot make any assumption of how the enum is defined and this
+rule might not apply.
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.0.4


--===============7377905992733903659==--

