Content-Type: multipart/mixed; boundary="===============6694676943237669881=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] Clean up in sim.c.
Date: Thu, 30 Jul 2009 10:04:59 +0200
Message-ID: <1248941099-13147-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6694676943237669881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove unused variables and fields.
Move EFadn format parsing to a common function because various files use
this same format.
---
 src/sim.c           |   25 +++++--------------------
 src/simutil.c       |   28 ++++++++++++++++++++++++++++
 src/simutil.h       |    3 +++
 unit/Makefile.am    |    3 ++-
 unit/test-simutil.c |    1 +
 5 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 5122ee5..deab6bd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -64,8 +64,6 @@ struct sim_file_op {
 =

 struct sim_manager_data {
 	struct ofono_sim_ops *ops;
-	int flags;
-	DBusMessage *pending;
 	char *imsi;
 	GSList *own_numbers;
 	GSList *ready_notify;
@@ -183,8 +181,6 @@ static void sim_msisdn_read_cb(struct ofono_modem *mode=
m, int ok,
 	struct sim_manager_data *sim =3D modem->sim_manager;
 	int total;
 	struct ofono_phone_number *ph;
-	int number_len;
-	int ton_npi;
 =

 	if (!ok)
 		return;
@@ -197,23 +193,12 @@ static void sim_msisdn_read_cb(struct ofono_modem *mo=
dem, int ok,
 =

 	total =3D length / record_length;
 =

-	/* Skip Alpha-Identifier field */
-	data +=3D record_length - 14;
-
-	number_len =3D *data++;
-	ton_npi =3D *data++;
-
-	if (number_len > 11 || ton_npi =3D=3D 0xff)
-		goto check;
-
 	ph =3D g_new(struct ofono_phone_number, 1);
 =

-	ph->type =3D bit_field(ton_npi, 4, 3);
-
-	/* BCD coded, however the TON/NPI is given by the first byte */
-	number_len =3D (number_len - 1) * 2;
-
-	extract_bcd_number(data, number_len, ph->number);
+	if (sim_adn_parse(data, record_length, ph) =3D=3D FALSE) {
+		g_free(ph);
+		goto check;
+	}
 =

 	sim->own_numbers =3D g_slist_prepend(sim->own_numbers, ph);
 =

@@ -792,5 +777,5 @@ void ofono_sim_manager_exit(struct ofono_modem *modem)
 =

 	g_free(modem->sim_manager);
 =

-	modem->sim_manager =3D 0;
+	modem->sim_manager =3D NULL;
 }
diff --git a/src/simutil.c b/src/simutil.c
index 1430ec3..51b1f5c 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -398,3 +398,31 @@ const struct sim_eons_operator_info *sim_eons_lookup_w=
ith_lac(
 {
 	return sim_eons_lookup_common(eons, mcc, mnc, TRUE, lac);
 }
+
+gboolean sim_adn_parse(const unsigned char *data, int length,
+			struct ofono_phone_number *ph)
+{
+	int number_len;
+	int ton_npi;
+
+	if (length < 14)
+		return FALSE;
+
+	/* Skip Alpha-Identifier field */
+	data +=3D length - 14;
+
+	number_len =3D *data++;
+	ton_npi =3D *data++;
+
+	if (number_len > 11 || ton_npi =3D=3D 0xff)
+		return FALSE;
+
+	ph->type =3D bit_field(ton_npi, 4, 3);
+
+	/* BCD coded, however the TON/NPI is given by the first byte */
+	number_len =3D (number_len - 1) * 2;
+
+	extract_bcd_number(data, number_len, ph->number);
+
+	return TRUE;
+}
diff --git a/src/simutil.h b/src/simutil.h
index d6526fc..6572e72 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -76,3 +76,6 @@ static inline enum sim_file_access file_access_condition_=
decode(int bcd)
 		return SIM_FILE_ACCESS_ADM;
 	return bcd;
 }
+
+gboolean sim_adn_parse(const unsigned char *data, int length,
+			struct ofono_phone_number *ph);
diff --git a/unit/Makefile.am b/unit/Makefile.am
index d996465..8a27267 100644
--- a/unit/Makefile.am
+++ b/unit/Makefile.am
@@ -9,7 +9,8 @@ test_sms_SOURCES =3D test-sms.c $(top_srcdir)/src/util.c \
 					$(top_srcdir)/src/smsutil.c
 =

 test_simutil_SOURCES =3D test-simutil.c $(top_srcdir)/src/util.c \
-					$(top_srcdir)/src/simutil.c
+					$(top_srcdir)/src/simutil.c \
+					$(top_srcdir)/src/smsutil.c
 =

 LDADD =3D @GLIB_LIBS@ @GTHREAD_LIBS@
 =

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 5945af0..0a0fa7c 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -24,6 +24,7 @@
 #include <assert.h>
 #include <glib.h>
 =

+#include "driver.h"
 #include "simutil.h"
 =

 const unsigned char valid_efopl[] =3D {
-- =

1.6.1


--===============6694676943237669881==--

