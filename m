Content-Type: multipart/mixed; boundary="===============8046565780591264555=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] sim: change pin_retries array to unsigned char
Date: Fri, 28 Nov 2014 15:34:25 +0100
Message-ID: <1417185265-27410-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8046565780591264555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

Had a problem on mips, the Retries dict in org.ofono.SimManager was 0
for all pin-types.
The problem is int* are passed to dbus-functions, while the type is
DBUS_TYPE_BYTE. Changed the type of pin_retries throughout the code to
match the byte type.
---
 drivers/atmodem/sim.c         | 24 ++++++++++++------------
 drivers/isimodem/uicc.c       |  2 +-
 drivers/qmimodem/sim-legacy.c |  2 +-
 drivers/qmimodem/sim.c        |  2 +-
 include/sim.h                 |  2 +-
 src/sim.c                     | 13 +++++++------
 6 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index c128e33..0f64602 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -479,7 +479,7 @@ static struct {
 =

 #define BUILD_PIN_RETRIES_ARRAY(passwd_types, passwd_types_cnt, retry)	\
 	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)		\
-		retry[i] =3D -1;						\
+		retry[i] =3D 0xff;					\
 									\
 	for (i =3D 0; i < passwd_types_cnt; i++) {			\
 		int val;						\
@@ -500,7 +500,7 @@ static void huawei_cpin_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PUK,
@@ -547,7 +547,7 @@ static void pinnum_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -587,7 +587,7 @@ static void zpinpuk_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -625,7 +625,7 @@ static void xpincnt_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -664,7 +664,7 @@ static void oercn_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -704,7 +704,7 @@ static void cpnnum_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	const char *line;
 	int num;
 	char **entries;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 =

 	decode_at_error(&error, final);
@@ -760,7 +760,7 @@ static void at_epin_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -798,7 +798,7 @@ static void at_cpinr_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
 	size_t i;
 =

@@ -843,7 +843,7 @@ static void at_spic_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
@@ -887,7 +887,7 @@ static void at_pct_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	enum ofono_sim_password_type pin_type;
 =

@@ -939,7 +939,7 @@ static void at_pnnm_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 	const char *final =3D g_at_result_final_response(result);
 	GAtResultIter iter;
 	struct ofono_error error;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	size_t i;
 	static enum ofono_sim_password_type password_types[] =3D {
 		OFONO_SIM_PASSWORD_SIM_PIN,
diff --git a/drivers/isimodem/uicc.c b/drivers/isimodem/uicc.c
index 0a5121d..a075d27 100644
--- a/drivers/isimodem/uicc.c
+++ b/drivers/isimodem/uicc.c
@@ -926,7 +926,7 @@ static void uicc_query_pin_retries_resp(const GIsiMessa=
ge *msg, void *opaque)
 {
 	struct isi_cb_data *cbd =3D opaque;
 	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 	GIsiSubBlockIter iter;
 =

 	uint8_t num_sb =3D 0;
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 318b1ae..5b1bb5e 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -38,7 +38,7 @@
 =

 struct sim_data {
 	struct qmi_service *dms;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 };
 =

 static void qmi_read_file_info(struct ofono_sim *sim, int fileid,
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 197da50..f7ccd06 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -44,7 +44,7 @@ struct sim_data {
 	uint8_t card_state;
 	uint8_t app_type;
 	uint8_t passwd_state;
-	int retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char retries[OFONO_SIM_PASSWORD_INVALID];
 };
 =

 static int create_fileid_data(uint8_t app_type, int fileid,
diff --git a/include/sim.h b/include/sim.h
index ed850f9..f66bb93 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -113,7 +113,7 @@ typedef void (*ofono_sim_passwd_cb_t)(const struct ofon=
o_error *error,
 					void *data);
 =

 typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *error,
-			int retries[OFONO_SIM_PASSWORD_INVALID], void *data);
+			unsigned char retries[OFONO_SIM_PASSWORD_INVALID], void *data);
 =

 typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *error,
 					void *data);
diff --git a/src/sim.c b/src/sim.c
index edae5eb..fe871a0 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -62,7 +62,7 @@ struct ofono_sim {
 	enum ofono_sim_password_type pin_type;
 	gboolean locked_pins[OFONO_SIM_PASSWORD_SIM_PUK]; /* Number of PINs */
 =

-	int pin_retries[OFONO_SIM_PASSWORD_INVALID];
+	unsigned char pin_retries[OFONO_SIM_PASSWORD_INVALID];
 =

 	enum ofono_sim_phase phase;
 	unsigned char mnc_length;
@@ -273,7 +273,7 @@ static void **get_pin_retries(struct ofono_sim *sim)
 	void **ret;
 =

 	for (i =3D 1, nelem =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++) {
-		if (sim->pin_retries[i] =3D=3D -1)
+		if (sim->pin_retries[i] =3D=3D 0xff)
 			continue;
 =

 		nelem +=3D 1;
@@ -282,7 +282,7 @@ static void **get_pin_retries(struct ofono_sim *sim)
 	ret =3D g_new0(void *, nelem * 2 + 1);
 =

 	for (i =3D 1, nelem =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++) {
-		if (sim->pin_retries[i] =3D=3D -1)
+		if (sim->pin_retries[i] =3D=3D 0xff)
 			continue;
 =

 		ret[nelem++] =3D (void *) sim_passwd_name(i);
@@ -431,7 +431,7 @@ done:
 }
 =

 static void sim_pin_retries_query_cb(const struct ofono_error *error,
-					int retries[OFONO_SIM_PASSWORD_INVALID],
+					unsigned char retries[OFONO_SIM_PASSWORD_INVALID],
 					void *data)
 {
 	struct ofono_sim *sim =3D data;
@@ -450,6 +450,7 @@ static void sim_pin_retries_query_cb(const struct ofono=
_error *error,
 	memcpy(sim->pin_retries, retries, sizeof(sim->pin_retries));
 =

 	pin_retries =3D get_pin_retries(sim);
+
 	ofono_dbus_signal_dict_property_changed(conn, path,
 					OFONO_SIM_MANAGER_INTERFACE, "Retries",
 					DBUS_TYPE_BYTE,	&pin_retries);
@@ -2372,7 +2373,7 @@ static void sim_free_main_state(struct ofono_sim *sim)
 	int i;
 =

 	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-		sim->pin_retries[i] =3D -1;
+		sim->pin_retries[i] =3D 0xff;
 =

 	memset(sim->locked_pins, 0, sizeof(sim->locked_pins));
 =

@@ -2881,7 +2882,7 @@ struct ofono_sim *ofono_sim_create(struct ofono_modem=
 *modem,
 						sim_remove, sim);
 =

 	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
-		sim->pin_retries[i] =3D -1;
+		sim->pin_retries[i] =3D 0xff;
 =

 	for (l =3D g_drivers; l; l =3D l->next) {
 		const struct ofono_sim_driver *drv =3D l->data;
-- =

1.9.2


--===============8046565780591264555==--

