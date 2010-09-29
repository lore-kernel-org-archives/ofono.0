Content-Type: multipart/mixed; boundary="===============4122843044870659373=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 15/21] gprs: Add DUN +CGATT support in gprs atom
Date: Wed, 29 Sep 2010 17:44:55 +0800
Message-ID: <1285753501-7668-16-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4122843044870659373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN client may request to attach/deattach GPRS network. Use
gprs_netreg_update to set attach/deattach status.
---
 src/gprs.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index ccc6ca5..01babdc 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -39,6 +39,8 @@
 #include "common.h"
 #include "storage.h"
 #include "idmap.h"
+#include "gatserver.h"
+
 =

 #define GPRS_FLAG_ATTACHING 0x1
 #define GPRS_FLAG_RECHECK 0x2
@@ -1603,14 +1605,31 @@ void ofono_gprs_context_deactivated(struct ofono_gp=
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

1.7.0.4


--===============4122843044870659373==--

