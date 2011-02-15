Content-Type: multipart/mixed; boundary="===============3785985853616093321=="
MIME-Version: 1.0
From: Andreas Westin <andreas.westin@stericsson.com>
Subject: [PATCH 03/18] isimodem: general build updates for wgmodem2.5
Date: Tue, 15 Feb 2011 13:30:57 +0100
Message-ID: <54211f9998b680739d08cb3a773eb1da89bdee1b.1297772944.git.andreas.westin@stericsson.com>
In-Reply-To: <cover.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3785985853616093321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

---
 drivers/isimodem/debug.c |   48 ++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/isimodem/debug.h |    8 +++++++
 drivers/isimodem/mtc.h   |   38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index f93fa3d..c14acc2 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -166,6 +166,54 @@ const char *mtc_modem_state_name(enum mtc_modem_state =
value)
 	return "MTC_<UNKNOWN>";
 }
 =

+const char *mce_message_id_name(enum mce_message_id value)
+{
+	switch (value) {
+		_(MCE_MODEM_STATE_IND);
+		_(MCE_MODEM_STATE_QUERY_REQ);
+		_(MCE_MODEM_STATE_QUERY_RESP);
+		_(MCE_RF_STATE_REQ);
+		_(MCE_RF_STATE_RESP);
+		_(MCE_RF_STATE_IND);
+		_(MCE_RF_STATE_QUERY_REQ);
+		_(MCE_RF_STATE_QUERY_RESP);
+		_(MCE_POWER_OFF_REQ);
+		_(MCE_POWER_OFF_RESP);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_modem_state_name(enum mce_modem_state value)
+{
+	switch (value) {
+		_(MCE_NORMAL);
+		_(MCE_LOCAL);
+		_(MCE_SW_RESET);
+		_(MCE_POWER_OFF);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_status_info(enum mce_status_info value)
+{
+	switch (value) {
+		_(MCE_OK);
+		_(MCE_FAIL);
+		_(MCE_ALREADY_ACTIVE);
+		_(MCE_TRANSITION_ONGOING);
+	}
+	return "MCE_<UNKNOWN>";
+}
+
+const char *mce_rf_state_name(enum mce_rf_state value)
+{
+	switch (value) {
+		_(MCE_RF_OFF);
+		_(MCE_RF_ON);
+	}
+	return "MCE_RF<UNKNOWN>";
+}
+
 const char *sms_isi_cause_name(enum sms_isi_cause value)
 {
 	switch (value) {
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index e149c2c..b92b48f 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -41,6 +41,14 @@ const char *ss_ussd_type_name(enum ss_ussd_type value);
 const char *mtc_isi_cause_name(enum mtc_isi_cause value);
 const char *mtc_message_id_name(enum mtc_message_id value);
 const char *mtc_modem_state_name(enum mtc_modem_state value);
+const char *mce_rf_state_name(enum mce_rf_state value);
+
+const char *mce_message_id_name(enum mce_message_id value);
+const char *mce_modem_state_name(enum mce_modem_state value);
+const char *mce_status_info(enum mce_status_info value);
+
+const char *uicc_subblock_name(uint8_t value);
+const char *uicc_status_name(uint8_t value);
 =

 const char *sms_gsm_cause_name(enum sms_gsm_cause value);
 const char *sms_isi_cause_name(enum sms_isi_cause value);
diff --git a/drivers/isimodem/mtc.h b/drivers/isimodem/mtc.h
index 2db3e94..57e5040 100644
--- a/drivers/isimodem/mtc.h
+++ b/drivers/isimodem/mtc.h
@@ -27,9 +27,47 @@ extern "C" {
 #endif
 =

 #define PN_MTC				0x15
+#define PN_MODEM_MCE			0xC2
 #define MTC_TIMEOUT			5
 #define MTC_STATE_REQ_TIMEOUT		(6 + 5)
 =

+enum mce_message_id {
+	MCE_MODEM_STATE_IND =3D		0x00,
+	MCE_MODEM_STATE_QUERY_REQ =3D     0x01,
+	MCE_MODEM_STATE_QUERY_RESP =3D    0x02,
+	MCE_RF_STATE_REQ =3D		0x03,
+	MCE_RF_STATE_RESP =3D		0x04,
+	MCE_RF_STATE_IND =3D		0x05,
+	MCE_RF_STATE_QUERY_REQ =3D	0x06,
+	MCE_RF_STATE_QUERY_RESP =3D       0x07,
+	MCE_POWER_OFF_REQ =3D		0x08,
+	MCE_POWER_OFF_RESP =3D		0x09
+};
+
+enum mce_rf_state {
+	MCE_RF_OFF =3D			0x00,
+	MCE_RF_ON =3D			0x01
+};
+
+enum mce_status_info {
+	MCE_OK =3D			0x00,
+	MCE_FAIL =3D			0x01,
+	MCE_ALREADY_ACTIVE =3D		0x06,
+	MCE_TRANSITION_ONGOING =3D	0x16
+};
+
+enum mce_modem_state {
+	MCE_NORMAL =3D			0x00,
+	MCE_LOCAL =3D			0x01,
+	MCE_SW_RESET =3D			0x80,
+	MCE_POWER_OFF =3D			0x81
+};
+
+enum mce_isi_action {
+	MCE_START =3D			0x03,
+	MCE_READY =3D			0x04
+};
+
 enum mtc_isi_cause {
 	MTC_OK =3D			0x00,
 	MTC_FAIL =3D			0x01,
-- =

1.7.3.5


--===============3785985853616093321==--

