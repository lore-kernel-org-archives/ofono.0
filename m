Content-Type: multipart/mixed; boundary="===============1870553143464245821=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 15/21] gprs: Add DUN +CGATT support in gprs atom
Date: Wed, 12 Jan 2011 18:15:58 +0100
Message-ID: <1294852564-1258-16-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1870553143464245821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

DUN client may request to attach/deattach GPRS network. Use
gprs_netreg_update to set attach/deattach status.
---
 src/gprs.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 05e1c70..580188e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -43,6 +43,8 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "gatserver.h"
+
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -2016,14 +2018,31 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
rs_context *gc,
 	}
 }
 =

+static void ofono_gprs_set_cgatt(struct ofono_gprs *gprs,
+				struct ofono_emulator_req *req)
+{
+	int *mode =3D req->data;
+
+	gprs->powered =3D *mode;
+
+	gprs_netreg_update(gprs);
+
+	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
+}
+
 static void dun_status_watch(struct ofono_emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data)
 {
+	struct ofono_gprs *gprs =3D user_data;
+
 	if (e =3D=3D NULL)
 		return;
 =

 	switch (status) {
+	case OFONO_EMULATOR_STATUS_SET_CGATT:
+		ofono_gprs_set_cgatt(gprs, data);
+		break;
 	default:
 		break;
 	}
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============1870553143464245821==--

