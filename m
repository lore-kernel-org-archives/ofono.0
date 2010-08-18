Content-Type: multipart/mixed; boundary="===============5941742888661424842=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] simfilesystem: correct sw2 response for binary read
Date: Wed, 18 Aug 2010 04:14:54 -0700
Message-ID: <1282130094-7586-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5941742888661424842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

according to spec, sw2 should be the number of bytes read, which
is just length.
---
 src/simfilesystem.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/simfilesystem.cpp b/src/simfilesystem.cpp
index d193328..6e05039 100644
--- a/src/simfilesystem.cpp
+++ b/src/simfilesystem.cpp
@@ -226,7 +226,7 @@ void SimFileSystem::crsm( const QString& args )
                     sw2 =3D 0x02;
                 } else if ( length ) {
                     sw1 =3D 0x9f;
-                    sw2 =3D length - offset;
+                    sw2 =3D length;
                     response =3D
                         QAtUtils::toHex( contents.mid( offset, length ) );
                 } else {
-- =

1.7.2.1


--===============5941742888661424842==--

