Content-Type: multipart/mixed; boundary="===============5509698435851993268=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/3] src: Set IA APN when gprs atom is created
Date: Wed, 11 Nov 2015 15:38:38 +0100
Message-ID: <1447252719-9284-2-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447252719-9284-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5509698435851993268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 64 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 344915c..116074a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -177,6 +177,8 @@ static const char *gprs_context_default_name(enum ofono=
_gprs_context_type type)
 		return "WAP";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "IMS";
+	case OFONO_GPRS_CONTEXT_TYPE_IA:
+		return "IA";
 	}
 =

 	return NULL;
@@ -196,6 +198,8 @@ static const char *gprs_context_type_to_string(
 		return "wap";
 	case OFONO_GPRS_CONTEXT_TYPE_IMS:
 		return "ims";
+	case OFONO_GPRS_CONTEXT_TYPE_IA:
+		return "ia";
 	}
 =

 	return NULL;
@@ -216,6 +220,9 @@ static gboolean gprs_context_string_to_type(const char =
*str,
 	} else if (g_str_equal(str, "ims")) {
 		*out =3D OFONO_GPRS_CONTEXT_TYPE_IMS;
 		return TRUE;
+	} else if (g_str_equal(str, "ia")) {
+		*out =3D OFONO_GPRS_CONTEXT_TYPE_IA;
+		return TRUE;
 	}
 =

 	return FALSE;
@@ -3159,6 +3166,60 @@ remove:
 		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
 }
 =

+static struct pri_context *gprs_context_for_ia(struct ofono_gprs *gprs)
+{
+	GSList *l;
+	struct pri_context *ctx_inet =3D NULL;
+
+	for (l =3D gprs->contexts; l; l =3D l->next) {
+		struct pri_context *ctx =3D l->data;
+
+		if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_IA)
+			return ctx;
+		else if (ctx->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_INTERNET
+				&& ctx_inet =3D=3D NULL)
+			ctx_inet =3D ctx;
+	}
+
+	if (ctx_inet !=3D NULL)
+		return ctx_inet;
+
+	if (gprs->contexts =3D=3D NULL)
+		return NULL;
+
+	return gprs->contexts->data;
+}
+
+static void set_ia_apn_cb(const struct ofono_error *error, void *data)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_error("Could not set IA APN");
+}
+
+static void set_ia_apn(struct ofono_gprs *gprs)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	struct pri_context *ctx =3D gprs_context_for_ia(gprs);
+	struct ofono_gprs_primary_context *ofono_ctx;
+	char mccmnc[OFONO_MAX_MCC_LENGTH + OFONO_MAX_MNC_LENGTH + 1];
+	const char *mcc =3D ofono_sim_get_mcc(sim);
+	const char *mnc =3D ofono_sim_get_mnc(sim);
+
+	if (ctx =3D=3D NULL)
+		return;
+
+	ofono_ctx =3D &ctx->context;
+
+	strcpy(mccmnc, mcc);
+	strcpy(mccmnc + strlen(mcc), mnc);
+
+	gprs->driver->set_ia_apn(gprs, ofono_ctx->apn, ofono_ctx->proto,
+					ofono_ctx->username,
+					ofono_ctx->password, mccmnc,
+					set_ia_apn_cb, gprs);
+}
+
 static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -3168,6 +3229,9 @@ static void ofono_gprs_finish_register(struct ofono_g=
prs *gprs)
 	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
 		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);
 =

+	if (gprs->driver->set_ia_apn)
+		set_ia_apn(gprs);
+
 	if (!g_dbus_register_interface(conn, path,
 					OFONO_CONNECTION_MANAGER_INTERFACE,
 					manager_methods, manager_signals, NULL,
-- =

2.5.0


--===============5509698435851993268==--

