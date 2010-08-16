Content-Type: multipart/mixed; boundary="===============4661591142950001291=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/1] sim: Read EFust and EFest
Date: Mon, 16 Aug 2010 15:13:42 -0500
Message-ID: <4C699BF6.5090604@gmail.com>
In-Reply-To: <1281574892-23109-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4661591142950001291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 08/11/2010 08:01 PM, Yang Gu wrote:
> ---
>  src/sim.c     |   81 +++++++++++++++++++++++++++++++++++++++++++-
>  src/simutil.h |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 184 insertions(+), 2 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d2ed780..0e1ac88 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -95,6 +95,8 @@ struct ofono_sim {
>  	void *driver_data;
>  	struct ofono_atom *atom;
>  	DBusMessage *pending;
> +	unsigned char service_ust[(SIM_UST_SERVICE_MAX - 1) / 8 + 1];
> +	unsigned char service_est[(SIM_EST_SERVICE_MAX - 1) / 8 + 1];

Hmm, honestly I'd rather see:
unsigned char *service_ust;
unsigned char ust_len;

etc

>  };
>  =

>  struct msisdn_set_request {
> @@ -128,6 +130,16 @@ static const char *const passwd_name[] =3D {
>  	[OFONO_SIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
>  };
>  =

> +gboolean sim_get_ust(unsigned char *service_table, enum sim_ust_service =
index)
> +{
> +	return (service_table[index / 8] >> (index % 8)) & 1;
> +}
> +
> +gboolean sim_get_est(unsigned char *service_table, enum sim_est_service =
index)
> +{
> +	return (service_table[index / 8] >> (index % 8)) & 1;
> +}
> +

Please don't cross simutil.c vs sim.c boundary.  These functions are
declared in simutil.h.  They should be defined in simutil.c, not here.

I suggest doing something like sim_get_est(unsigned char *est, unsigned
char len, enum sim_est_service index)

and returning FALSE if the value is out of range.

>  static const char *sim_passwd_name(enum ofono_sim_password_type type)
>  {
>  	return passwd_name[type];
> @@ -1076,6 +1088,71 @@ static void sim_retrieve_imsi(struct ofono_sim *si=
m)
>  	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
>  }
>  =

> +static void sim_efest_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	int i;
> +	int size;
> +
> +	if (!ok)
> +		goto out;
> +
> +	if (length < 1) {
> +		ofono_error("EFest shall contain at least one byte");
> +		goto out;
> +	}
> +
> +	size =3D sizeof(sim->service_est) / sizeof(*sim->service_est);
> +	for (i =3D 0; i < size; i++) {
> +		if (i >=3D length)
> +			sim->service_est[i] =3D 0;
> +		else
> +			sim->service_est[i] =3D data[i];
> +	}

g_strdup might be easier here

> +
> +out:
> +	sim_retrieve_imsi(sim);
> +}
> +
> +static void sim_efust_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +	int i;
> +	int size;
> +
> +	if (!ok)
> +		goto out;
> +
> +	if (length < 1) {
> +		ofono_error("EFust shall contain at least one byte");
> +		goto out;
> +	}
> +
> +	size =3D sizeof(sim->service_ust) / sizeof(*sim->service_ust);
> +	for (i =3D 0; i < size; i++) {
> +		if (i >=3D length)
> +			sim->service_ust[i] =3D 0;
> +		else
> +			sim->service_ust[i] =3D data[i];
> +	}

Again, g_strdup might be easier.  You might want to not bother reading
EFest if the EFust failed.

> +
> +out:
> +	ofono_sim_read(sim, SIM_EFEST_FILEID,
> +		OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +		sim_efest_read_cb, sim);
> +}
> +
> +static inline void sim_retrieve_efust(struct ofono_sim *sim)
> +{
> +	ofono_sim_read(sim, SIM_EFUST_FILEID,
> +			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +			sim_efust_read_cb, sim);
> +}
> +
>  static void sim_pin_query_cb(const struct ofono_error *error,
>  				enum ofono_sim_password_type pin_type,
>  				void *data)
> @@ -1110,13 +1187,13 @@ static void sim_pin_query_cb(const struct ofono_e=
rror *error,
>  =

>  checkdone:
>  	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
> -		sim_retrieve_imsi(sim);
> +		sim_retrieve_efust(sim);
>  }
>  =

