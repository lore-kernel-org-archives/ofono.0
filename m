Content-Type: multipart/mixed; boundary="===============1002973162653167661=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] isimodem: add some ss error enums
Date: Thu, 07 Oct 2010 15:12:05 +0300
Message-ID: <1286453525-30396-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1002973162653167661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 drivers/isimodem/debug.c |   57 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/ss.h    |   50 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index d226c51..6d41f3f 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -99,7 +99,62 @@ const char *ss_subblock_name(enum ss_subblock value)
 		_(SS_GSM_ADDITIONAL_INFO);
 		_(SS_GSM_USSD_STRING);
 	}
-	return "SS_<UNKNOWN>";
+	return "SS_<UNKNOWN>_SB";
+}
+
+const char *ss_gsm_error_name(enum ss_gsm_error value)
+{
+	switch (value) {
+	_(SS_GSM_UNKNOWN_SUBSCRIBER);
+	_(SS_GSM_ILLEGAL_SUBSCRIBER);
+	_(SS_GSM_BEARER_SERV_NOT_PROVISION);
+	_(SS_GSM_TELE_SERV_NOT_PROVISION);
+	_(SS_GSM_ILLEGAL_EQUIPMENT);
+	_(SS_GSM_CALL_BARRED);
+	_(SS_GSM_ILLEGEL_SS_OPERATION);
+	_(SS_GSM_SS_ERROR_STATUS);
+	_(SS_GSM_SS_NOT_AVAILABLE);
+	_(SS_GSM_SS_SUBSCRIPTION_VIOLATION);
+	_(SS_GSM_SS_INCOMPATIBILITY);
+	_(SS_GSM_FACILITY_NOT_SUPPORTED);
+	_(SS_GSM_ABSENT_SUBSCRIBER);
+	_(SS_GSM_SHORT_TERM_DENIAL);
+	_(SS_GSM_LONG_TERM_DENIAL);
+	_(SS_GSM_SYSTEM_FAILURE);
+	_(SS_GSM_DATA_MISSING);
+	_(SS_GSM_UNEXPECTED_DATA_VALUE);
+	_(SS_GSM_PASSWORD_REGIS_FAILURE);
+	_(SS_GSM_NEGATIVE_PASSWORD_CHECK);
+	_(SS_GSM_MAXNUM_OF_PW_ATT_VIOLATION);
+	_(SS_GSM_LCS_POSITION_METHOD_FAILURE);
+	_(SS_GSM_UNKNOWN_ALPHABET);
+	_(SS_GSM_USSD_BUSY);
+	_(SS_GSM_NBR_SB_EXCEEDED);
+	_(SS_GSM_MAXNUM_OF_MPTY_PART_EXCEED);
+	_(SS_GSM_RESOURCES_NOT_AVAILABLE);
+	}
+	return "SS_GSM_ERROR_<UNKNOWN>";
+}
+
+const char *ss_other_error_name(enum ss_other_error value)
+{
+	switch ((int)value) {
+		_(SS_SERVICE_BUSY);
+		_(SS_GSM_MM_RELEASE);
+		_(SS_GSM_DATA_ERROR);
+		_(SS_GSM_TIMER_EXPIRED);
+		_(SS_GSM_REQUEST_CANCELLED);
+		_(SS_GSM_INDICATE_DEVICE_PASSWORD);
+		_(SS_GSM_ACTIVATION_DATA_LOST);
+		_(SS_GSM_MM_ERROR);
+		_(SS_GSM_SERVICE_NOT_ON_FDN_LIST);
+		_(SS_SIMATKCC_REJECTED);
+		_(SS_SIMATKCC_MODIFIED);
+		_(SS_CS_INACTIVE);
+		_(SS_GSM_SS_NOT_AVAILABLE);
+		_(SS_GSM_USSD_BUSY);
+	}
+	return "SS_GSM_ERROR_<UNKNOWN>";
 }
 =

 const char *mtc_isi_cause_name(enum mtc_isi_cause value)
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index f03f4ec..7cf74a7 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -35,6 +35,8 @@
 const char *ss_message_id_name(enum ss_message_id value);
 const char *ss_subblock_name(enum ss_subblock value);
 const char *ss_ussd_type_name(enum ss_ussd_type value);
+const char *ss_gsm_error_name(enum ss_gsm_error value);
+const char *ss_other_error_name(enum ss_other_error value);
 =

 const char *mtc_isi_cause_name(enum mtc_isi_cause value);
 const char *mtc_message_id_name(enum mtc_message_id value);
