Content-Type: multipart/mixed; boundary="===============7736134494404277585=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] sim: Read EFsst
Date: Mon, 30 Aug 2010 17:49:43 -0500
Message-ID: <4C7C3587.40800@gmail.com>
In-Reply-To: <1283071901-24385-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7736134494404277585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 08/29/2010 03:51 AM, Yang Gu wrote:
> ---
>  src/sim.c     |   34 ++++++++++++++++++++++++++++--
>  src/simutil.c |   18 ++++++++++++++++
>  src/simutil.h |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 112 insertions(+), 3 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index f8884a2..6cbb2eb 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -101,6 +101,8 @@ struct ofono_sim {
>  	unsigned char efust_length;
>  	unsigned char *efest;
>  	unsigned char efest_length;
> +	unsigned char *efsst;
> +	unsigned char efsst_length;
>  };
>  =

>  struct msisdn_set_request {
> @@ -1072,6 +1074,27 @@ static void sim_retrieve_imsi(struct ofono_sim *si=
m)
>  	sim->driver->read_imsi(sim, sim_imsi_cb, sim);
>  }
>  =

> +static void sim_efsst_read_cb(int ok, int length, int record,
> +				const unsigned char *data,
> +				int record_length, void *userdata)
> +{
> +	struct ofono_sim *sim =3D userdata;
> +
> +	if (!ok)
> +		goto out;
> +
> +	if (length < 2) {
> +		ofono_error("EFsst shall contain at least two bytes");
> +		goto out;
> +	}
> +
> +	sim->efsst =3D g_memdup(data, length);

Has this been run through valgrind? Where's the g_free?

> +	sim->efsst_length =3D length;
> +
> +out:
> +	sim_retrieve_imsi(sim);
> +}
> +
>  static void sim_efest_read_cb(int ok, int length, int record,
>  				const unsigned char *data,
>  				int record_length, void *userdata)
> @@ -1192,9 +1215,14 @@ static void sim_initialize_after_pin(struct ofono_=
sim *sim)
>  			sim_cphs_information_read_cb, sim);
>  =

>  	/* Also retrieve the GSM service table */
> -	ofono_sim_read(sim, SIM_EFUST_FILEID,
> -			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> -			sim_efust_read_cb, sim);
> +	if (sim->phase >=3D OFONO_SIM_PHASE_3G)
> +		ofono_sim_read(sim, SIM_EFUST_FILEID,
> +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +				sim_efust_read_cb, sim);
> +	else
> +		ofono_sim_read(sim, SIM_EFSST_FILEID,
> +				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +				sim_efsst_read_cb, sim);
>  }
>  =

