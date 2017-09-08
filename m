Content-Type: multipart/mixed; boundary="===============2046565345809442712=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: [PATCH 1/1] Fix compilation on armhf/Musl
Date: Fri, 08 Sep 2017 09:18:20 -0700
Message-ID: <20170908161820.GA3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2046565345809442712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following patch is needed to successfully build ofono on armhf with
musl (in place of libc)


diff --git a/gril/parcel.h b/gril/parcel.h
index e5592ae1..46887890 100644
--- a/gril/parcel.h
+++ b/gril/parcel.h
@@ -23,6 +23,7 @@
 #define __PARCEL_H

 #include <stdlib.h>
+#include <stdint.h>

 struct parcel {
        char *data;
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 011713e6..45ec0cf9 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -25,6 +25,7 @@

 #include <errno.h>
 #include <stdlib.h>
+#include <stdint.h>

 #include <glib.h>
 #include <gatchat.h>


--===============2046565345809442712==--

