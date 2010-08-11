Content-Type: multipart/mixed; boundary="===============2432209416344833399=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/16] gprs: Add DUN +CGDCONT support in gprs atom
Date: Wed, 11 Aug 2010 10:26:36 +0800
Message-ID: <1281493601-14351-12-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2432209416344833399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN client may request to create a new context. Call
ofono_gprs_create_context to create it.
---
 src/gprs.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 7e85d39..2313f52 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -59,6 +59,13 @@ enum gprs_context_type {
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
@@ -84,6 +91,7 @@ struct ofono_gprs {
 	struct ofono_emulator *dun;
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
+	struct gprs_dun_data dun_data;
 };
 =

 struct ofono_gprs_context {
@@ -1542,6 +1550,48 @@ static void ofono_gprs_set_cgatt(struct ofono_gprs *=
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
+		if (!g_str_equal(req->apn, ctx->context.apn))
+			continue;
+
+		if (proto !=3D ctx->context.proto)
+			continue;
+
+		context =3D ctx;
+		break;
+	}
+
+	if (context)
+		goto done;
+
+	context =3D ofono_gprs_create_context(gprs, req->apn, "internet");
+	if (context =3D=3D NULL) {
+		req->cb(G_AT_SERVER_RESULT_ERROR, req->cb_data);
+		return;
+	}
+
+	strcpy(context->context.apn, req->apn);
+
+done:
+	data->context =3D context;
+	req->cb(G_AT_SERVER_RESULT_OK, req->cb_data);
+}
+
 static void dun_status_watch(struct ofono_emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data)
@@ -1555,6 +1605,9 @@ static void dun_status_watch(struct ofono_emulator *e,
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


--===============2432209416344833399==--

