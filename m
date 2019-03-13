Content-Type: multipart/mixed; boundary="===============3601792358359468355=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/6] ublox: extend LTE driver
Date: Wed, 13 Mar 2019 16:58:30 -0500
Message-ID: <10e49a35-ec9d-ada4-9b65-2a3293ae8c2a@gmail.com>
In-Reply-To: <20190313213601.24971-5-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3601792358359468355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/13/2019 04:36 PM, Jonas Bonn wrote:
> There are a couple of semi-independent changes here:
> =

> * use the 'vendor' parameter to pass the modem 'model'
> * support TOBY L4 modem which uses a fixed CID for configuring the EPS
> default bearer
> * add the setup of authentication parameters that was recently added to
> the atmodem LTE driver
> ---
>   drivers/ubloxmodem/lte.c | 101 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 89 insertions(+), 12 deletions(-)
> =


<snip>

> +
> +	if (ublox_is_toby_l2(ldd->model)) {
> +		/* If CGDCONT has already been used to set up cid 4 then
> +		 * the EPS default bearer will be configured from another
> +		 * cid (see documentation for how this is selected).  Avoid
> +		 * doing so as this assumes as much...
> +		 */
> +		cid =3D 4;
> +	} else if (ublox_is_toby_l4(ldd->model)) {
> +		cid =3D 1;
> +	} else {

The fact that this is hardcoded is mind-boggling.  What does +CGDCONT=3D? =

report for usable contexts?

You might want to explore extending ofono_gprs to take additional hints =

as to which cids are 'off limits'.  E.g. perhaps =

ofono_gprs_set_cid_range needs a companion that would tell it that a =

given cid should not be assigned except for cases where it is used by =

ofono_gprs_cid_activated.

<snip>

> +
> +	/* change the authentication method if the  parameters are invalid */
> +	if (!*ldd->pending_info.username || !*ldd->pending_info.password)
> +		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +

By the way, are there profiles with a valid username but no password? =

The original change & api docs preclude that possibility, but I seem to =

recall this is possible.

Anyhow, the entire series has been applied now.

Regards,
-Denis

--===============3601792358359468355==--

