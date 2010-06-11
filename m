Content-Type: multipart/mixed; boundary="===============2412541470988532761=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/15] stkutil: Add the Terminal Applications envelope builder
Date: Fri, 11 Jun 2010 12:39:57 +0200
Message-ID: <1276252800-27515-12-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2412541470988532761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is not a terribly useful function as the user still needs to
split the list in separate envelopes.  The .type field could be an
enum.
---
 src/stkutil.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |    7 +++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index f3610d8..9d25143 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4428,6 +4428,38 @@ static gboolean build_dataobj_last_envelope(struct s=
tk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 102.223 Section 8.88 */
+static gboolean build_dataobj_registry_application_data(
+						struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_registry_application_data *rad =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_REGISTRY_APPLICATION_DATA;
+	guint8 dcs, *name;
+	gsize len;
+	long gsmlen;
+
+	name =3D convert_utf8_to_gsm(rad->name, -1, NULL, &gsmlen, 0);
+	len =3D gsmlen;
+	dcs =3D 0x04;
+	if (name =3D=3D NULL) {
+		name =3D (guint8 *) g_convert((const gchar *) rad->name, -1,
+						"UCS-2BE", "UTF-8//TRANSLIT",
+						NULL, &len, NULL);
+		dcs =3D 0x08;
+
+		if (name =3D=3D NULL)
+			return FALSE;
+	}
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_short(tlv, rad->port) &&
+		stk_tlv_builder_append_byte(tlv, dcs) &&
+		stk_tlv_builder_append_byte(tlv, rad->type) &&
+		stk_tlv_builder_append_bytes(tlv, name, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.90 */
 static gboolean build_dataobj_broadcast_network_information(
 						struct stk_tlv_builder *tlv,
@@ -5068,6 +5100,28 @@ static gboolean build_envelope_event_download(struct=
 stk_tlv_builder *builder,
 	}
 }
 =

+static gboolean build_envelope_terminal_apps(struct stk_tlv_builder *build=
er,
+					const struct stk_envelope *envelope)
+{
+	const struct stk_envelope_terminal_apps *ta =3D &envelope->terminal_apps;
+	int i;
+
+	if (build_dataobj(builder,
+				build_envelope_dataobj_device_ids,
+				DATAOBJ_FLAG_CR, envelope, NULL) =3D=3D FALSE)
+		return FALSE;
+
+	for (i =3D 0; i < ta->count; i++)
+		if (build_dataobj(builder,
+					build_dataobj_registry_application_data,
+					0, &ta->list[i], NULL) =3D=3D FALSE)
+			return FALSE;
+
+	return build_dataobj(builder,
+				build_dataobj_last_envelope,
+				0, &ta->last, NULL);
+}
+
 const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
 						unsigned int *out_length)
 {
@@ -5187,6 +5241,9 @@ const unsigned char *stk_pdu_from_envelope(const stru=
ct stk_envelope *envelope,
 					&envelope->mms_notification.last,
 					NULL);
 		break;
+	case STK_ENVELOPE_TYPE_TERMINAL_APP:
+		ok =3D build_envelope_terminal_apps(&builder, envelope);
+		break;
 	default:
 		return NULL;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index dac8dcc..eb59fed 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1452,6 +1452,12 @@ struct stk_envelope_mms_notification_download {
 	ofono_bool_t last;
 };
 =

+struct stk_envelope_terminal_apps {
+	struct stk_registry_application_data *list;
+	int count;
+	ofono_bool_t last;
+};
+
 struct stk_envelope {
 	enum stk_envelope_type type;
 	enum stk_device_identity_type src;
@@ -1467,6 +1473,7 @@ struct stk_envelope {
 		struct stk_envelope_ussd_data_download ussd_data_download;
 		struct stk_envelope_mms_transfer_status mms_status;
 		struct stk_envelope_mms_notification_download mms_notification;
+		struct stk_envelope_terminal_apps terminal_apps;
 	};
 };
 =

-- =

1.7.1.86.g0e460.dirty


--===============2412541470988532761==--

