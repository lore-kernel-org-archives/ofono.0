Content-Type: multipart/mixed; boundary="===============9208209972167331347=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Read EF-SPDI and use it for SPN display.
Date: Sun, 21 Jun 2009 03:40:48 +0200
Message-ID: <1245548448-6757-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9208209972167331347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the operator is one of those listed in EF-SPDI then we need to
treat it like a HPLMN in deciding whether the SPN or PLMN name should
be displayed.
---
I was also going to try implementing the semantics described in EF-PNN /
EF-OPL but I have not found evidence that it's not already handled by the
modem in the responses to +COPN (i.e. it may already be taking care to
substitute the network names?  is this specified somewhere or would this
be very unlikely?)

Regards
---
 src/network.c |    7 ++-
 src/sim.c     |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/sim.h     |    3 +
 3 files changed, 176 insertions(+), 1 deletions(-)

diff --git a/src/network.c b/src/network.c
index a437f0d..43fa2ab 100644
--- a/src/network.c
+++ b/src/network.c
@@ -328,6 +328,7 @@ static char *get_operator_display_name(struct ofono_mod=
em *modem)
 	const char *plmn;
 	char *name =3D netreg->display_name;
 	int len =3D sizeof(netreg->display_name);
+	int home_or_spdi;
 =

 	/* The name displayed to user depends on whether we're in a home
 	 * PLMN or roaming and on configuration bits from the SIM, all
@@ -345,7 +346,11 @@ static char *get_operator_display_name(struct ofono_mo=
dem *modem)
 =

 	plmn =3D netreg->current_operator->name;
 =

-	if (netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+	home_or_spdi =3D
+		(netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED) ||
+		ofono_operator_in_spdi(modem, netreg->current_operator);
+
+	if (home_or_spdi)
 		if (netreg->flags & NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN)
 			/* Case 1 */
 			snprintf(name, len, "%s (%s)", netreg->spname, plmn);
diff --git a/src/sim.c b/src/sim.c
index a8b7d5f..572f6a8 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -53,6 +53,8 @@ struct sim_manager_data {
 =

 	GSList *update_spn_notify;
 =

+	GSList *spdi;
+
 	int own_numbers_num;
 	int own_numbers_size;
 	int own_numbers_current;
@@ -80,6 +82,44 @@ static char **get_own_numbers(GSList *own_numbers)
 	return ret;
 }
 =

+/* Parse ASN.1 Basic Encoding Rules TLVs per ISO/IEC 7816 */
+static const guint8 *ber_tlv_find_by_tag(const guint8 *pdu, guint8 in_tag,
+						int in_len, int *out_len)
+{
+	guint8 tag;
+	int len;
+	const guint8 *end =3D pdu + in_len;
+
+	do {
+		while (pdu < end && (*pdu =3D=3D 0x00 || *pdu =3D=3D 0xff))
+			pdu ++;
+		if (pdu =3D=3D end)
+			break;
+
+		tag =3D *pdu ++;
+		if (!(0x1f & ~tag))
+			while (pdu < end && (*pdu ++ & 0x80));
+		if (pdu =3D=3D end)
+			break;
+
+		for (len =3D 0; pdu + 1 < end && (*pdu & 0x80);
+				len =3D (len | (*pdu ++ & 0x7f)) << 7);
+		if (*pdu & 0x80)
+			break;
+		len |=3D *pdu ++;
+
+		if (tag =3D=3D in_tag && pdu + len <=3D end) {
+			if (out_len)
+				*out_len =3D len;
+			return pdu;
+		}
+
+		pdu +=3D len;
+	} while (pdu < end);
+
+	return NULL;
+}
+
 static struct sim_manager_data *sim_manager_create()
 {
 	return g_try_new0(struct sim_manager_data, 1);
@@ -105,6 +145,12 @@ static void sim_manager_destroy(gpointer userdata)
 		g_free(data->spn);
 		data->spn =3D NULL;
 	}
+
+	if (data->spdi) {
+		g_slist_foreach(data->spdi, (GFunc)g_free, NULL);
+		g_slist_free(data->spdi);
+		data->spdi =3D NULL;
+	}
 }
 =

 static DBusMessage *sim_get_properties(DBusConnection *conn,
@@ -156,6 +202,7 @@ static GDBusSignalTable sim_manager_signals[] =3D { { }=
 };
 enum sim_fileids {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
+	SIM_EFSPDI_FILEID =3D 0x6fcd,
 };
 =

 #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
@@ -338,6 +385,123 @@ static gboolean sim_retrieve_own_number(void *user_da=
ta)
 	return FALSE;
 }
 =