diff --git a/drivers/isimodem/ss.h b/drivers/isimodem/ss.h
index 93554db..9c01a5c 100644
--- a/drivers/isimodem/ss.h
+++ b/drivers/isimodem/ss.h
@@ -117,11 +117,59 @@ enum ss_subblock {
 	SS_GSM_USSD_STRING =3D			0x32
 };
 =

-enum ss_isi_cause {
+enum ss_gsm_status {
 	SS_GSM_ACTIVE =3D				0x01,
 	SS_GSM_REGISTERED =3D			0x02,
 	SS_GSM_PROVISIONED =3D			0x04,
 	SS_GSM_QUIESCENT =3D			0x08
 };
 =

+/* Error codes defined in 29.002 */
+enum ss_gsm_error {
+	SS_GSM_UNKNOWN_SUBSCRIBER =3D		0x01,
+	SS_GSM_ILLEGAL_SUBSCRIBER =3D		0x09,
+	SS_GSM_BEARER_SERV_NOT_PROVISION =3D	0x0A,
+	SS_GSM_TELE_SERV_NOT_PROVISION =3D	0x0B,
+	SS_GSM_ILLEGAL_EQUIPMENT =3D		0x0C,
+	SS_GSM_CALL_BARRED =3D			0x0D,
+	SS_GSM_ILLEGEL_SS_OPERATION =3D		0x10,
+	SS_GSM_SS_ERROR_STATUS =3D		0x11,
+	SS_GSM_SS_NOT_AVAILABLE =3D		0x12,
+	SS_GSM_SS_SUBSCRIPTION_VIOLATION =3D	0x13,
+	SS_GSM_SS_INCOMPATIBILITY =3D		0x14,
+	SS_GSM_FACILITY_NOT_SUPPORTED =3D		0x15,
+	SS_GSM_ABSENT_SUBSCRIBER =3D		0x1B,
+	SS_GSM_SHORT_TERM_DENIAL =3D		0x1D,
+	SS_GSM_LONG_TERM_DENIAL =3D		0x1E,
+	SS_GSM_SYSTEM_FAILURE =3D			0x22,
+	SS_GSM_DATA_MISSING =3D			0x23,
+	SS_GSM_UNEXPECTED_DATA_VALUE =3D		0x24,
+	SS_GSM_PASSWORD_REGIS_FAILURE =3D		0x25,
+	SS_GSM_NEGATIVE_PASSWORD_CHECK =3D	0x26,
+	SS_GSM_MAXNUM_OF_PW_ATT_VIOLATION =3D	0x2B,
+	SS_GSM_LCS_POSITION_METHOD_FAILURE =3D	0x36,
+	SS_GSM_UNKNOWN_ALPHABET =3D		0x47,
+	SS_GSM_USSD_BUSY =3D			0x48,
+	SS_GSM_NBR_SB_EXCEEDED =3D		0x78,
+	SS_GSM_MAXNUM_OF_MPTY_PART_EXCEED =3D	0x7E,
+	SS_GSM_RESOURCES_NOT_AVAILABLE =3D	0x7F,
+};
+
+enum ss_other_error {
+	SS_SERVICE_BUSY =3D			0x00,
+	SS_GSM_MM_RELEASE =3D			0x01,
+	SS_GSM_DATA_ERROR =3D			0x02,
+	SS_GSM_TIMER_EXPIRED =3D			0x03,
+	SS_GSM_REQUEST_CANCELLED =3D		0x04,
+	SS_GSM_INDICATE_DEVICE_PASSWORD =3D	0x05,
+	SS_GSM_ACTIVATION_DATA_LOST =3D		0x09,
+	SS_GSM_MM_ERROR =3D			0x0B,
+	SS_GSM_SERVICE_NOT_ON_FDN_LIST =3D	0x0C,
+	SS_SIMATKCC_REJECTED =3D			0x0D,
+	SS_SIMATKCC_MODIFIED =3D			0x0E,
+	SS_CS_INACTIVE =3D			0x0F,
+	/* SS_GSM_SS_NOT_AVAILABLE =3D		0x12, */
+	/* SS_GSM_USSD_BUSY =3D			0x48, */
+};
+
 #endif /* __ISIMODEM_SS_H */
-- =

1.7.0.4


--===============1002973162653167661==--

