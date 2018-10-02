Content-Type: multipart/mixed; boundary="===============1564261489818428029=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simauth: fix gsmAuthenticate
Date: Tue, 02 Oct 2018 15:41:51 -0700
Message-ID: <20181002224151.12385-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1564261489818428029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The input to the comp128 algorithm was relying on QSTRING_TO_BUF
returning a pointer to persistant memory. This was not the case
as it was returning a pointer to an intermediate object which was
being freed once out of scope. It just happened to work most of
the time. This change copies ki/rand into a static buffer.
---
 src/simauth.cpp | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/simauth.cpp b/src/simauth.cpp
index 24b2d17..93b8826 100644
--- a/src/simauth.cpp
+++ b/src/simauth.cpp
@@ -42,10 +42,13 @@ SimAuth::~SimAuth()
 void SimAuth::gsmAuthenticate( QString rand, QString &sres,
         QString &kc )
 {
-    uint8_t *ki =3D QSTRING_TO_BUF( _ki );
-    uint8_t *_rand =3D QSTRING_TO_BUF( rand );
-    uint8_t _sres[4];
-    uint8_t _kc[8];
+    uint8_t ki[16];
+    uint8_t _rand[16];
+    uint8_t _sres[4] =3D { 0 };
+    uint8_t _kc[8] =3D { 0 };
+
+    memcpy(ki, QSTRING_TO_BUF( _ki ), 16);
+    memcpy(_rand, QSTRING_TO_BUF( rand ), 16);
 =

     comp128( ki, _rand, _sres, _kc );
 =

-- =

2.17.1


--===============1564261489818428029==--

