Content-Type: multipart/mixed; boundary="===============0952775554764431448=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 16/21] gprs: Add DUN +CGDCONT support in gprs atom
Date: Wed, 12 Jan 2011 18:15:59 +0100
Message-ID: <1294852564-1258-17-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0952775554764431448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

DUN client may request to define the APN of context. Find the existing
context and update the APN.
---
 src/gprs.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 580188e..0feb344 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -60,6 +60,13 @@
 static GSList *g_drivers =3D NULL;
 static GSList *g_context_drivers =3D NULL;
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
@@ -87,6 +94,7 @@ struct ofono_gprs {
 	struct ofono_emulator *dun;
 	unsigned int dun_watch;
 	unsigned int dun_status_watch;
+	struct gprs_dun_data dun_data;
 };
 =

 struct ofono_gprs_context {
@@ -2030,6 +2038,41 @@ static void ofono_gprs_set_cgatt(struct ofono_gprs *=
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
+		if (ctx->type !=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET)
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
@@ -2043,6 +2086,9 @@ static void dun_status_watch(struct ofono_emulator *e,
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

--===============0952775554764431448==--

