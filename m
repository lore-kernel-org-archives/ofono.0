Content-Type: multipart/mixed; boundary="===============8064466562290502586=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 02/14] atmodem: use macros for CLIP validity
Date: Mon, 06 Dec 2010 18:12:30 -0200
Message-ID: <1291666362-19128-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8064466562290502586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/voicecall.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index c04bd69..a2ee49d 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -39,6 +39,8 @@
 #include "gatchat.h"
 #include "gatresult.h"
 =

+#include  "common.h"
+
 #include "atmodem.h"
 =

 /* Amount of ms we wait between CLCC calls */
@@ -710,9 +712,9 @@ static void clip_notify(GAtResult *result, gpointer use=
r_data)
 		return;
 =

 	if (strlen(num) > 0)
-		validity =3D 0;
+		validity =3D CLIP_VALIDITY_VALID;
 	else
-		validity =3D 2;
+		validity =3D CLIP_VALIDITY_NOT_AVAILABLE;
 =

 	/* Skip subaddr, satype and alpha */
 	g_at_result_iter_skip_next(&iter);
-- =

1.7.3.2


--===============8064466562290502586==--

