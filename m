Content-Type: multipart/mixed; boundary="===============1228938744417065737=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Read own numbers from EFmsisdn instead of AT+CNUM.
Date: Thu, 18 Jun 2009 05:44:56 +0200
Message-ID: <1245296696-15259-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1228938744417065737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was found to be more portable.  On the other hand this doesn't give
the service type or speed information per number.

Depends on "[PATCH] Change sim_ops plugin interface to allow acces to linea=
r fixed files."
---
 drivers/atmodem/sim.c |    1 +
 src/driver.h          |   22 +++++++++++
 src/sim.c             |   99 +++++++++++++++++++++++++++++++++++++++++----=
---
 3 files changed, 107 insertions(+), 15 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 66e951e..165bb65 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -430,6 +430,7 @@ static void at_cnum_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		numbers[count].speed =3D -1;
 		numbers[count].service =3D -1;
 		numbers[count].itc =3D -1;
+		numbers[count].npi =3D -1;
 =

 		g_at_result_iter_skip_next(&iter);
 		g_at_result_iter_next_number(&iter, &numbers[count].service);
diff --git a/src/driver.h b/src/driver.h
index 36b9a08..793414e 100644
--- a/src/driver.h
+++ b/src/driver.h
@@ -96,6 +96,28 @@ struct ofono_own_number {
 	int speed;
 	int service;
 	int itc;
+	int npi;
+};
+
+/* 24.008 Section 10.5.4.7 */
+enum ofono_number_type {
+	OFONO_NUMBER_TYPE_UNKNOWN =3D 0,
+	OFONO_NUMBER_TYPE_INTERNATIONAL =3D 1,
+	OFONO_NUMBER_TYPE_NATIONAL =3D 2,
+	OFONO_NUMBER_TYPE_NETWORK_SPECIFIC =3D 3,
+	OFONO_NUMBER_TYPE_DEDICATED_ACCESS =3D 4,
+	OFONO_NUMBER_TYPE_RESERVED =3D 7
+};
+
+enum ofono_numbering_plan {
+	OFONO_NUMBERING_PLAN_UNKNOWN =3D 0,
+	OFONO_NUMBERING_PLAN_ISDN =3D 1,
+	OFONO_NUMBERING_PLAN_DATA =3D 3,
+	OFONO_NUMBERING_PLAN_TELEX =3D 4,
+	OFONO_NUMBERING_PLAN_NATIONAL =3D 8,
+	OFONO_NUMBERING_PLAN_PRIVATE =3D 9,
+	OFONO_NUMBERING_PLAN_RESERVED_CTS =3D 11,
+	OFONO_NUMBERING_PLAN_RESERVED =3D 15
 };
 =

 /* 51.011 Section 9.3 */
diff --git a/src/sim.c b/src/sim.c
index 9c85292..e25b210 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -51,6 +51,10 @@ struct sim_manager_data {
 	int dcbyte;
 =

 	GSList *update_spn_notify;
+
+	int own_numbers_num;
+	int own_numbers_size;
+	int own_numbers_current;
 };
 =

 static char **own_numbers_by_type(GSList *own_numbers, int type)
@@ -181,6 +185,7 @@ static GDBusMethodTable sim_manager_methods[] =3D {
 static GDBusSignalTable sim_manager_signals[] =3D { { } };
 =

 enum sim_fileids {
+	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 };
 =

@@ -285,31 +290,94 @@ static gboolean sim_retrieve_imsi(void *user_data)
 	return FALSE;
 }
 =

