Content-Type: multipart/mixed; boundary="===============5361898310703492672=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Expose service dialling numbers stored on SIM through SimManager.
Date: Wed, 19 Aug 2009 22:09:27 +0200
Message-ID: <1250712567-9169-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5361898310703492672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
The ServiceDiallingNumbers property now returns a list of strings (alpha
identifiers interleaved with dialling numbers) and this is a little hacky
but returning a dictionary would make the interface more hassle to use so
I'm not sure what's better.
---
 src/sim.c     |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 src/simutil.h |    1 +
 2 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 2298cbf..2287458 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -80,6 +80,7 @@ struct sim_manager_data {
 	int mnc_length;
 	GSList *own_numbers;
 	GSList *new_numbers;
+	GSList *service_numbers;
 	GSList *ready_notify;
 	gboolean ready;
 	GQueue *simop_q;
@@ -89,6 +90,11 @@ struct sim_manager_data {
 	unsigned char efmsisdn_records;
 };
 =

+struct service_number {
+	char *id;
+	struct ofono_phone_number ph;
+};
+
 struct msisdn_set_request {
 	struct ofono_modem *modem;
 	int pending;
@@ -118,11 +124,39 @@ static char **get_own_numbers(GSList *own_numbers)
 	return ret;
 }
 =

+static char **get_service_numbers(GSList *service_numbers)
+{
+	int nelem;
+	GSList *l;
+	struct service_number *num;
+	char **ret;
+
+	nelem =3D g_slist_length(service_numbers) * 2;
+
+	ret =3D g_new0(char *, nelem + 1);
+
+	nelem =3D 0;
+	for (l =3D service_numbers; l; l =3D l->next) {
+		num =3D l->data;
+
+		ret[nelem++] =3D g_strdup(num->id);
+		ret[nelem++] =3D g_strdup(phone_number_to_string(&num->ph));
+	}
+
+	return ret;
+}
+
 static void sim_file_op_free(struct sim_file_op *node)
 {
 	g_free(node);
 }
 =

+static void service_number_free(struct service_number *num)
+{
+	g_free(num->id);
+	g_free(num);
+}
+
 static struct sim_manager_data *sim_manager_create()
 {
 	return g_try_new0(struct sim_manager_data, 1);
@@ -144,6 +178,13 @@ static void sim_manager_destroy(gpointer userdata)
 		data->own_numbers =3D NULL;
 	}
 =

+	if (data->service_numbers) {
+		g_slist_foreach(data->service_numbers,
+				(GFunc)service_number_free, NULL);
+		g_slist_free(data->service_numbers);
+		data->service_numbers =3D NULL;
+	}
+
 	if (data->simop_source) {
 		g_source_remove(data->simop_source);
 		data->simop_source =3D 0;
@@ -165,6 +206,7 @@ static DBusMessage *sim_get_properties(DBusConnection *=
conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	char **own_numbers;
+	char **service_numbers;
 	unsigned char mnc_len;
 =

 	reply =3D dbus_message_new_method_return(msg);
@@ -194,6 +236,15 @@ static DBusMessage *sim_get_properties(DBusConnection =
*conn,
 					DBUS_TYPE_STRING, &own_numbers);
 	g_strfreev(own_numbers);
 =

+	if (sim->service_numbers) {
+		service_numbers =3D get_service_numbers(sim->service_numbers);
+
+		ofono_dbus_dict_append_array(&dict, "ServiceDiallingNumbers",
+						DBUS_TYPE_STRING,
+						&service_numbers);
+		g_strfreev(service_numbers);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -476,22 +527,74 @@ static void sim_ad_read_cb(struct ofono_modem *modem,=
 int ok,
 	}
 }
 =

-static void sim_own_numbers_update(struct ofono_modem *modem)
+static void sim_sdn_read_cb(struct ofono_modem *modem, int ok,
+				enum ofono_sim_file_structure structure,
+				int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
 {
-	ofono_sim_read(modem, SIM_EFMSISDN_FILEID,
-			sim_msisdn_read_cb, modem->sim_manager);
+	struct sim_manager_data *sim =3D userdata;
+	int total;
+	struct ofono_phone_number ph;
+	char *alpha;
+	char **service_numbers;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!ok)
+		goto check;
+
+	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_FIXED)
+		return;
+
+	if (record_length < 14 || length < record_length)
+		return;
+
+	total =3D length / record_length;
+
+	if (sim_adn_parse(data, record_length, &ph, &alpha) =3D=3D TRUE && alpha)=
 {
+		struct service_number *sdn;
+
+		sdn =3D g_new(struct service_number, 1);
+		sdn->id =3D alpha;
+		memcpy(&sdn->ph, &ph, sizeof(struct ofono_phone_number));
+
+		sim->service_numbers =3D
+			g_slist_prepend(sim->service_numbers, sdn);
+	}
+
+	if (record !=3D total)
+		return;
+
+check:
+	/* All records retrieved */
+	if (sim->service_numbers) {
+		sim->service_numbers =3D g_slist_reverse(sim->service_numbers);
+
+		service_numbers =3D get_service_numbers(sim->service_numbers);
+
+		ofono_dbus_signal_array_property_changed(conn, modem->path,
+						SIM_MANAGER_INTERFACE,
+						"ServiceDiallingNumbers",
+						DBUS_TYPE_STRING,
+						&service_numbers);
+		g_strfreev(service_numbers);
+	}
 }
 =

-static void sim_mnc_length_update(struct ofono_modem *modem)
+static void sim_own_numbers_update(struct ofono_modem *modem)
 {
-	ofono_sim_read(modem, SIM_EFAD_FILEID,
-			sim_ad_read_cb, modem->sim_manager);
+	ofono_sim_read(modem, SIM_EFMSISDN_FILEID,
+			sim_msisdn_read_cb, modem->sim_manager);
 }
 =

 static void sim_ready(struct ofono_modem *modem)
 {
 	sim_own_numbers_update(modem);
-	sim_mnc_length_update(modem);
+
+	ofono_sim_read(modem, SIM_EFAD_FILEID,
+			sim_ad_read_cb, modem->sim_manager);
+	ofono_sim_read(modem, SIM_EFSDN_FILEID,
+			sim_sdn_read_cb, modem->sim_manager);
 }
 =

 static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
diff --git a/src/simutil.h b/src/simutil.h
index dccbe7b..de3e55e 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -22,6 +22,7 @@
 enum sim_fileid {
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
+	SIM_EFSDN_FILEID =3D 0x6f49,
 	SIM_EFAD_FILEID =3D 0x6fad,
 	SIM_EFPNN_FILEID =3D 0x6fc5,
 	SIM_EFOPL_FILEID =3D 0x6fc6,
-- =

1.6.1


--===============5361898310703492672==--