>  static void sim_pin_check(struct ofono_sim *sim)
>  {
>  	if (!sim->driver->query_passwd_state) {
> -		sim_retrieve_imsi(sim);
> +		sim_retrieve_efust(sim);
>  		return;
>  	}
>  =

> diff --git a/src/simutil.h b/src/simutil.h
> index 29194ca..1f7efb6 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -26,9 +26,11 @@ enum sim_fileid {
>  	SIM_EF_CPHS_MWIS_FILEID =3D 0x6f11,
>  	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
>  	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
> +	SIM_EFUST_FILEID =3D 0x6f38,
>  	SIM_EFMSISDN_FILEID =3D 0x6f40,
>  	SIM_EFSPN_FILEID =3D 0x6f46,
>  	SIM_EFSDN_FILEID =3D 0x6f49,
> +	SIM_EFEST_FILEID =3D 0x6f56,
>  	SIM_EFAD_FILEID =3D 0x6fad,
>  	SIM_EFPHASE_FILEID =3D 0x6fae,
>  	SIM_EFPNN_FILEID =3D 0x6fc5,
> @@ -53,6 +55,106 @@ enum sim_file_access {
>  	SIM_FILE_ACCESS_NEVER =3D 15,
>  };
>  =

> +/* 131.102 Section 4.2.8 */
> +enum sim_ust_service {
> +	SIM_UST_SERVICE_LOCAL_PHONE_BOOK		=3D 0,
> +	SIM_UST_SERVICE_FDN				=3D 1,
> +	SIM_UST_SERVICE_EXT_2				=3D 2,
> +	SIM_UST_SERVICE_SDN				=3D 3,
> +	SIM_UST_SERVICE_EXT_3				=3D 4,
> +	SIM_UST_SERVICE_BDN				=3D 5,
> +	SIM_UST_SERVICE_EXT_4				=3D 6,
> +	SIM_UST_SERVICE_OCI_OCT				=3D 7,
> +	SIM_UST_SERVICE_ICI_ICT				=3D 8,
> +	SIM_UST_SERVICE_SMS				=3D 9,
> +	SIM_UST_SERVICE_SMSR				=3D 10,
> +	SIM_UST_SERVICE_SMSP				=3D 11,
> +	SIM_UST_SERVICE_AOC				=3D 12,
> +	SIM_UST_SERVICE_CCP2				=3D 13,
> +	SIM_UST_SERVICE_CBS_ID				=3D 14,
> +	SIM_UST_SERVICE_CBS_ID_RANGE			=3D 15,
> +	SIM_UST_SERVICE_GROUP_ID_LEVEL_1		=3D 16,
> +	SIM_UST_SERVICE_GROUP_ID_LEVEL_2		=3D 17,
> +	SIM_UST_SERVICE_PROVIDER_NAME			=3D 18,
> +	SIM_UST_SERVICE_USER_PLMN			=3D 19,
> +	SIM_UST_SERVICE_MSISDN				=3D 20,
> +	SIM_UST_SERVICE_IMG				=3D 21,
> +	SIM_UST_SERVICE_SOLSA				=3D 22,
> +	SIM_UST_SERVICE_PRECEDENCE_PREEMPTION		=3D 23,
> +	SIM_UST_SERVICE_EMLPP				=3D 24,
> +	SIM_UST_SERVICE_GSM_ACCESS			=3D 26,
> +	SIM_UST_SERVICE_DATA_DOWNLOAD_SMS_PP		=3D 27,
> +	SIM_UST_SERVICE_DATA_DOWNLOAD_SMS_CB		=3D 28,
> +	SIM_UST_SERVICE_CALL_CONTROL_USIM		=3D 29,
> +	SIM_UST_SERVICE_MO_SMS_USIM			=3D 30,
> +	SIM_UST_SERVICE_RUN_AT_COMMAND			=3D 31,
> +	SIM_UST_SERVICE_ENABLED_SERVICE_TABLE		=3D 33,
> +	SIM_UST_SERVICE_ACL				=3D 34,
> +	SIM_UST_SERVICE_DEPERSONALISATION_CTRL_KEY	=3D 35,
> +	SIM_UST_SERVICE_NETWORK_LIST			=3D 36,
> +	SIM_UST_SERVICE_GSM_SECURITY_CONTEXT		=3D 37,
> +	SIM_UST_SERVICE_CPBCCH				=3D 38,
> +	SIM_UST_SERVICE_INVESTIGATION_SCAN		=3D 39,
> +	SIM_UST_SERVICE_MEXE				=3D 40,
> +	SIM_UST_SERVICE_OPERATOR_PLMN			=3D 41,
> +	SIM_UST_SERVICE_HPLMN				=3D 42,
> +	SIM_UST_SERVICE_EXT_5				=3D 43,
> +	SIM_UST_SERVICE_PLMN_NETWORK_NAME		=3D 44,
> +	SIM_UST_SERVICE_OPERATOR_PLMN_LIST		=3D 45,
> +	SIM_UST_SERVICE_MAILBOX_DIALLING_NUMBERS	=3D 46,
> +	SIM_UST_SERVICE_MWIS				=3D 47,
> +	SIM_UST_SERVICE_CFIS				=3D 48,
> +	SIM_UST_SERVICE_PROVIDER_DISPLAY_INFO		=3D 50,
> +	SIM_UST_SERVICE_MMS				=3D 51,
> +	SIM_UST_SERVICE_EXT_8				=3D 52,
> +	SIM_UST_SERVICE_CALL_CONTROL_GPRS_USIM		=3D 53,
> +	SIM_UST_SERVICE_MMS_USER_CONN_PARAM		=3D 54,
> +	SIM_UST_SERVICE_NIA				=3D 55,
> +	SIM_UST_SERVICE_EFVGCS_EFVGCSS			=3D 56,
> +	SIM_UST_SERVICE_EFVBS_EFVBSS			=3D 57,
> +	SIM_UST_SERVICE_PSEUDONYM			=3D 58,
> +	SIM_UST_SERVICE_USER_PLMN_I_WLAN		=3D 59,
> +	SIM_UST_SERVICE_OPERATOR_PLMN_I_WLAN		=3D 60,
> +	SIM_UST_SERVICE_USER_WSID			=3D 61,
> +	SIM_UST_SERVICE_OPERATOR_WSID			=3D 62,
> +	SIM_UST_SERVICE_VGCS_SECURITY			=3D 63,
> +	SIM_UST_SERVICE_VBS_SECURITY			=3D 64,
> +	SIM_UST_SERVICE_WLAN_REAUTH_ID			=3D 65,
> +	SIM_UST_SERVICE_MMS_STORAGE			=3D 66,
> +	SIM_UST_SERVICE_GBA				=3D 67,
> +	SIM_UST_SERVICE_MBMS_SECURITY			=3D 68,
> +	SIM_UST_SERVICE_USSD_APPLICATION_MODE		=3D 69,
> +	SIM_UST_SERVICE_EQUIVALENT_HPLMN		=3D 70,
> +	SIM_UST_SERVICE_ADDITIONAL_TERMINAL_PROFILE	=3D 71,
> +	SIM_UST_SERVICE_EQUIVALENT_HPLMN_IND		=3D 72,
> +	SIM_UST_SERVICE_LAST_RPLMN_IND			=3D 73,
> +	SIM_UST_SERVICE_OMA_BCAST_SC_PROFILE		=3D 74,
> +	SIM_UST_SERVICE_BGA_LOCAL_KEY			=3D 75,
> +	SIM_UST_SERVICE_TERMINAL_APPLICATIONS		=3D 76,
> +	SIM_UST_SERVICE_PROVIDER_NAME_ICON		=3D 77,
> +	SIM_UST_SERVICE_PLMN_NETWORK_NAME_ICON		=3D 78,
> +	SIM_UST_SERVICE_CONN_PARAM_USIM_IP		=3D 79,
> +	SIM_UST_SERVICE_HOME_I_WLAN_ID_LIST		=3D 80,
> +	SIM_UST_SERVICE_I_WLAN_EQUIVALENT_HPLMN_IND	=3D 81,
> +	SIM_UST_SERVICE_I_WLAN_HPLMN_PRIORITY_IND	=3D 82,
> +	SIM_UST_SERVICE_I_WLAN_LAST_PLMN		=3D 83,
> +	SIM_UST_SERVICE_EPS_INFO			=3D 84,
> +	SIM_UST_SERVICE_CSG_IND				=3D 85,
> +	SIM_UST_SERVICE_CALL_CONTROL_EPS_PDN_USIM	=3D 86,
> +	SIM_UST_SERVICE_HPLMN_DIRECT_ACCESS		=3D 87,
> +	SIM_UST_SERVICE_ECALL_DATA			=3D 88,
> +	SIM_UST_SERVICE_OPERATOR_CSG			=3D 89,
> +	SIM_UST_SERVICE_MAX

I'd say get rid of MAX...

> +};
> +
> +/* 131.102 Section 4.2.47 */
> +enum sim_est_service {
> +	SIM_EST_SERVICE_FDN				=3D 0,
> +	SIM_EST_SERVICE_BDN				=3D 1,
> +	SIM_EST_SERVICE_ACL				=3D 2,
> +	SIM_EST_SERVICE_MAX

Same here

> +};
> +
>  #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
>  #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
>  =

> @@ -266,3 +368,6 @@ gboolean sim_parse_3g_get_response(const unsigned cha=
r *data, int len,
>  gboolean sim_parse_2g_get_response(const unsigned char *response, int le=
n,
>  					int *file_len, int *record_len,
>  					int *structure, unsigned char *access);
> +
> +gboolean sim_get_ust(unsigned char *service_table, enum sim_ust_service =
index);
> +gboolean sim_get_est(unsigned char *service_table, enum sim_est_service =
index);

Regards,
-Denis

--===============4661591142950001291==--

