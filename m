Content-Type: multipart/mixed; boundary="===============3567594482774996111=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 14/15] gprs: Add DUN +CGATT support in gprs atom
Date: Wed, 07 Jul 2010 18:01:51 +0800
Message-ID: <1278496912-13777-15-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-14-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3567594482774996111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN client may request us to attach/deattach GPRS network. In such case,
use gprs_netreg_update to update gprs status.
---
 src/gprs.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 3ed056a..1f9e396 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1860,6 +1860,18 @@ error:
 	req->cb(&error, NULL, NULL, NULL, NULL, req->cb_data);
 }
 =

+static void ofono_emulator_set_cgatt(struct ofono_gprs *gprs,
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
@@ -1881,6 +1893,9 @@ static void dun_status_watch(struct ofono_emulator *e,
 	case OFONO_EMULATOR_STATUS_DUN_DISCONNECTED:
 		ofono_emulator_dun_disconnect(gprs, data);
 		break;
+	case OFONO_EMULATOR_STATUS_SET_CGATT:
+		ofono_emulator_set_cgatt(gprs, data);
+		break;
 	case OFONO_EMULATOR_STATUS_DESTROY:
 		ofono_emulator_remove_sources(gprs);
 		break;
-- =

1.6.3.3


--===============3567594482774996111==--

