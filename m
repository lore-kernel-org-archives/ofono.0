Content-Type: multipart/mixed; boundary="===============2379769239953463119=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH 2/2] stemodem: Use macro for context status.
Date: Fri, 14 Jan 2011 12:17:21 +0100
Message-ID: <1295003841-11203-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2379769239953463119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 drivers/stemodem/gprs-context.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 1762fb3..39b5fb5 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -48,6 +48,7 @@
 #include "caif_socket.h"
 #include "if_caif.h"
 #include "caif_rtnl.h"
+#include "common.h"
 =

 #define MAX_CAIF_DEVICES 4
 #define MAX_DNS 2
@@ -500,7 +501,7 @@ static void ste_cgact_read_cb(gboolean ok, GAtResult *r=
esult,
 		if (!g_at_result_iter_next_number(&iter, &state))
 			continue;
 =

-		if (state =3D=3D 1)
+		if (state =3D=3D CONTEXT_STATUS_ACTIVATED)
 			continue;
 =

 		ofono_gprs_context_deactivated(gc, gcd->active_context);
-- =

1.7.1


--===============2379769239953463119==--

