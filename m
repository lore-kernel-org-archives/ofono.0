Content-Type: multipart/mixed; boundary="===============1731800851693699538=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Decode and encode alpha-identifier fields in EFadn format utils.
Date: Wed, 19 Aug 2009 22:08:34 +0200
Message-ID: <1250712514-9140-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1731800851693699538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also fix the number length passed to extract_bcd_number in sim_adn_parse.
---
 src/message-waiting.c |    5 +++--
 src/sim.c             |    5 +++--
 src/simutil.c         |   42 +++++++++++++++++++++++++++++++++++++-----
 src/simutil.h         |    5 +++--
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index ccb137e..abca027 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -230,7 +230,7 @@ static DBusMessage *set_mbdn(struct ofono_modem *modem,=
 int mailbox,
 =

 	efmbdn_length =3D req->mw->efmbdn_length > 0 ?
 		req->mw->efmbdn_length : 14;
-	sim_adn_build(efmbdn, efmbdn_length, &req->number);
+	sim_adn_build(efmbdn, efmbdn_length, &req->number, NULL);
 =

 	if (req->mw->efmbdn_length > 0)
 		r =3D ofono_sim_write(modem, SIM_EFMBDN_FILEID, mbdn_set_cb,
@@ -404,7 +404,8 @@ static void mw_mbdn_read_cb(struct ofono_modem *modem, =
int ok,
 	if (i =3D=3D 5)
 		return;
 =

-	if (sim_adn_parse(data, record_length, &mw->mailbox_number[i]) =3D=3D FAL=
SE)
+	if (sim_adn_parse(data, record_length, &mw->mailbox_number[i], NULL) =3D=
=3D
+			FALSE)
 		mw->mailbox_number[i].number[0] =3D '\0';
 =

 	if (mw_mailbox_property_name[i]) {
diff --git a/src/sim.c b/src/sim.c
index 0af02cd..2298cbf 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -249,7 +249,8 @@ static gboolean set_own_numbers(struct ofono_modem *mod=
em,
 	for (record =3D 1; record <=3D sim->efmsisdn_records; record++) {
 		if (new_numbers) {
 			number =3D new_numbers->data;
-			sim_adn_build(efmsisdn, sim->efmsisdn_length, number);
+			sim_adn_build(efmsisdn, sim->efmsisdn_length,
+					number, NULL);
 			new_numbers =3D new_numbers->next;
 		} else
 			memset(efmsisdn, 0xff, sim->efmsisdn_length);
@@ -401,7 +402,7 @@ static void sim_msisdn_read_cb(struct ofono_modem *mode=
m, int ok,
 	sim->efmsisdn_length =3D record_length;
 	sim->efmsisdn_records =3D total;
 =

-	if (sim_adn_parse(data, record_length, &ph) =3D=3D TRUE) {
+	if (sim_adn_parse(data, record_length, &ph, NULL) =3D=3D TRUE) {
 		struct ofono_phone_number *own;
 =

 		own =3D g_new(struct ofono_phone_number, 1);
diff --git a/src/simutil.c b/src/simutil.c
index 1dc310b..41d5149 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -403,7 +403,7 @@ const struct sim_eons_operator_info *sim_eons_lookup_wi=
th_lac(
 }
 =

 gboolean sim_adn_parse(const unsigned char *data, int length,
-			struct ofono_phone_number *ph)
+			struct ofono_phone_number *ph, char **identifier)
 {
 	int number_len;
 	int ton_npi;
@@ -411,19 +411,31 @@ gboolean sim_adn_parse(const unsigned char *data, int=
 length,
 	if (length < 14)
 		return FALSE;
 =

-	/* Skip Alpha-Identifier field */
+	/* Alpha-Identifier field */
+	if (identifier) {
+		if (length > 14)
+			*identifier =3D sim_string_to_utf8(data, length - 14);
+		 else
+			*identifier =3D NULL;
+	}
 	data +=3D length - 14;
 =

 	number_len =3D *data++;
 	ton_npi =3D *data++;
 =

-	if (number_len > 11 || ton_npi =3D=3D 0xff)
+	if (number_len > 11 || ton_npi =3D=3D 0xff) {
+		if (identifier && *identifier) {
+			g_free(*identifier);
+			*identifier =3D NULL;
+		}
+
 		return FALSE;
+	}
 =

 	ph->type =3D ton_npi;
 =

 	/* BCD coded, however the TON/NPI is given by the first byte */
-	number_len =3D (number_len - 1) * 2;
+	number_len -=3D 1;
 =

 	extract_bcd_number(data, number_len, ph->number);
 =

@@ -431,13 +443,33 @@ gboolean sim_adn_parse(const unsigned char *data, int=
 length,
 }
 =

 void sim_adn_build(unsigned char *data, int length,
-			const struct ofono_phone_number *ph)
+			const struct ofono_phone_number *ph,
+			const char *identifier)
 {
 	int number_len =3D strlen(ph->number);
+	unsigned char *gsm_identifier;
+	long gsm_bytes;
 =

 	/* Alpha-Identifier field */
 	if (length > 14) {
 		memset(data, 0xff, length - 14);
+
+		if (identifier) {
+			/* TODO: figure out when the identifier needs to
+			 * be encoded in UCS2 and do this.
+			 */
+			gsm_identifier =3D convert_utf8_to_gsm(identifier,
+					-1, NULL, &gsm_bytes, 0);
+
+			if (gsm_identifier) {
+				if (gsm_bytes > length - 14)
+					gsm_bytes =3D length - 14;
+
+				memcpy(data, gsm_identifier, gsm_bytes);
+				g_free(gsm_identifier);
+			}
+		}
+
 		data +=3D length - 14;
 	}
 =

diff --git a/src/simutil.h b/src/simutil.h
index 9bb5323..dccbe7b 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -83,6 +83,7 @@ static inline enum sim_file_access file_access_condition_=
decode(int bcd)
 }
 =

 gboolean sim_adn_parse(const unsigned char *data, int length,
-			struct ofono_phone_number *ph);
+			struct ofono_phone_number *ph, char **identifier);
 void sim_adn_build(unsigned char *data, int length,
-			const struct ofono_phone_number *ph);
+			const struct ofono_phone_number *ph,
+			const char *identifier);
-- =

1.6.1


--===============1731800851693699538==--

