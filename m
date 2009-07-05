Content-Type: multipart/mixed; boundary="===============4047032762626597049=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Read EF-PNN, EF-OPL and override network names accordingly.
Date: Sun, 05 Jul 2009 05:14:15 +0200
Message-ID: <1246763655-17301-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4047032762626597049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/driver.h  |    2 +
 src/network.c |   54 ++++++----
 src/sim.c     |  315 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/sim.h     |    4 +
 4 files changed, 345 insertions(+), 30 deletions(-)

diff --git a/src/driver.h b/src/driver.h
index f324c1c..595c980 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -84,6 +84,8 @@ struct ofono_network_operator {
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 	int status;
 	int tech;
+
+	const char *override_name;
 };
 =

 /* 27.007 Section 7.11 Call Forwarding */
diff --git a/src/network.c b/src/network.c
index 5419a97..eab3cde 100644
--- a/src/network.c
+++ b/src/network.c
@@ -339,13 +339,15 @@ static char *get_operator_display_name(struct ofono_m=
odem *modem)
 		return name;
 	}
 =

+	plmn =3D netreg->current_operator->name;
+	if (netreg->current_operator->override_name)
+		plmn =3D netreg->current_operator->override_name;
+
 	if (!netreg->spname || strlen(netreg->spname) =3D=3D 0) {
-		g_strlcpy(name, netreg->current_operator->name, len);
+		g_strlcpy(name, plmn, len);
 		return name;
 	}
 =

-	plmn =3D netreg->current_operator->name;
-
 	home_or_spdi =3D
 		(netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED) ||
 		ofono_operator_in_spdi(modem, netreg->current_operator);
