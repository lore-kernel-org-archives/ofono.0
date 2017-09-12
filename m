Content-Type: multipart/mixed; boundary="===============6357577600189932572=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 1/3] Fix out of tree build
Date: Tue, 12 Sep 2017 12:52:35 +0200
Message-ID: <20170912105237.21750-2-jonas@southpole.se>
In-Reply-To: <20170912105237.21750-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6357577600189932572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common.c b/src/common.c
index d44b001..3ccaf7c 100644
--- a/src/common.c
+++ b/src/common.c
@@ -30,8 +30,8 @@
 #include <glib.h>
 =

 #include <ofono/types.h>
+#include <ofono/gprs-context.h>
 #include "common.h"
-#include "gprs-context.h"
 #include "util.h"
 =

 struct error_entry {
-- =

2.9.3


--===============6357577600189932572==--

