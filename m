Content-Type: multipart/mixed; boundary="===============8494354267529910583=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 15/15] gprs: Add DUN +CGDCONT support in gprs atom
Date: Wed, 07 Jul 2010 18:01:52 +0800
Message-ID: <1278496912-13777-16-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-15-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8494354267529910583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN client could request to create new context in gprs atom.
---
 src/gprs.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 1f9e396..05a7a05 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1872,6 +1872,23 @@ static void ofono_emulator_set_cgatt(struct ofono_gp=
rs *gprs,
 	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
 }
 =

+static void ofono_emulator_set_cgdcont(struct ofono_gprs *gprs,
+				struct ofono_emulator_req *req)
+{
+	struct pri_context *context;
+
+	context =3D gprs_context_by_type(gprs, GPRS_CONTEXT_TYPE_DUN);
+	if (!context) {
+		context =3D ofono_gprs_create_context(gprs, "dun", "dun");
+		if (!context) {
+			req->cb(G_AT_SERVER_RESULT_ERROR, req->cb_data);
+			return;
+		}
+	}
+
+	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
+}
+
 static void dun_status_watch(struct ofono_emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data)
@@ -1896,6 +1913,9 @@ static void dun_status_watch(struct ofono_emulator *e,
 	case OFONO_EMULATOR_STATUS_SET_CGATT:
 		ofono_emulator_set_cgatt(gprs, data);
 		break;
+	case OFONO_EMULATOR_STATUS_SET_CGDCONT:
+		ofono_emulator_set_cgdcont(gprs, data);
+		break;
 	case OFONO_EMULATOR_STATUS_DESTROY:
 		ofono_emulator_remove_sources(gprs);
 		break;
-- =

1.6.3.3


--===============8494354267529910583==--

