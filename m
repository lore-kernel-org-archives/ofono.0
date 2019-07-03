Content-Type: multipart/mixed; boundary="===============2028322407125598558=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 01/10] gatresult: include glib header
Date: Wed, 03 Jul 2019 20:09:46 +0200
Message-ID: <20190703180955.18246-2-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2028322407125598558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The gatresult data types embeds GSList members, and the function
prototypes uses glib types.

Add include of glib.h to allow use of gatresult.h without also including
glib.h
---
 gatchat/gatresult.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gatchat/gatresult.h b/gatchat/gatresult.h
index 589dd3dd..e92d38ba 100644
--- a/gatchat/gatresult.h
+++ b/gatchat/gatresult.h
@@ -22,6 +22,8 @@
 #ifndef __GATCHAT_RESULT_H
 #define __GATCHAT_RESULT_H
 =

+#include <glib.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- =

2.22.0


--===============2028322407125598558==--

