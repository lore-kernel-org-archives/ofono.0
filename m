Content-Type: multipart/mixed; boundary="===============7019188327644086057=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Use stk_envelope_type constant name in sim.c
Date: Mon, 01 Mar 2010 05:38:29 +0100
Message-ID: <1267418309-17436-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7019188327644086057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 0ab399d..03d3e6e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -42,6 +42,7 @@
 #include "smsutil.h"
 #include "simutil.h"
 #include "storage.h"
+#include "stkutil.h"
 =

 #define SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 =

@@ -1824,7 +1825,7 @@ void __ofono_cbs_sim_download(struct ofono_sim *sim,
 	if (sim->driver->envelope =3D=3D NULL)
 		return;
 =

-	tlv[0] =3D 0xd2; /* Cell Broadcast Download */
+	tlv[0] =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
 	tlv[1] =3D 6 + pdu_len;
 	tlv[2] =3D 0x82; /* Device Identities */
 	tlv[3] =3D 0x02; /* Device Identities length */
-- =

1.6.1


--===============7019188327644086057==--

