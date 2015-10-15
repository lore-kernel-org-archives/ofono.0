Content-Type: multipart/mixed; boundary="===============5528329865181091254=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 04/10] ril: Adapt to movement of parcel processing
Date: Thu, 15 Oct 2015 18:46:57 +0200
Message-ID: <1444927623-31141-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5528329865181091254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index e27c98c..e31f24b 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -58,9 +58,9 @@
 =

 #include "ofono.h"
 =

-#include <grilreply.h>
-#include <grilrequest.h>
-#include <grilunsol.h>
+#include <drivers/rilmodem/rilreply.h>
+#include <drivers/rilmodem/rilrequest.h>
+#include <drivers/rilmodem/rilunsol.h>
 =

 #include "ril.h"
 #include "drivers/rilmodem/rilmodem.h"
@@ -364,8 +364,13 @@ static int create_gril(struct ofono_modem *modem)
 		ofono_error("g_ril_new() failed to create modem!");
 		return -EIO;
 	}
+
 	g_ril_set_slot(rd->ril, slot_id);
 =

+	g_ril_set_vendor_print_msg_id_funcs(rd->ril,
+						ril_request_id_to_string,
+						ril_unsol_request_to_string);
+
 	if (getenv("OFONO_RIL_TRACE"))
 		g_ril_set_trace(rd->ril, TRUE);
 =

-- =

2.1.4


--===============5528329865181091254==--

