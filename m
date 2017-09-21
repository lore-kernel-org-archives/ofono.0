Content-Type: multipart/mixed; boundary="===============4568736553857759410=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] sim-auth: prep simauth/dbus headers
Date: Thu, 21 Sep 2017 17:53:06 -0500
Message-ID: <312ecfa2-9c96-b892-ec6a-c2e7db6d8864@gmail.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4568736553857759410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 09/21/2017 01:11 PM, James Prestwood wrote:
> Added new dbus interfaces for SimAuth module as well as
> function prototype definitions to simauth header
> ---
>   include/dbus.h     |  2 ++
>   include/sim-auth.h | 20 +++++++++++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> =

> diff --git a/include/dbus.h b/include/dbus.h
> index a6519c7..f0e437c 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -58,6 +58,8 @@ extern "C" {
>   #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationRepo=
rting"
>   #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
>   #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAg=
ent"
> +#define OFONO_USIM_APPLICATION_INTERFACE "org.ofono.USimApplication"
> +#define OFONO_ISIM_APPLICATION_INTERFACE "org.ofono.ISimApplication"
>   #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
>   #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
>   #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
> diff --git a/include/sim-auth.h b/include/sim-auth.h
> index 0a62adc..68c8602 100644
> --- a/include/sim-auth.h
> +++ b/include/sim-auth.h
> @@ -34,6 +34,14 @@ typedef void (*ofono_sim_list_apps_cb_t)(const struct =
ofono_error *error,
>   					const unsigned char *dataobj,
>   					int len, void *data);
>   =

> +typedef void (*ofono_sim_open_channel_cb_t)(int session_id, void *data);
> +
> +typedef void (*ofono_gsm_authenticate_cb_t)(void *data, const guint8 *sr=
es,
> +		const guint8 *kc);

No glib types in include/* please.  While both core & drivers use it, it =

might no longer be the case soon :)

Also, can't we just simply have the driver return the raw PDU?  The core =

should be decoding the TLVs & such.

> +
> +typedef void (*ofono_umts_authenticate_cb_t)(void *data, const guint8 *r=
es,
> +		guint8 res_len, const guint8 *ck, const guint8 *ik);

As above

> +
>   struct ofono_sim_auth_driver {
>   	const char *name;
>   	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
> @@ -41,7 +49,17 @@ struct ofono_sim_auth_driver {
>   	void (*remove)(struct ofono_sim_auth *sa);
>   =

>   	void (*list_apps)(struct ofono_sim_auth *sa,
> -				ofono_sim_list_apps_cb_t cb, void *data);
> +			ofono_sim_list_apps_cb_t cb, void *data);
> +	void (*open_channel)(struct ofono_sim_auth *sa,
> +			ofono_sim_open_channel_cb_t cb,
> +			const void *channel, void *data);
> +	void (*close_channel)(struct ofono_sim_auth *sa, int session_id);
> +	void (*gsm_authenticate)(struct ofono_sim_auth *sa,
> +			ofono_gsm_authenticate_cb_t cb, int session_id,
> +			const void *rand, void *data);
> +	void (*umts_authenticate)(struct ofono_sim_auth *sa,
> +			ofono_umts_authenticate_cb_t cb, int session_id,
> +			const void *rand, const void *autn, void *data);

I think we should do a logical_access method here and have the core =

compose the PDUs.  Similar to how stk atom driver works.

>   };
>   =

>   int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *=
d);
> =


Regards,
-Denis

--===============4568736553857759410==--

