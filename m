Content-Type: multipart/mixed; boundary="===============5994513783152381651=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 16/21] gprs: Add DUN +CGDCONT support in gprs atom
Date: Wed, 29 Sep 2010 17:44:56 +0800
Message-ID: <1285753501-7668-17-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5994513783152381651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN client may request to define the APN of context. Find the existing
context and update the APN.
---
 src/gprs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 01babdc..617ed05 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -61,6 +61,13 @@ enum gprs_context_type {
 	GPRS_CONTEXT_TYPE_INVALID,
 };
 =

+struct gprs_dun_data {
+	ofono_emulator_gprs_connect_cb cb;
+	void *cb_data;
+	struct pri_context *context;
+	struct pri_context *dun;
+};
+
 struct ofono_gprs {
 	GSList *contexts;
 	ofono_bool_t attached;
@@ -88,6 +95,7 @@ struct ofono_gprs {
 	struct ofono_emulator *dun;
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
+	struct gprs_dun_data dun_data;
 };
 =

 struct ofono_gprs_context {
@@ -1617,6 +1625,41 @@ static void ofono_gprs_set_cgatt(struct ofono_gprs *=
gprs,
 	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
 }
 =

+static void ofono_gprs_set_cgdcont(struct ofono_gprs *gprs,
+				struct ofono_emulator_gprs_context_req *req)
+{
+	struct gprs_dun_data *data =3D &gprs->dun_data;
+	struct pri_context *context =3D NULL;
+	enum ofono_gprs_proto proto;
+	GSList *l;
+
+	gprs_proto_from_string(req->proto, &proto);
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->type !=3D GPRS_CONTEXT_TYPE_INTERNET)
+			continue;
+
+		if (proto !=3D ctx->context.proto)
+			continue;
+
+		context =3D ctx;
+		break;
+	}
+
+	if (context =3D=3D NULL)
+		goto error;
+
+	strcpy(context->context.apn, req->apn);
+	data->context =3D context;
+	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
+
+	return;
+error:
+	req->cb(G_AT_SERVER_RESULT_ERROR, req->cb_data);
+}
+
 static void dun_status_watch(struct ofono_emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data)
@@ -1630,6 +1673,9 @@ static void dun_status_watch(struct ofono_emulator *e,
 	case OFONO_EMULATOR_STATUS_SET_CGATT:
 		ofono_gprs_set_cgatt(gprs, data);
 		break;
+	case OFONO_EMULATOR_STATUS_SET_CGDCONT:
+		ofono_gprs_set_cgdcont(gprs, data);
+		break;
 	default:
 		break;
 	}
-- =

1.7.0.4


--===============5994513783152381651==--