@@ -383,20 +385,22 @@ static void set_network_operator_name(struct ofono_mo=
dem *modem,
 	strncpy(op->name, name, OFONO_MAX_OPERATOR_NAME_LENGTH);
 	op->name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
 =

-	path =3D network_operator_build_path(modem, op);
+	if (!op->override_name) {
+		path =3D network_operator_build_path(modem, op);
 =

-	dbus_gsm_signal_property_changed(conn, path,
-				NETWORK_OPERATOR_INTERFACE,
-				"Name", DBUS_TYPE_STRING,
-				&name);
+		dbus_gsm_signal_property_changed(conn, path,
+					NETWORK_OPERATOR_INTERFACE,
+					"Name", DBUS_TYPE_STRING,
+					&name);
 =

-	if (op =3D=3D netreg->current_operator) {
-		operator =3D get_operator_display_name(modem);
+		if (op =3D=3D netreg->current_operator) {
+			operator =3D get_operator_display_name(modem);
 =

-		dbus_gsm_signal_property_changed(conn, modem->path,
-					NETWORK_REGISTRATION_INTERFACE,
-					"Operator", DBUS_TYPE_STRING,
-					&operator);
+			dbus_gsm_signal_property_changed(conn, modem->path,
+						NETWORK_REGISTRATION_INTERFACE,
+						"Operator", DBUS_TYPE_STRING,
+						&operator);
+		}
 	}
 }
 =

@@ -413,6 +417,9 @@ static DBusMessage *network_operator_get_properties(DBu=
sConnection *conn,
 	const char *status =3D
 		network_operator_status_to_string(op->operator->status);
 =

+	if (op->operator->override_name)
+		name =3D op->operator->override_name;
+
 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -852,6 +859,13 @@ void ofono_network_registration_notify(struct ofono_mo=
dem *modem, int status,
 	}
 }
 =

+static void network_operator_name_override(struct ofono_modem *modem,
+					struct ofono_network_operator *op)
+{
+	op->override_name =3D
+		ofono_operator_name_sim_override(modem, op->mcc, op->mnc);
+}
+
 static void operator_list_callback(const struct ofono_error *error, int to=
tal,
 					const struct ofono_network_operator *list,
 					void *data)
@@ -890,11 +904,12 @@ static void operator_list_callback(const struct ofono=
_error *error, int total,
 		} else {
 			/* New operator */
 			struct ofono_network_operator *op =3D
-				g_try_new0(struct ofono_network_operator, 1);
+				g_memdup(&list[i],
+					sizeof(struct ofono_network_operator));
 			if (!op)
 				continue;
 =

-			memcpy(op, &list[i], sizeof(struct ofono_network_operator));
+			network_operator_name_override(modem, op);
 =

 			if (network_operator_dbus_register(modem, op)) {
 				n =3D g_slist_prepend(n, op);
@@ -968,15 +983,14 @@ static void current_operator_callback(const struct of=
ono_error *error,
 =

 	if (current) {
 		netreg->current_operator =3D
-			g_try_new0(struct ofono_network_operator, 1);
-
+			g_memdup(current,
+				sizeof(struct ofono_network_operator));
 		if (!netreg->current_operator) {
 			ofono_error("Unable to allocate current operator");
 			return;
 		}
 =

-		memcpy(netreg->current_operator, current,
-			sizeof(struct ofono_network_operator));
+		network_operator_name_override(modem, netreg->current_operator);
 =

 		netreg->operator_list =3D g_slist_append(netreg->operator_list,
 						netreg->current_operator);
diff --git a/src/sim.c b/src/sim.c
index a5d2164..13557bf 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -58,6 +58,16 @@ struct sim_manager_data {
 	int own_numbers_num;
 	int own_numbers_size;
 	int own_numbers_current;
+
+	GSList *opl;
+	int opl_num;
+	int opl_size;
+	int opl_current;
+
+	struct pnn_operator *pnn;
+	int pnn_num;
+	int pnn_size;
+	int pnn_current;
 };
 =

 static char **get_own_numbers(GSList *own_numbers)
@@ -120,6 +130,11 @@ static const guint8 *ber_tlv_find_by_tag(const guint8 =
*pdu, guint8 in_tag,
 	return NULL;
 }
 =

+struct pnn_operator {
+	char *longname;
+	char *shortname;
+};
+
 static struct sim_manager_data *sim_manager_create()
 {
 	return g_try_new0(struct sim_manager_data, 1);
@@ -129,6 +144,7 @@ static void sim_manager_destroy(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
 	struct sim_manager_data *data =3D modem->sim_manager;
+	int i;
 =

 	if (data->imsi) {
 		g_free(data->imsi);
@@ -151,6 +167,24 @@ static void sim_manager_destroy(gpointer userdata)
 		g_slist_free(data->spdi);
 		data->spdi =3D NULL;
 	}
+
+	if (data->opl) {
+		g_slist_foreach(data->opl, (GFunc)g_free, NULL);
+		g_slist_free(data->opl);
+		data->opl =3D NULL;
+	}
+
+	if (data->pnn) {
+		for (i =3D 0; i < data->pnn_num; i ++) {
+			if (data->pnn[i].longname)
+				g_free(data->pnn[i].longname);
+			if (data->pnn[i].shortname)
+				g_free(data->pnn[i].shortname);
+		}
+		g_free(data->pnn);
+		data->pnn =3D NULL;
+		data->pnn_num =3D 0;
+	}
 }
 =

 static DBusMessage *sim_get_properties(DBusConnection *conn,
@@ -199,6 +233,37 @@ static GDBusMethodTable sim_manager_methods[] =3D {
 =

 static GDBusSignalTable sim_manager_signals[] =3D { { } };
 =

+static char *network_name_parse(const unsigned char *buffer, int length)
+{
+	unsigned char *endp;
+	unsigned int dcs;
+
+	if (length < 1)
+		return NULL;
+
+	dcs =3D *buffer ++;
+	length --;
+
+	if (dcs & (1 << 3)) {
+		/* TODO: "The MS should add the letters for the Country's
+		 * Initials and a separator (e.g. a space)" */
+	}
+
+	switch (dcs & (7 << 4)) {
+	case 0x00:
+		endp =3D memchr(buffer, 0xff, length);
+		if (endp)
+			length =3D endp - buffer;
+		return convert_gsm_to_utf8(buffer, length,
+				NULL, NULL, 0xff);
+	case 0x10:
+		return convert_ucs2_to_utf8(buffer, length,
+				NULL, NULL, 0xffff);
+	}
+
+	return NULL;
+}
+
 static char *sim_alpha_field_parse(const unsigned char *buffer, int length)
 {
 	long utf_len, char_len;
@@ -311,6 +376,8 @@ static char *sim_alpha_field_parse(const unsigned char =
*buffer, int length)
 enum sim_fileids {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
+	SIM_EFPNN_FILEID =3D 0x6fc5,
+	SIM_EFOPL_FILEID =3D 0x6fc6,
 	SIM_EFSPDI_FILEID =3D 0x6fcd,
 };
 =

@@ -494,16 +561,15 @@ static gboolean sim_retrieve_own_number(void *user_da=
ta)
 	return FALSE;
 }
 =

-struct spdi_operator {
+struct sim_operator {
 	char mcc[OFONO_MAX_MCC_LENGTH + 1];
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 };
 =

-static struct spdi_operator *spdi_operator_alloc(const guint8 *bcd)
+static void parse_mcc_mnc(struct sim_operator *oper, const guint8 *bcd)
 {
-	struct spdi_operator *spdi =3D g_new0(struct spdi_operator, 1);
-	char *mcc =3D spdi->mcc;
-	char *mnc =3D spdi->mnc;
+	char *mcc =3D oper->mcc;
+	char *mnc =3D oper->mnc;
 	guint8 digit;
 =

 	digit =3D (bcd[0] >> 0) & 0xf;
@@ -524,14 +590,21 @@ static struct spdi_operator *spdi_operator_alloc(cons=
t guint8 *bcd)
 	digit =3D (bcd[1] >> 4) & 0xf;
 	if (digit !=3D 0xf)
 		*mnc ++ =3D '0' + digit;
+}
+
+static struct sim_operator *sim_operator_alloc(const guint8 *bcd)
+{
+	struct sim_operator *spdi =3D g_new0(struct sim_operator, 1);
+
+	parse_mcc_mnc(spdi, bcd);
 =

 	return spdi;
 }
 =

 static gint spdi_operator_compare(gconstpointer a, gconstpointer b)
 {
-	const struct spdi_operator *opa =3D a;
-	const struct spdi_operator *opb =3D b;
+	const struct sim_operator *opa =3D a;
+	const struct sim_operator *opb =3D b;
 	gint r;
 =

 	if (r =3D strcmp(opa->mcc, opb->mcc))
@@ -544,7 +617,7 @@ gboolean ofono_operator_in_spdi(struct ofono_modem *mod=
em,
 				const struct ofono_network_operator *op)
 {
 	struct sim_manager_data *sim =3D modem->sim_manager;
-	struct spdi_operator spdi_op;
+	struct sim_operator spdi_op;
 =

 	if (!sim)
 		return FALSE;
@@ -563,7 +636,7 @@ static void sim_spdi_read_cb(const struct ofono_error *=
error,
 	struct ofono_modem *modem =3D data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	const guint8 *plmn_list;
-	struct spdi_operator *spdi;
+	struct sim_operator *spdi;
 	GSList *l;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length <=3D 5)
@@ -580,7 +653,7 @@ static void sim_spdi_read_cb(const struct ofono_error *=
error,
 			continue;
 =

 		sim->spdi =3D g_slist_insert_sorted(sim->spdi,
-				spdi_operator_alloc(plmn_list),
+				sim_operator_alloc(plmn_list),
 				spdi_operator_compare);
 	}
 =

@@ -615,6 +688,225 @@ static gboolean sim_retrieve_spdi(void *user_data)
 	return FALSE;
 }
 =

+struct opl_operator {
+	struct sim_operator mcc_mnc;
+	guint16 lac_tac_low;
+	guint16 lac_tac_high;
+	guint8 id;
+};
+
+static struct opl_operator *opl_operator_alloc(const guint8 *record)
+{
+	struct opl_operator *oper =3D g_new0(struct opl_operator, 1);
+
+	parse_mcc_mnc(&oper->mcc_mnc, record);
+	record +=3D 3;
+
+	oper->lac_tac_low =3D (record[0] << 8) | record[1];
+	record +=3D 2;
+	oper->lac_tac_high =3D (record[0] << 8) | record[1];
+	record +=3D 2;
+
+	oper->id =3D record[0];
+	if (!oper->id) {
+		/* TODO: name to be taken from other sources, see TS 22.101 */
+	}
+
+	return oper;
+}
+
+static gint opl_operator_compare(gconstpointer a, gconstpointer b)
+{
+	const struct opl_operator *opa =3D a;
+	const struct sim_operator *opb =3D b;
+	int i;
+
+	for (i =3D 0; opb->mcc[i] | opa->mcc_mnc.mcc[i]; i ++)
+		if (opb->mcc[i] !=3D opa->mcc_mnc.mcc[i] &&
+				!(opa->mcc_mnc.mcc[i] =3D=3D '0' + 0xd &&
+					opb->mcc[i]))
+			return opa->mcc_mnc.mcc[i] - opb->mcc[i];
+	for (i =3D 0; opb->mnc[i] | opa->mcc_mnc.mnc[i]; i ++)
+		if (opb->mnc[i] !=3D opa->mcc_mnc.mnc[i] &&
+				!(opa->mcc_mnc.mnc[i] =3D=3D '0' + 0xd &&
+					opb->mnc[i]))
+			return opa->mcc_mnc.mnc[i] - opb->mnc[i];
+
+	if (opa->lac_tac_low > 0x0000 || opa->lac_tac_high < 0xfffe)
+		return 1;
+
+	return 0;
+}
+
+static void sim_opl_read_cb(const struct ofono_error *error,
+		const unsigned char *sdata, int length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct opl_operator *oper;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto skip;
+
+	if (length < sim->opl_size)
+		goto skip;
+
+	oper =3D opl_operator_alloc(sdata);
+	if (oper->id > sim->pnn_num) {
+		g_free(oper);
+		goto skip;
+	}
+
+	sim->opl =3D g_slist_prepend(sim->opl, oper);
+
+skip:
+	sim->opl_current ++;
+	if (sim->opl_current < sim->opl_num)
+		sim->ops->read_file_linear(modem, SIM_EFOPL_FILEID,
+						sim->opl_current,
+						sim->opl_size,
+						sim_opl_read_cb, modem);
+	else
+		/* All records retrieved */
+		if (sim->opl)
+			sim->opl =3D g_slist_reverse(sim->opl);
+}
+
+static void sim_opl_info_cb(const struct ofono_error *error, int length,
+				enum ofono_sim_file_structure structure,
+				int record_length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length < 8 ||
+			record_length < 8 ||
+			structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		return;
+
+	sim->opl_current =3D 0;
+	sim->opl_size =3D record_length;
+	sim->opl_num =3D length / record_length;
+	sim->ops->read_file_linear(modem, SIM_EFOPL_FILEID, 0,
+			record_length, sim_opl_read_cb, modem);
+}
+
+static gboolean sim_retrieve_opl(void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	sim->ops->read_file_info(modem, SIM_EFOPL_FILEID,
+			sim_opl_info_cb, modem);
+
+	return FALSE;
+}
+
+const char *ofono_operator_name_sim_override(struct ofono_modem *modem,
+		const char *mcc, const char *mnc)
+{
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct sim_operator op;
+	GSList *l;
+	const struct opl_operator *opl_op;
+
+	g_strlcpy(op.mcc, mcc, sizeof(op.mcc));
+	g_strlcpy(op.mnc, mnc, sizeof(op.mnc));
+
+	l =3D g_slist_find_custom(sim->opl, &op, opl_operator_compare);
+	if (!l)
+		return NULL;
+	opl_op =3D l->data;
+
+	return sim->pnn[opl_op->id - 1].longname;
+}
+
+static gboolean pnn_operator_parse(struct pnn_operator *oper,
+				const guint8 *tlv, int length)
+{
+	const char *name;
+	int namelength;
+
+	name =3D ber_tlv_find_by_tag(tlv, 0x43, length, &namelength);
+	if (!name || !namelength)
+		return FALSE;
+	oper->longname =3D network_name_parse(name, namelength);
+
+	name =3D ber_tlv_find_by_tag(tlv, 0x45, length, &namelength);
+	if (name && namelength)
+		oper->shortname =3D network_name_parse(name, namelength);
+
+	if (ber_tlv_find_by_tag(tlv, 0x80, length, &namelength))
+		ofono_debug("%i octets of addition PLMN information "
+				"present in EF-PNN");
+
+	return TRUE;
+}
+
+static void sim_pnn_read_cb(const struct ofono_error *error,
+		const unsigned char *pnndata, int length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+	struct opl_operator *oper;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto skip;
+
+	if (length < sim->pnn_size)
+		goto skip;
+
+	pnn_operator_parse(&sim->pnn[sim->pnn_current], pnndata, length);
+
+skip:
+	sim->pnn_current ++;
+	if (sim->pnn_current < sim->pnn_num)
+		sim->ops->read_file_linear(modem, SIM_EFPNN_FILEID,
+						sim->pnn_current,
+						sim->pnn_size,
+						sim_pnn_read_cb, modem);
+	else
+		/* All records retrieved */
+		/* We now need EF-OPL if it's there for PNN to be
+		 * useful.  */
+		sim_retrieve_opl(modem);
+}
+
+static void sim_pnn_info_cb(const struct ofono_error *error, int length,
+				enum ofono_sim_file_structure structure,
+				int record_length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length < 3 ||
+			record_length < 3 ||
+			structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		/* If PNN is not present then OPL is not useful, don't
+		 * retrieve it.  If OPL is not there then PNN[1] will
+		 * still be used for the HPLMN and/or EHPLMN, if PNN
+		 * is present.  */
+		return;
+
+	sim->pnn_current =3D 0;
+	sim->pnn_size =3D record_length;
+	sim->pnn_num =3D length / record_length;
+	sim->pnn =3D g_new0(struct pnn_operator, sim->pnn_num);
+	sim->ops->read_file_linear(modem, SIM_EFPNN_FILEID, 0,
+			record_length, sim_pnn_read_cb, modem);
+}
+
+static gboolean sim_retrieve_pnn(void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	sim->ops->read_file_info(modem, SIM_EFPNN_FILEID,
+			sim_pnn_info_cb, modem);
+
+	return FALSE;
+}
+
 static void initialize_sim_manager(struct ofono_modem *modem)
 {
 	DBusConnection *conn =3D dbus_gsm_connection();
@@ -647,6 +939,9 @@ static void initialize_sim_manager(struct ofono_modem *=
modem)
 =

 	if (modem->sim_manager->ops->read_file_transparent)
 		g_timeout_add(0, sim_retrieve_spdi, modem);
+
+	if (modem->sim_manager->ops->read_file_linear)
+		g_timeout_add(0, sim_retrieve_pnn, modem);
 }
 =

 int ofono_sim_manager_register(struct ofono_modem *modem,
diff --git a/src/sim.h b/src/sim.h
index 251a339..ecb809a 100644
--- a/src/sim.h
+++ b/src/sim.h
@@ -31,3 +31,7 @@ int ofono_spn_update_notify_unregister(struct ofono_modem=
 *modem,
 =

 gboolean ofono_operator_in_spdi(struct ofono_modem *modem,
 				const struct ofono_network_operator *op);
+
+const char *ofono_operator_name_sim_override(struct ofono_modem *modem,
+						const char *mcc,
+						const char *mnc);
-- =

1.6.0


--===============4047032762626597049==--