>  static void sim_pin_query_cb(const struct ofono_error *error,
> diff --git a/src/simutil.c b/src/simutil.c
> index ac054ae..4af6810 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1434,3 +1434,21 @@ gboolean sim_est_is_active(unsigned char *efest, u=
nsigned char len,
>  =

>  	return (efest[index / 8] >> (index % 8)) & 1;
>  }
> +
> +gboolean sim_sst_is_available(unsigned char *efsst, unsigned char len,
> +						enum sim_sst_service index)
> +{
> +	if (index >=3D len * 4u)
> +		return FALSE;
> +
> +	return (efsst[index / 4] >> ((index % 4) * 2)) & 1;
> +}
> +
> +gboolean sim_sst_is_active(unsigned char *efsst, unsigned char len,
> +						enum sim_sst_service index)
> +{
> +	if (index >=3D len * 4u)
> +		return FALSE;
> +
> +	return (efsst[index / 4] >> (((index % 4) * 2) + 1)) & 1;
> +}
> diff --git a/src/simutil.h b/src/simutil.h
> index 65e651a..0a94c67 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -28,6 +28,7 @@ enum sim_fileid {
>  	SIM_EF_CPHS_INFORMATION_FILEID =3D 0x6f16,
>  	SIM_EF_CPHS_MBDN_FILEID =3D 0x6f17,
>  	SIM_EFUST_FILEID =3D 0x6f38,
> +	SIM_EFSST_FILEID =3D 0x6f38, /* same as EFust */
>  	SIM_EFMSISDN_FILEID =3D 0x6f40,
>  	SIM_EFSPN_FILEID =3D 0x6f46,
>  	SIM_EFSDN_FILEID =3D 0x6f49,
> @@ -154,6 +155,64 @@ enum sim_est_service {
>  	SIM_EST_SERVICE_ACL				=3D 2
>  };
>  =

> +/* 51.011 Section 10.3.7 */
> +enum sim_sst_service {
> +	SIM_SST_SERVICE_CHV1_DISABLE 			=3D 0,
> +	SIM_SST_SERVICE_ADN				=3D 1,
> +	SIM_SST_SERVICE_FDN				=3D 2,
> +	SIM_SST_SERVICE_SMS				=3D 3,
> +	SIM_SST_SERVICE_AOC				=3D 4,
> +	SIM_SST_SERVICE_CCP				=3D 5,
> +	SIM_SST_SERVICE_PLMN_SELECTOR			=3D 6,
> +	SIM_SST_SERVICE_MSISDN				=3D 8,
> +	SIM_SST_SERVICE_EXT_1				=3D 9,
> +	SIM_SST_SERVICE_EXT_2				=3D 10,
> +	SIM_SST_SERVICE_SMSP				=3D 11,
> +	SIM_SST_SERVICE_LND				=3D 12,
> +	SIM_SST_SERVICE_CBS_ID				=3D 13,
> +	SIM_SST_SERVICE_GROUP_ID_LEVEL_1		=3D 14,
> +	SIM_SST_SERVICE_GROUP_ID_LEVEL_2		=3D 15,
> +	SIM_SST_SERVICE_PROVIDER_NAME			=3D 16,
> +	SIM_SST_SERVICE_SDN				=3D 17,
> +	SIM_SST_SERVICE_EXT_3				=3D 18,
> +	SIM_SST_SERVICE_EFVGCS_EFVGCSS			=3D 20,
> +	SIM_SST_SERVICE_EFVBS_EFVBSS			=3D 21,
> +	SIM_SST_SERVICE_PRECEDENCE_PREEMPTION		=3D 22,
> +	SIM_SST_SERVICE_EMLPP				=3D 23,
> +	SIM_SST_SERVICE_DATA_DOWNLOAD_SMS_CB		=3D 24,
> +	SIM_SST_SERVICE_DATA_DOWNLOAD_SMS_PP		=3D 25,
> +	SIM_SST_SERVICE_MENU_SELECTION			=3D 26,
> +	SIM_SST_SERVICE_CALL_CONTROL			=3D 27,
> +	SIM_SST_SERVICE_PROACTIVE_SIM			=3D 28,
> +	SIM_SST_SERVICE_CBS_ID_RANGE			=3D 29,
> +	SIM_SST_SERVICE_BDN				=3D 30,
> +	SIM_SST_SERVICE_EXT_4				=3D 31,
> +	SIM_SST_SERVICE_DEPERSONALISATION_CTRL_KEY	=3D 32,
> +	SIM_SST_SERVICE_NETWORK_LIST			=3D 33,
> +	SIM_SST_SERVICE_SMSR				=3D 34,
> +	SIM_SST_SERVICE_NIA				=3D 35,
> +	SIM_SST_SERVICE_MO_SMS_SIM			=3D 36,
> +	SIM_SST_SERVICE_GPRS				=3D 37,
> +	SIM_SST_SERVICE_IMG				=3D 38,
> +	SIM_SST_SERVICE_SOLSA				=3D 39,
> +	SIM_SST_SERVICE_USSD_CALL_CONTROL		=3D 40,
> +	SIM_SST_SERVICE_RUN_AT_COMMAND			=3D 41,
> +	SIM_SST_SERVICE_USER_PLMN			=3D 42,
> +	SIM_SST_SERVICE_OPERATOR_PLMN			=3D 43,
> +	SIM_SST_SERVICE_HPLMN				=3D 44,
> +	SIM_SST_SERVICE_CPBCCH				=3D 45,
> +	SIM_SST_SERVICE_INVESTIGATION_SCAN		=3D 46,
> +	SIM_SST_SERVICE_EXT_CCP				=3D 47,
> +	SIM_SST_SERVICE_MEXE				=3D 48,
> +	SIM_SST_SERVICE_RPLMN				=3D 49,
> +	SIM_SST_SERVICE_PLMN_NETWORK_NAME		=3D 50,
> +	SIM_SST_SERVICE_OPERATOR_PLMN_LIST		=3D 51,
> +	SIM_SST_SERVICE_MAILBOX_DIALLING_NUMBERS	=3D 52,
> +	SIM_SST_SERVICE_MWIS				=3D 53,
> +	SIM_SST_SERVICE_CFIS				=3D 54,
> +	SIM_SST_SERVICE_PROVIDER_DISPLAY_INFO		=3D 55
> +};
> +
>  #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
>  #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
>  =

> @@ -372,3 +431,7 @@ gboolean sim_ust_is_available(unsigned char *service_=
ust, unsigned char len,
>  						enum sim_ust_service index);
>  gboolean sim_est_is_active(unsigned char *service_est, unsigned char len,
>  						enum sim_est_service index);
> +gboolean sim_sst_is_available(unsigned char *service_sst, unsigned char =
len,
> +						enum sim_sst_service index);
> +gboolean sim_sst_is_active(unsigned char *service_sst, unsigned char len,
> +						enum sim_sst_service index);

Rest looks good.

Regards,
-Denis

--===============7736134494404277585==--

