Content-Type: multipart/mixed; boundary="===============2732129559709615738=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 1/3] gprs.c: add emulator CGDCONT handler
Date: Mon, 21 Mar 2011 14:45:12 +0100
Message-ID: <1300715114-5790-2-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300715114-5790-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2732129559709615738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 00f6d6d..04432c3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -90,6 +90,7 @@ struct ofono_gprs {
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
 	unsigned int status_watch;
+	unsigned int dun_watch;
 	GKeyFile *settings;
 	char *imsi;
 	DBusMessage *pending;
@@ -2294,7 +2295,7 @@ struct ofono_modem *ofono_gprs_context_get_modem(stru=
ct ofono_gprs_context *gc)
 }
 =

 void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
-                                        enum ofono_gprs_context_type type)
+					enum ofono_gprs_context_type type)
 {
 	DBG("type %d", type);
 =

@@ -2862,12 +2863,63 @@ static void provision_contexts(struct ofono_gprs *g=
prs, const char *mcc,
 	__ofono_gprs_provision_free_settings(settings, count);
 }
 =

+/* Process the usual AT+CGDCONT command
+ */
+static void cgdcont_cb(struct ofono_emulator *em,
+			struct ofono_emulator_request *req, void *userdata)
+{
+	struct ofono_error result;
+	char buf[256];
+
+	result.error =3D 0;
+
+	switch (ofono_emulator_request_get_type(req)) {
+	case OFONO_EMULATOR_REQUEST_TYPE_SUPPORT:
+		/* TODO: check additionnal parameters */
+		snprintf(buf, 255, "+CGDCONT: (1-2),\"IP\",,,(0-2),(0,1,2,3,4)");
+		ofono_emulator_send_info(em, buf, FALSE);
+		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		ofono_emulator_send_final(em, &result);
+		break;
+
+	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+		break;
+
+	case OFONO_EMULATOR_REQUEST_TYPE_QUERY:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+		break;
+	case OFONO_EMULATOR_REQUEST_TYPE_SET:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+		break;
+	default:
+		result.type =3D OFONO_ERROR_TYPE_FAILURE;
+		ofono_emulator_send_final(em, &result);
+	};
+}
+
+static void gprs_dun_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
+		return;
+
+	ofono_emulator_add_handler(em, "+CGDCONT", cgdcont_cb, data, NULL);
+}
+
+
 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
 	const char *path =3D __ofono_atom_get_path(gprs->atom);
 	struct ofono_atom *netreg_atom;
+	struct ofono_atom *dun_atom;
 =

 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
@@ -2896,6 +2948,16 @@ static void ofono_gprs_finish_register(struct ofono_=
gprs *gprs)
 		netreg_watch(netreg_atom,
 				OFONO_ATOM_WATCH_CONDITION_REGISTERED, gprs);
 =

+	gprs->dun_watch =3D __ofono_modem_add_atom_watch(modem,
+						OFONO_ATOM_TYPE_EMULATOR_DUN,
+						gprs_dun_watch, gprs, NULL);
+
+	dun_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_EMULATOR_DUN);
+
+	if (dun_atom && __ofono_atom_get_registered(dun_atom))
+		gprs_dun_watch(dun_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+				gprs);
+
 	__ofono_atom_register(gprs->atom, gprs_unregister);
 }
 =

-- =

1.7.1


--===============2732129559709615738==--

