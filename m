Content-Type: multipart/mixed; boundary="===============6246543428941152036=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH] sim: Read EFust and EFest
Date: Wed, 21 Jul 2010 19:07:32 +0800
Message-ID: <1279710452-32096-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6246543428941152036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sim.c     |   77 +++++++++++++++++++++++++++++++++++++++++++-
 src/simutil.h |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 2514e7b..2e304dd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -95,6 +95,8 @@ struct ofono_sim {
 	void *driver_data;
 	struct ofono_atom *atom;
 	DBusMessage *pending;
+	gboolean service_alloc[88];
+	gboolean service_actv[3];
 };
 =

 struct msisdn_set_request {
@@ -1059,6 +1061,77 @@ static void sim_retrieve_imsi(struct ofono_sim *sim)
 	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
 }
 =

+static void sim_efest_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	int i;
+	int size;
+
+	if (!ok)
+		return;
+
+	if (length < 1) {
+		ofono_error("EFest shall contain@least one byte");
+		return;
+	}
+
+	size =3D sizeof(sim->service_actv) / sizeof(*sim->service_actv);
+	for (i =3D 0; i < size; i++) {
+		if (i / 8 >=3D length)
+			sim->service_actv[i] =3D 0;
+		else
+			sim->service_actv[i] =3D (data[i / 8] >> (i % 8)) & 1;
+	}
+}
+
+static void sim_retrieve_efest(struct ofono_sim *sim)
+{
+	ofono_sim_read(sim, SIM_EFEST_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efest_read_cb, sim);
+}
+
+static void sim_efust_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *userdata)
+{
+	struct ofono_sim *sim =3D userdata;
+	int i;
+	int size;
+
+	if (!ok)
+		return;
+
+	if (length < 1) {
+		ofono_error("EFust shall contain@least one byte");
+		return;
+	}
+
+	size =3D sizeof(sim->service_alloc) / sizeof(*sim->service_alloc);
+	for (i =3D 0; i < size; i++) {
+		if (i / 8 >=3D length)
+			sim->service_alloc[i] =3D 0;
+		else
+			sim->service_alloc[i] =3D (data[i / 8] >> (i % 8)) & 1;
+	}
+}
+
+static void sim_retrieve_efust(struct ofono_sim *sim)
+{
+	ofono_sim_read(sim, SIM_EFUST_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_efust_read_cb, sim);
+}
+
+static void sim_service_request(struct ofono_sim *sim)
+{
+	sim_retrieve_efust(sim);
+	sim_retrieve_efest(sim);
+	sim_retrieve_imsi(sim);
+}
+
 static void sim_pin_query_cb(const struct ofono_error *error,
 				enum ofono_sim_password_type pin_type,
 				void *data)
