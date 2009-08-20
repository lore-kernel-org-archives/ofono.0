Content-Type: multipart/mixed; boundary="===============9169935400747829852=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Read EFad and expose MNC length in IMSI as a SimManager property.
Date: Thu, 20 Aug 2009 10:09:50 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001AB3CC719@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1250697624-6618-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169935400747829852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several minor comments on this patch:
1. How about unify all the mnc_length to be unsigned char?
2. For this piece of code:
>+		value =3D new_mnc_length;
>+		ofono_dbus_signal_property_changed(conn, modem->path,
>+						SIM_MANAGER_INTERFACE,
>+						"MNCLength", DBUS_TYPE_BYTE,
>+						&value);
Is it necessary to use temporary variable value? Why not use &sim->mnc_leng=
th instead of &value?

3. In function sim_ad_read_cb(), variable "ph" is defined by not used. Curr=
ent build system is not smart enough to check if all the variables are used=
 or not. I sugguest to add some option, such as -Wunused, in our build syst=
em to check this kind of situation.


Regards,
-Yang


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Andrzej Zaborowski
>Sent: Thursday, August 20, 2009 12:00 AM
>To: ofono(a)ofono.org
>Subject: Read EFad and expose MNC length in IMSI as a SimManager property.
>
>Alternatively we could expose the MNC as a separate property.
>---
> src/sim.c     |   50
>++++++++++++++++++++++++++++++++++++++++++++++++++
> src/simutil.h |    1 +
> 2 files changed, 51 insertions(+), 0 deletions(-)
>
>diff --git a/src/sim.c b/src/sim.c
>index 39976b3..0af02cd 100644
>--- a/src/sim.c
>+++ b/src/sim.c
>@@ -77,6 +77,7 @@ struct sim_file_op {
> struct sim_manager_data {
> 	struct ofono_sim_ops *ops;
> 	char *imsi;
>+	int mnc_length;
> 	GSList *own_numbers;
> 	GSList *new_numbers;
> 	GSList *ready_notify;
>@@ -164,6 +165,7 @@ static DBusMessage
>*sim_get_properties(DBusConnection *conn,
> 	DBusMessageIter iter;
> 	DBusMessageIter dict;
> 	char **own_numbers;
>+	unsigned char mnc_len;
>
> 	reply =3D dbus_message_new_method_return(msg);
> 	if (!reply)
>@@ -179,6 +181,13 @@ static DBusMessage
>*sim_get_properties(DBusConnection *conn,
> 		ofono_dbus_dict_append(&dict, "SubscriberIdentity",
> 					DBUS_TYPE_STRING, &sim->imsi);
>
>+	if (sim->mnc_length) {
>+		mnc_len =3D sim->mnc_length;
>+
>+		ofono_dbus_dict_append(&dict, "MNCLength",
>+					DBUS_TYPE_BYTE, &mnc_len);
>+	}
>+
> 	own_numbers =3D get_own_numbers(sim->own_numbers);
>
> 	ofono_dbus_dict_append_array(&dict, "SubscriberNumbers",
>@@ -432,15 +441,56 @@ check:
> 	sim->new_numbers =3D NULL;
> }
>
>+static void sim_ad_read_cb(struct ofono_modem *modem, int ok,
>+				enum ofono_sim_file_structure structure,
>+				int length, int record,
>+				const unsigned char *data,
>+				int record_length, void *userdata)
>+{
>+	struct sim_manager_data *sim =3D userdata;
>+	DBusConnection *conn =3D ofono_dbus_get_connection();
>+	int new_mnc_length;
>+	unsigned char value;
>+	struct ofono_phone_number ph;
>+
>+	if (!ok)
>+		return;
>+
>+	if (structure !=3D OFONO_SIM_FILE_STRUCTURE_TRANSPARENT)
>+		return;
>+
>+	if (length < 4)
>+		return;
>+
>+	new_mnc_length =3D data[3] & 0xf;
>+
>+	if (sim->mnc_length !=3D new_mnc_length) {
>+		sim->mnc_length =3D new_mnc_length;
>+
>+		value =3D new_mnc_length;
>+		ofono_dbus_signal_property_changed(conn, modem->path,
>+						SIM_MANAGER_INTERFACE,
>+						"MNCLength", DBUS_TYPE_BYTE,
>+						&value);
>+	}
>+}
>+
> static void sim_own_numbers_update(struct ofono_modem *modem)
> {
> 	ofono_sim_read(modem, SIM_EFMSISDN_FILEID,
> 			sim_msisdn_read_cb, modem->sim_manager);
> }
>
>+static void sim_mnc_length_update(struct ofono_modem *modem)
>+{
>+	ofono_sim_read(modem, SIM_EFAD_FILEID,
>+			sim_ad_read_cb, modem->sim_manager);
>+}
>+
> static void sim_ready(struct ofono_modem *modem)
> {
> 	sim_own_numbers_update(modem);
>+	sim_mnc_length_update(modem);
> }
>
> static void sim_imsi_cb(const struct ofono_error *error, const char *imsi,
>diff --git a/src/simutil.h b/src/simutil.h
>index c0d3d52..9bb5323 100644
>--- a/src/simutil.h
>+++ b/src/simutil.h
>@@ -22,6 +22,7 @@
> enum sim_fileid {
> 	SIM_EFMSISDN_FILEID =3D 0x6f40,
> 	SIM_EFSPN_FILEID =3D 0x6f46,
>+	SIM_EFAD_FILEID =3D 0x6fad,
> 	SIM_EFPNN_FILEID =3D 0x6fc5,
> 	SIM_EFOPL_FILEID =3D 0x6fc6,
> 	SIM_EFMBDN_FILEID =3D 0x6fc7,
>--
>1.6.1
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============9169935400747829852==--

