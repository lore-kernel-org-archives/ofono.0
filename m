Content-Type: multipart/mixed; boundary="===============8927312217225365219=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 4/6] qmimodem: extract network time from serving system
Date: Fri, 08 Sep 2017 10:48:13 +0200
Message-ID: <158bbb77-3391-316c-98e6-ba22f9737c0e@southpole.se>
In-Reply-To: <20170907202300.23952-4-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8927312217225365219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/07/2017 10:22 PM, Alexander Couzens wrote:
> ---
>   drivers/qmimodem/nas.h                  | 12 +++++++++++
>   drivers/qmimodem/network-registration.c | 37 ++++++++++++++++++++++++++=
+++++++
>   2 files changed, 49 insertions(+)
>
> diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
> index c3e7546bbfa1..9f67707ea721 100644
> --- a/drivers/qmimodem/nas.h
> +++ b/drivers/qmimodem/nas.h
> @@ -152,6 +152,18 @@ struct qmi_nas_current_plmn {
>   #define QMI_NAS_REGISTRATION_STATE_DENIED		0x03
>   #define QMI_NAS_REGISTRATION_STATE_UNKNOWN		0x04
>   =

> +#define QMI_NAS_RESULT_3GGP_DST 0x1b
> +#define QMI_NAS_RESULT_3GPP_TIME 0x1c

Calling these *_RESULT_* isn't really correct.  It should probably be =

*_IND_* (indication) instead.  For the "serving system" case, the =

'result' and the 'indication' parameter have the same value, so the =

_RESULT_ parameter gets re-used and the extract_ss_info function is =

called from both get_ss_info_cb and ss_info_notify.  For the _time_ =

parameters, however, the parameter ID is _not_ the same so separate =

RESULT and INDication ID's are needed.

Personally, I find this nas.h header file to be rather convoluted; it's =

a mishmash of defines with long names that aren't particularly easy to =

parse.  My personal preference would be to skip these defines altogether =

and just
document the parameter together with it's use in the source code... they =

are only referenced one time anyway.  See below for an example of how I =

would do this.

> +struct qmi_nas_3gpp_time {
> +	uint16_t year;
> +	uint8_t month;
> +	uint8_t day;
> +	uint8_t hour;
> +	uint8_t minute;
> +	uint8_t second;
> +	uint8_t timezone;
> +} __attribute__((__packed__));
> +
>   /* cs_state/ps_state */
>   #define QMI_NAS_ATTACH_STATE_INVALID		0x00
>   #define QMI_NAS_ATTACH_STATE_ATTACHED		0x01
> diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/n=
etwork-registration.c
> index 41caa414477b..c88e80bdf711 100644
> --- a/drivers/qmimodem/network-registration.c
> +++ b/drivers/qmimodem/network-registration.c
> @@ -23,6 +23,7 @@
>   #include <config.h>
>   #endif
>   =

> +#include <endian.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
> @@ -43,6 +44,38 @@ struct netreg_data {
>   	uint8_t current_rat;
>   };
>   =

> +static bool extract_ss_info_time(
> +		struct qmi_result *result,
> +		struct ofono_network_time *time)
> +{
> +	const struct qmi_nas_3gpp_time *time_3gpp =3D NULL;
> +	uint8_t dst_3gpp;
> +	bool dst_3gpp_valid;
> +	uint16_t len;
> +
> +	/* parse 3gpp time & dst */
> +	dst_3gpp_valid =3D qmi_result_get_uint8(result, QMI_NAS_RESULT_3GGP_DST,
> +					      &dst_3gpp);
Here's what I mean... replace the above line with:

	/* Daylight Saving Time Adjustment 3GPP */
	dst_3gpp_valid =3D qmi_result_get_uint8(result, 0x1b,
					      &dst_3gpp);


> +
> +	time_3gpp =3D qmi_result_get(result, QMI_NAS_RESULT_3GPP_TIME, &len);
And here:

	/* Universal Time and Local Time Zone 3GPP */
	time_3gpp =3D qmi_result_get(result, 0x1c, &len);

(That might be the sound of Denis screaming in the background you hear! =

:)  I'm not sure he'll agree with this... we'll see).

> +	if (time_3gpp && len =3D=3D sizeof(struct qmi_nas_3gpp_time) &&
> +			dst_3gpp_valid) {
> +		time->year =3D le16toh(time_3gpp->year);
> +		time->mon =3D time_3gpp->month;
> +		time->mday =3D time_3gpp->day;
> +		time->hour =3D time_3gpp->hour;
> +		time->min =3D time_3gpp->minute;
> +		time->sec =3D time_3gpp->second;
> +		time->utcoff =3D time_3gpp->timezone * 15 * 60;
> +		time->dst =3D dst_3gpp;
> +		return true;
> +	}
> +
> +	/* TODO: 3gpp2 */
> +
> +	return false;
> +}
> +
>   static bool extract_ss_info(struct qmi_result *result, int *status,
>   				int *lac, int *cellid, int *tech,
>   				struct ofono_network_operator *operator)
> @@ -124,11 +157,15 @@ static bool extract_ss_info(struct qmi_result *resu=
lt, int *status,
>   static void ss_info_notify(struct qmi_result *result, void *user_data)
>   {
>   	struct ofono_netreg *netreg =3D user_data;
> +	struct ofono_network_time net_time;
>   	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
>   	int status, lac, cellid, tech;
>   =

>   	DBG("");
>   =

> +	if (extract_ss_info_time(result, &net_time))
> +		ofono_netreg_time_notify(netreg, &net_time);
> +
>   	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
>   							&data->operator))
>   		return;

I tested this and didn't get any time info... I'm not sure these are =

always sent by default but might need to be enabled with the 'Register =

Indications' method (NAS method 0x03)...

/Jonas



--===============8927312217225365219==--

