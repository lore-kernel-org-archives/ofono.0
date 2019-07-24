Content-Type: multipart/mixed; boundary="===============2253184359184087026=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Postpone attach decisions until netreg is finished
Date: Wed, 24 Jul 2019 02:18:50 -0500
Message-ID: <5082a823-9f02-f117-cc16-aadc1cbf7cf1@gmail.com>
In-Reply-To: <20190724170255.8670-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2253184359184087026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 7/24/19 12:02 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In case the gprs_netreg_update is called from somewhere else
> than the actual netreg update before any netreg updates have
> happened. It can not make proper decisions. For instance
> we might run on EUTRAN but it does not know yet. So check
> if the technology is known to netreg, if not just return
> since netreg will kick us when its finished initialising,
> which will be very soon.
> ---
>   src/gprs.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index bdb8c8a2..4e79c528 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1660,6 +1660,16 @@ static void gprs_netreg_removed(struct ofono_gprs =
*gprs)
>   static void gprs_netreg_update(struct ofono_gprs *gprs)
>   {
>   	ofono_bool_t attach;
> +	int technology;
> +
> +	technology =3D ofono_netreg_get_technology(gprs->netreg);
> +
> +	/* If we are called before netreg has updated us, just return
> +	 * we will get called again when the technology is available
> +	 * and we can make better decisions
> +	 */
> +	if (technology =3D=3D -1)
> +		return;

You have to be careful here, some modem drivers do not report technology =

at all, and it is an optional property in the API.  So you are probably =

breaking such drivers with this change...

>   =

>   	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGI=
STERED;
>   =


<snip>

Regards,
-Denis

--===============2253184359184087026==--

