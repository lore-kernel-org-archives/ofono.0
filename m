Content-Type: multipart/mixed; boundary="===============1754267698085147217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/1] sim: Read EFust and EFest
Date: Wed, 18 Aug 2010 13:22:13 -0500
Message-ID: <4C6C24D5.6090805@gmail.com>
In-Reply-To: <1282143094-16232-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1754267698085147217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 08/18/2010 09:51 AM, Yang Gu wrote:
> ---
>  src/sim.c     |   66 ++++++++++++++++++++++++++++++++++-
>  src/simutil.c |   18 ++++++++++
>  src/simutil.h |  105 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 187 insertions(+), 2 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index d2ed780..a59517b 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -95,6 +95,10 @@ struct ofono_sim {
>  	void *driver_data;
>  	struct ofono_atom *atom;
>  	DBusMessage *pending;
> +	unsigned char *service_ust;
> +	unsigned char service_ust_len;
> +	unsigned char *service_est;
> +	unsigned char service_est_len;
>  };
>  =

>  struct msisdn_set_request {
> @@ -1076,6 +1080,64 @@ static void sim_retrieve_imsi(struct ofono_sim *si=
m)
>  	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
>  }
>  =

> +static void sim_efest_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +
> +	if (!ok)
> +		goto out;
> +
> +	if (length < 1) {
> +		ofono_error("EFest shall contain at least one byte");
> +		goto out;
> +	}
> +
> +	sim->service_est =3D g_try_malloc(length);

And where do you free this one?

> +	if (sim->service_est =3D=3D NULL)
> +		goto out;
> +
> +	memcpy(sim->service_est, data, length);

I'd just use g_memdup instead.

> +	sim->service_est_len =3D length * 8;

Please don't do that, by default most people expect the length to be in
bytes, not bits.

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
> +
> +	if (!ok)
> +		return;

So now we never get to retrieve the IMSI.  Oops...

> +
> +	if (length < 1) {
> +		ofono_error("EFust shall contain at least one byte");
> +		return;

And here...

> +	}
> +
> +	sim->service_ust =3D g_try_malloc(length);
> +	if (sim->service_ust =3D=3D NULL)
> +		return;
> +
> +	memcpy(sim->service_ust, data, length);
> +	sim->service_ust_len =3D length * 8;

Same comments as above about free() and g_memdup.

> +
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
> @@ -1110,13 +1172,13 @@ static void sim_pin_query_cb(const struct ofono_e=
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

> diff --git a/src/simutil.c b/src/simutil.c
> index 4b49b00..7bcb2f4 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1416,3 +1416,21 @@ gboolean sim_parse_2g_get_response(const unsigned =
char *response, int len,
>  =

>  	return TRUE;
>  }
> +
> +gboolean sim_get_ust(unsigned char *service_ust, unsigned char len,
> +						enum sim_ust_service index)

Please rename this to sim_ust_is_available()

> +{
> +	if (index >=3D len)
> +		return FALSE;
> +
> +	return (service_ust[index / 8] >> (index % 8)) & 1;

Please use byte lengths, not bit lengths here...

> +}
> +
> +gboolean sim_get_est(unsigned char *service_est, unsigned char len,
> +						enum sim_est_service index)

Please rename this to sim_est_is_active()

> +{
> +	if (index >=3D len)
> +		return FALSE;
> +
> +	return (service_est[index / 8] >> (index % 8)) & 1;
> +}
> diff --git a/src/simutil.h b/src/simutil.h
> index 29194ca..4ed432d 100644
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
> @@ -53,6 +55,104 @@ enum sim_file_access {
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
> +	SIM_UST_SERVICE_OPERATOR_CSG			=3D 89
> +};
> +
> +/* 131.102 Section 4.2.47 */
> +enum sim_est_service {
> +	SIM_EST_SERVICE_FDN				=3D 0,
> +	SIM_EST_SERVICE_BDN				=3D 1,
> +	SIM_EST_SERVICE_ACL				=3D 2
> +};
> +
>  #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
>  #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
>  =

> @@ -266,3 +366,8 @@ gboolean sim_parse_3g_get_response(const unsigned cha=
r *data, int len,
>  gboolean sim_parse_2g_get_response(const unsigned char *response, int le=
n,
>  					int *file_len, int *record_len,
>  					int *structure, unsigned char *access);
> +
> +gboolean sim_get_ust(unsigned char *service_ust, unsigned char len,
> +						enum sim_ust_service index);
> +gboolean sim_get_est(unsigned char *service_est, unsigned char len,
> +						enum sim_est_service index);

Regards,
-Denis

--===============1754267698085147217==--

