Content-Type: multipart/mixed; boundary="===============3472198028275081954=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 3/3] gprs.c: add list contexts for emulator
Date: Mon, 21 Mar 2011 14:45:14 +0100
Message-ID: <1300715114-5790-4-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300715114-5790-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3472198028275081954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 04432c3..06d52f3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2863,11 +2863,31 @@ static void provision_contexts(struct ofono_gprs *g=
prs, const char *mcc,
 	__ofono_gprs_provision_free_settings(settings, count);
 }
 =

+static void ofono_gprs_list_contexts(struct ofono_emulator *em, void *user=
data)
+{
+	struct ofono_gprs *gprs =3D userdata;
+	GSList *l;
+	char buf[256];
+
+	struct pri_context *ctx;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		ctx =3D l->data;
+
+		snprintf(buf, 255, "+CGDCONT: %d,\"%s\",\"%s\"",
+				ctx->id, gprs_proto_to_string(ctx->context.proto),
+				ctx->context.apn);
+		ofono_emulator_send_info(em, buf, FALSE);
+	}
+}
+
 /* Process the usual AT+CGDCONT command
  */
 static void cgdcont_cb(struct ofono_emulator *em,
 			struct ofono_emulator_request *req, void *userdata)
 {
+	struct ofono_gprs *gprs =3D userdata;
+	struct idmap *cid =3D gprs->cid_map;
 	struct ofono_error result;
 	char buf[256];
 =

@@ -2876,7 +2896,8 @@ static void cgdcont_cb(struct ofono_emulator *em,
 	switch (ofono_emulator_request_get_type(req)) {
 	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
 		/* TODO: check additionnal parameters */
-		snprintf(buf, 255, "+CGDCONT: (1-2),\"IP\",,,(0-2),(0,1,2,3,4)");
+		snprintf(buf, 255, "+CGDCONT: (1-%d),\"IP\",,,(0-2),(0,1,2,3,4)",
+					idmap_get_size(cid));
 		ofono_emulator_send_info(em, buf, FALSE);
 		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
 		ofono_emulator_send_final(em, &result);
@@ -2888,7 +2909,8 @@ static void cgdcont_cb(struct ofono_emulator *em,
 		break;
 =

 	case OFONO_EMULATOR_REQUEST_TYPE_QUERY:
-		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_gprs_list_contexts(em, gprs);
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
 		ofono_emulator_send_final(em, &result);
 		break;
 	case OFONO_EMULATOR_REQUEST_TYPE_SET:
-- =

1.7.1


--===============3472198028275081954==--

