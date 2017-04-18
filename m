Content-Type: multipart/mixed; boundary="===============2164443017847933395=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 2/6] ofono: add missing header inclusions
Date: Tue, 18 Apr 2017 09:50:48 +0200
Message-ID: <20170418075052.23980-2-jonas@southpole.se>
In-Reply-To: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2164443017847933395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a "leaf" header and doesn't even have header guards, but
it still seems natural that the header should pull in its own declarations
rather than relying on the including source file to ensure that they
are included.
---
 src/common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/common.h b/src/common.h
index ef4c58d..05f2a85 100644
--- a/src/common.h
+++ b/src/common.h
@@ -19,6 +19,10 @@
  *
  */
 =

+#include <glib.h>
+
+#include <ofono/types.h>
+
 /* 27.007 Section 7.3 <AcT> */
 enum access_technology {
 	ACCESS_TECHNOLOGY_GSM =3D			0,
-- =

2.9.3


--===============2164443017847933395==--

