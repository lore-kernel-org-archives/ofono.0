Content-Type: multipart/mixed; boundary="===============6609933480213226018=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 05/11] sim-auth: prep simauth/dbus headers
Date: Wed, 11 Oct 2017 10:39:19 -0500
Message-ID: <9076d97d-0522-83f6-9650-c2d7c29d0bf6@gmail.com>
In-Reply-To: <1507671380-7625-5-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6609933480213226018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/10/2017 04:36 PM, James Prestwood wrote:
> Added new dbus interfaces for SimAuth module as well as
> function prototype definitions to simauth header.
> =

> org.ofono.SimAuthentication:
>     Interface to hold the auth object to type mapping property
> =

> org.ofono.USimApplication:
>     Application with USim functionality (GSM/UMTS auth)
> =

> org.ofono.ISimApplication:
>     Application with ISim functionality (IMS auth)
> ---
>   include/dbus.h     |  3 +++
>   include/sim-auth.h | 19 ++++++++++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> =

> diff --git a/include/dbus.h b/include/dbus.h
> index a6519c7..b7d5d39 100644
> --- a/include/dbus.h
> +++ b/include/dbus.h
> @@ -58,6 +58,9 @@ extern "C" {
>   #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationRepo=
rting"
>   #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
>   #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAg=
ent"
> +#define OFONO_USIM_APPLICATION_INTERFACE "org.ofono.USimApplication"
> +#define OFONO_ISIM_APPLICATION_INTERFACE "org.ofono.ISimApplication"
> +#define OFONO_SIM_AUTHENTICATION_INTERFACE "org.ofono.SimAuthentication"
>   #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
>   #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
>   #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
> diff --git a/include/sim-auth.h b/include/sim-auth.h
> index 0a62adc..387a487 100644
> --- a/include/sim-auth.h
> +++ b/include/sim-auth.h
> @@ -26,6 +26,8 @@
>   extern "C" {
>   #endif
>   =

> +#include <stdint.h>
> +
>   #include <ofono/types.h>
>   =

>   struct ofono_sim_auth;
> @@ -34,6 +36,13 @@ typedef void (*ofono_sim_list_apps_cb_t)(const struct =
ofono_error *error,
>   					const unsigned char *dataobj,
>   					int len, void *data);
>   =

> +typedef void (*ofono_sim_open_channel_cb_t)(int session_id, void *data);
> +
> +typedef void (*ofono_sim_close_channel_cb_t)(uint8_t success, void *data=
);
> +

Our callbacks always have const struct ofono_error *error as a first =

argument.  No sense in reinventing the wheel...

> +typedef void (*ofono_logical_access_cb_t)(const uint8_t *resp,
> +		uint16_t len, void *data);
> +

I think all these should be using ofono_error as the first argument. =

ofono_sim_list_apps_cb_t does this already...

>   struct ofono_sim_auth_driver {
>   	const char *name;
>   	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
> @@ -41,7 +50,15 @@ struct ofono_sim_auth_driver {
>   	void (*remove)(struct ofono_sim_auth *sa);
>   =

>   	void (*list_apps)(struct ofono_sim_auth *sa,
> -				ofono_sim_list_apps_cb_t cb, void *data);
> +			ofono_sim_list_apps_cb_t cb, void *data);
> +	void (*open_channel)(struct ofono_sim_auth *sa,
> +			ofono_sim_open_channel_cb_t cb,
> +			const void *channel, void *data);

Why const void?  uint8_t *aid or unsigned char aid[] or...

> +	void (*close_channel)(struct ofono_sim_auth *sa, int session_id,
> +			ofono_sim_close_channel_cb_t cb, void *data);
> +	void (*logical_access)(struct ofono_sim_auth *sa,
> +			ofono_logical_access_cb_t cb, int session_id,
> +			const uint8_t *pdu, uint16_t len, void *data);

Customarily the callback and user data are provided last.  So for =

consistency the order should be:

session_id, pdu, len, cb, data

>   };
>   =

>   int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *=
d);
> =


Regards,
-Denis

--===============6609933480213226018==--