@@ -1088,13 +1161,13 @@ static void sim_pin_query_cb(const struct ofono_err=
or *error,
 =

 checkdone:
 	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
-		sim_retrieve_imsi(sim);
+		sim_service_request(sim);
 }
 =

 static void sim_pin_check(struct ofono_sim *sim)
 {
 	if (!sim->driver->query_passwd_state) {
-		sim_retrieve_imsi(sim);
+		sim_service_request(sim);
 		return;
 	}
 =

diff --git a/src/simutil.h b/src/simutil.h
index 29194ca..76ac433 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -26,9 +26,11 @@ enum sim_fileid {
 	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
 	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
+	SIM_EFUST_FILEID =3D 0x6f38,
 	SIM_EFMSISDN_FILEID =3D 0x6f40,
 	SIM_EFSPN_FILEID =3D 0x6f46,
 	SIM_EFSDN_FILEID =3D 0x6f49,
+	SIM_EFEST_FILEID =3D 0x6f56,
 	SIM_EFAD_FILEID =3D 0x6fad,
 	SIM_EFPHASE_FILEID =3D 0x6fae,
 	SIM_EFPNN_FILEID =3D 0x6fc5,
@@ -53,6 +55,102 @@ enum sim_file_access {
 	SIM_FILE_ACCESS_NEVER =3D 15,
 };
 =

+/* 131.102 Section 4.2.8 */
+enum usim_alloc_service {
+	USIM_ALLOC_SERVICE_LOCAL_PHONE_BOOK		=3D 0,
+	USIM_ALLOC_SERVICE_FDN				=3D 1,
+	USIM_ALLOC_SERVICE_EXT_2			=3D 2,
+	USIM_ALLOC_SERVICE_SDN				=3D 3,
+	USIM_ALLOC_SERVICE_EXT_3			=3D 4,
+	USIM_ALLOC_SERVICE_BDN				=3D 5,
+	USIM_ALLOC_SERVICE_EXT_4			=3D 6,
+	USIM_ALLOC_SERVICE_OCI_OCT			=3D 7,
+	USIM_ALLOC_SERVICE_ICI_ICT			=3D 8,
+	USIM_ALLOC_SERVICE_SMS				=3D 9,
+	USIM_ALLOC_SERVICE_SMSR				=3D 10,
+	USIM_ALLOC_SERVICE_SMSP				=3D 11,
+	USIM_ALLOC_SERVICE_AOC				=3D 12,
+	USIM_ALLOC_SERVICE_CCP2				=3D 13,
+	USIM_ALLOC_SERVICE_CBS_ID			=3D 14,
+	USIM_ALLOC_SERVICE_CBS_ID_RANGE			=3D 15,
+	USIM_ALLOC_SERVICE_GROUP_ID_LEVEL_1		=3D 16,
+	USIM_ALLOC_SERVICE_GROUP_ID_LEVEL_2		=3D 17,
+	USIM_ALLOC_SERVICE_PROVIDER_NAME		=3D 18,
+	USIM_ALLOC_SERVICE_USER_PLMN			=3D 19,
+	USIM_ALLOC_SERVICE_MSISDN			=3D 20,
+	USIM_ALLOC_SERVICE_IMG				=3D 21,
+	USIM_ALLOC_SERVICE_SOLSA			=3D 22,
+	USIM_ALLOC_SERVICE_PRECEDENCE_PREEMPTION	=3D 23,
+	USIM_ALLOC_SERVICE_EMLPP			=3D 24,
+	USIM_ALLOC_SERVICE_GSM_ACCESS			=3D 26,
+	USIM_ALLOC_SERVICE_DATA_DOWNLOAD_SMS_PP		=3D 27,
+	USIM_ALLOC_SERVICE_DATA_DOWNLOAD_SMS_CB		=3D 28,
+	USIM_ALLOC_SERVICE_CALL_CONTROL_USIM		=3D 29,
+	USIM_ALLOC_SERVICE_MO_SMS_USIM			=3D 30,
+	USIM_ALLOC_SERVICE_RUN_AT_COMMAND		=3D 31,
+	USIM_ALLOC_SERVICE_ENABLED_SERVICE_TABLE	=3D 33,
+	USIM_ALLOC_SERVICE_ACL				=3D 34,
+	USIM_ALLOC_SERVICE_DEPERSONALISATION_CTRL_KEY	=3D 35,
+	USIM_ALLOC_SERVICE_NETWORK_LIST			=3D 36,
+	USIM_ALLOC_SERVICE_GSM_SECURITY_CONTEXT		=3D 37,
+	USIM_ALLOC_SERVICE_CPBCCH			=3D 38,
+	USIM_ALLOC_SERVICE_INVESTIGATION_SCAN		=3D 39,
+	USIM_ALLOC_SERVICE_MEXE				=3D 40,
+	USIM_ALLOC_SERVICE_OPERATOR_PLMN		=3D 41,
+	USIM_ALLOC_SERVICE_HPLMN			=3D 42,
+	USIM_ALLOC_SERVICE_EXT_5			=3D 43,
+	USIM_ALLOC_SERVICE_PLMN_NETWORK_NAME		=3D 44,
+	USIM_ALLOC_SERVICE_OPERATOR_PLMN_LIST		=3D 45,
+	USIM_ALLOC_SERVICE_MAILBOX_DIALLING_NUMBERS	=3D 46,
+	USIM_ALLOC_SERVICE_MWIS				=3D 47,
+	USIM_ALLOC_SERVICE_CFIS				=3D 48,
+	USIM_ALLOC_SERVICE_PROVIDER_DISPLAY_INFO	=3D 50,
+	USIM_ALLOC_SERVICE_MMS				=3D 51,
+	USIM_ALLOC_SERVICE_EXT_8			=3D 52,
+	USIM_ALLOC_SERVICE_CALL_CONTROL_GPRS_USIM	=3D 53,
+	USIM_ALLOC_SERVICE_MMS_USER_CONN_PARAM		=3D 54,
+	USIM_ALLOC_SERVICE_NIA				=3D 55,
+	USIM_ALLOC_SERVICE_EFVGCS_EFVGCSS		=3D 56,
+	USIM_ALLOC_SERVICE_EFVBS_EFVBSS			=3D 57,
+	USIM_ALLOC_SERVICE_PSEUDONYM			=3D 58,
+	USIM_ALLOC_SERVICE_USER_PLMN_I_WLAN		=3D 59,
+	USIM_ALLOC_SERVICE_OPERATOR_PLMN_I_WLAN		=3D 60,
+	USIM_ALLOC_SERVICE_USER_WSID			=3D 61,
+	USIM_ALLOC_SERVICE_OPERATOR_WSID		=3D 62,
+	USIM_ALLOC_SERVICE_VGCS_SECURITY		=3D 63,
+	USIM_ALLOC_SERVICE_VBS_SECURITY			=3D 64,
+	USIM_ALLOC_SERVICE_WLAN_REAUTH_ID		=3D 65,
+	USIM_ALLOC_SERVICE_MMS_STORAGE			=3D 66,
+	USIM_ALLOC_SERVICE_GBA				=3D 67,
+	USIM_ALLOC_SERVICE_MBMS_SECURITY		=3D 68,
+	USIM_ALLOC_SERVICE_USSD_APPLICATION_MODE	=3D 69,
+	USIM_ALLOC_SERVICE_EQUIVALENT_HPLMN		=3D 70,
+	USIM_ALLOC_SERVICE_ADDITIONAL_TERMINAL_PROFILE	=3D 71,
+	USIM_ALLOC_SERVICE_EQUIVALENT_HPLMN_IND		=3D 72,
+	USIM_ALLOC_SERVICE_LAST_RPLMN_IND		=3D 73,
+	USIM_ALLOC_SERVICE_OMA_BCAST_SC_PROFILE		=3D 74,
+	USIM_ALLOC_SERVICE_BGA_LOCAL_KEY		=3D 75,
+	USIM_ALLOC_SERVICE_TERMINAL_APPLICATIONS	=3D 76,
+	USIM_ALLOC_SERVICE_PROVIDER_NAME_ICON		=3D 77,
+	USIM_ALLOC_SERVICE_PLMN_NETWORK_NAME_ICON	=3D 78,
+	USIM_ALLOC_SERVICE_CONN_PARAM_USIM_IP		=3D 79,
+	USIM_ALLOC_SERVICE_HOME_I_WLAN_ID_LIST		=3D 80,
+	USIM_ALLOC_SERVICE_I_WLAN_EQUIVALENT_HPLMN_IND	=3D 81,
+	USIM_ALLOC_SERVICE_I_WLAN_HPLMN_PRIORITY_IND	=3D 82,
+	USIM_ALLOC_SERVICE_I_WLAN_LAST_PLMN		=3D 83,
+	USIM_ALLOC_SERVICE_EPS_INFO			=3D 84,
+	USIM_ALLOC_SERVICE_CSG_IND			=3D 85,
+	USIM_ALLOC_SERVICE_CALL_CONTROL_EPS_PDN_USIM	=3D 86,
+	USIM_ALLOC_SERVICE_HPLMN_DIRECT_ACCESS		=3D 87
+};
+
+/* 131.102 Section 4.2.47 */
+enum usim_actv_service {
+	USIM_ACTV_SERVICE_FDN				=3D 0,
+	USIM_ACTV_SERVICE_BDN				=3D 1,
+	USIM_ACTV_SERVICE_ACL				=3D 2
+};
+
 #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
 #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
 =

-- =

1.7.0.4


--===============6246543428941152036==--