+struct spdi_operator {
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+};
+
+static struct spdi_operator *spdi_operator_alloc(const guint8 *bcd)
+{
+	struct spdi_operator *spdi =3D g_new0(struct spdi_operator, 1);
+	char *mcc =3D spdi->mcc;
+	char *mnc =3D spdi->mnc;
+	guint8 digit;
+
+	digit =3D (bcd[0] >> 0) & 0xf;
+	if (digit !=3D 0xf)
+		*mcc ++ =3D '0' + digit;
+	digit =3D (bcd[0] >> 4) & 0xf;
+	if (digit !=3D 0xf)
+		*mcc ++ =3D '0' + digit;
+	digit =3D (bcd[1] >> 0) & 0xf;
+	if (digit !=3D 0xf)
+		*mcc ++ =3D '0' + digit;
+	digit =3D (bcd[2] >> 0) & 0xf;
+	if (digit !=3D 0xf)
+		*mnc ++ =3D '0' + digit;
+	digit =3D (bcd[2] >> 4) & 0xf;
+	if (digit !=3D 0xf)
+		*mnc ++ =3D '0' + digit;
+	digit =3D (bcd[1] >> 4) & 0xf;
+	if (digit !=3D 0xf)
+		*mnc ++ =3D '0' + digit;
+
+	return spdi;
+}
+
+static gint spdi_operator_compare(gconstpointer a, gconstpointer b)
+{
+	const struct spdi_operator *opa =3D a;
+	const struct spdi_operator *opb =3D b;
+
+	return strcmp(opa->mcc, opb->mcc) ?: strcmp(opa->mnc, opb->mnc);
+}
+
+int ofono_operator_in_spdi(struct ofono_modem *modem,
+				const struct ofono_network_operator *op)
+{
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct spdi_operator spdi_op;
+
+	if (!sim)
+		return FALSE;
+
+	g_strlcpy(spdi_op.mcc, op->mcc, sizeof(spdi_op.mcc));
+	g_strlcpy(spdi_op.mnc, op->mnc, sizeof(spdi_op.mnc));
+
+	return !!g_slist_find_custom(sim->spdi,
+			&spdi_op, spdi_operator_compare);
+}
+
+static void sim_spdi_read_cb(const struct ofono_error *error,
+				const unsigned char *spdidata,
+				int length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	const guint8 *plmn_list;
+	struct spdi_operator *spdi;
+	GSList *l;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length <=3D 5)
+		return;
+
+	plmn_list =3D ber_tlv_find_by_tag(spdidata, 0x80, length, &length);
+	if (!plmn_list) {
+		ofono_debug("Couldn't parse the EF-SPDI contents as a TLV");
+		return;
+	}
+
+	for (length /=3D 3; length --; plmn_list +=3D 3) {
+		if ((plmn_list[0] & plmn_list[1] & plmn_list[2]) =3D=3D 0xff)
+			continue;
+
+		sim->spdi =3D g_slist_insert_sorted(sim->spdi,
+				spdi_operator_alloc(plmn_list),
+				spdi_operator_compare);
+	}
+
+	if (sim->spdi)
+		for (l =3D sim->update_spn_notify; l; l =3D l->next)
+			sim_spn_notify(modem, l->data);
+}
+
+static void sim_spdi_info_cb(const struct ofono_error *error, int length,
+				enum ofono_sim_file_structure structure,
+				int dummy, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length <=3D 5 ||
+			structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
+		return;
+
+	sim->ops->read_file_transparent(modem, SIM_EFSPDI_FILEID, 0, length,
+					sim_spdi_read_cb, modem);
+}
+
+static gboolean sim_retrieve_spdi(void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	sim->ops->read_file_info(modem, SIM_EFSPDI_FILEID,
+					sim_spdi_info_cb, modem);
+
+	return FALSE;
+}
+
 static void initialize_sim_manager(struct ofono_modem *modem)
 {
 	DBusConnection *conn =3D dbus_gsm_connection();
@@ -367,6 +531,9 @@ static void initialize_sim_manager(struct ofono_modem *=
modem)
 =

 	if (modem->sim_manager->ops->read_file_linear)
 		g_timeout_add(0, sim_retrieve_own_number, modem);
+
+	if (modem->sim_manager->ops->read_file_transparent)
+		g_timeout_add(0, sim_retrieve_spdi, modem);
 }
 =

 int ofono_sim_manager_register(struct ofono_modem *modem,
diff --git a/src/sim.h b/src/sim.h
index e0b471d..9456934 100644
--- a/src/sim.h
+++ b/src/sim.h
@@ -28,3 +28,6 @@ int ofono_spn_update_notify_register(struct ofono_modem *=
modem,
 		update_spn_cb cb);
 int ofono_spn_update_notify_unregister(struct ofono_modem *modem,
 		update_spn_cb cb);
+
+int ofono_operator_in_spdi(struct ofono_modem *modem,
+				const struct ofono_network_operator *op);
-- =

1.6.0


--===============9208209972167331347==--