-static void sim_own_number_cb(const struct ofono_error *error, int num,
-			const struct ofono_own_number *own, void *data)
+static void sim_msisdn_read_cb(const struct ofono_error *error,
+		const unsigned char *sdata, int length, void *data)
 {
 	struct ofono_modem *modem =3D data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
-	int i;
+	struct ofono_own_number *ph;
+	int number_len;
+	int ton_npi;
+	int i, digit;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		return;
+		goto skip;
 =

-	for (i =3D 0; i < num; i++) {
-		struct ofono_own_number *ph;
+	if (length < sim->own_numbers_size)
+		goto skip;
 =

-		if (own[i].phone_number.number[0] =3D=3D '\0')
-			continue;
+	/* Skip Alpha-Identifier field */
+	sdata +=3D sim->own_numbers_size - 14;
+
+	number_len =3D *sdata++;
+	ton_npi =3D *sdata++;
+
+	if (number_len > 11 || ton_npi =3D=3D 0xff)
+		goto skip;
+
+	ph =3D g_new(struct ofono_own_number, 1);
+
+	ph->speed =3D -1;
+	ph->service =3D -1;
+	ph->itc =3D -1;
+	ph->npi =3D (ton_npi >> 0) & 15;
+	ph->phone_number.type =3D (ton_npi >> 4) & 7;
 =

-		ph =3D g_new(struct ofono_own_number, 1);
+	if (number_len > 10)
+		number_len =3D 10;
+	number_len *=3D 2;
+	if (number_len > OFONO_MAX_PHONE_NUMBER_LENGTH)
+		number_len =3D OFONO_MAX_PHONE_NUMBER_LENGTH;
 =

-		memcpy(ph, &own[i], sizeof(struct ofono_own_number));
+	for (i =3D 0; i < number_len; i ++) {
+		digit =3D *sdata;
+		/* BCD coded */
+		if (i & 1) {
+			sdata ++;
+			digit >>=3D 4;
+		}
+		digit &=3D 0xf;
 =

-		sim->own_numbers =3D g_slist_prepend(sim->own_numbers, ph);
+		if (digit > 9)
+			break;
+
+		ph->phone_number.number[i] =3D '0' + digit;
 	}
+	memset(&ph->phone_number.number[i], 0,
+			OFONO_MAX_PHONE_NUMBER_LENGTH - i);
+
+	sim->own_numbers =3D g_slist_prepend(sim->own_numbers, ph);
+
+skip:
+	sim->own_numbers_current ++;
+	if (sim->own_numbers_current < sim->own_numbers_num)
+		sim->ops->read_file_linear(modem, SIM_EFMSISDN_FILEID,
+				sim->own_numbers_current,
+				sim->own_numbers_size,
+				sim_msisdn_read_cb, modem);
+	else
+		/* All records retrieved */
+		if (sim->own_numbers)
+			sim->own_numbers =3D g_slist_reverse(sim->own_numbers);
+}
+
+static void sim_msisdn_info_cb(const struct ofono_error *error,
+		int length, enum ofono_simfile_struct structure,
+		int record_length, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct sim_manager_data *sim =3D modem->sim_manager;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR || length < 14 ||
+			record_length < 14 ||
+			structure !=3D OFONO_SIM_FILE_FIXED)
+		return;
 =

-	if (sim->own_numbers)
-		sim->own_numbers =3D g_slist_reverse(sim->own_numbers);
+	sim->own_numbers_current =3D 0;
+	sim->own_numbers_size =3D record_length;
+	sim->own_numbers_num =3D length / record_length;
+	sim->ops->read_file_linear(modem, SIM_EFMSISDN_FILEID, 0,
+			record_length, sim_msisdn_read_cb, modem);
 }
 =

 static gboolean sim_retrieve_own_number(void *user_data)
@@ -317,7 +385,8 @@ static gboolean sim_retrieve_own_number(void *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct sim_manager_data *sim =3D modem->sim_manager;
 =

-	sim->ops->read_own_numbers(modem, sim_own_number_cb, modem);
+	sim->ops->read_file_info(modem, SIM_EFMSISDN_FILEID,
+			sim_msisdn_info_cb, modem);
 =

 	return FALSE;
 }
@@ -349,7 +418,7 @@ static void initialize_sim_manager(struct ofono_modem *=
modem)
 	if (modem->sim_manager->ops->read_imsi)
 		g_timeout_add(0, sim_retrieve_imsi, modem);
 =

-	if (modem->sim_manager->ops->read_own_numbers)
+	if (modem->sim_manager->ops->read_file_linear)
 		g_timeout_add(0, sim_retrieve_own_number, modem);
 }
 =

-- =

1.6.0


--===============1228938744417065737==--

