Content-Type: multipart/mixed; boundary="===============9206177609256750603=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/7] coding-style: Don't use hex with shift operator
Date: Sat, 05 Feb 2011 06:29:05 -0800
Message-ID: <1296916151-21778-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9206177609256750603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding-style.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 40bb36b..287e9e9 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -294,6 +294,18 @@ void foo()	// Wrong
 {
 }
 =

+M16: Don't use hex value with shift operators
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The expression argument to the shift operators should not be in hex.
+
+Example:
+
+1)
+1 << y
+
+2)
+0x1 << y	// Wrong
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.0.4


--===============9206177609256750603==--

