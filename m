Content-Type: multipart/mixed; boundary="===============3768249655687524594=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ubloxmodem: fix maybe-unitialized error
Date: Fri, 21 Jun 2019 12:54:43 -0500
Message-ID: <586bc825-a21a-31a3-6e3a-e8d87c0ff409@gmail.com>
In-Reply-To: <20190621095608.39463-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3768249655687524594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 06/21/2019 04:56 AM, Martin Hundeb=C3=B8ll wrote:
> Fixes:
> =

> ../git/drivers/ubloxmodem/gprs-context.c: In function =E2=80=98ublox_gprs=
_activate_primary=E2=80=99:
> ../git/drivers/ubloxmodem/gprs-context.c:339:2: error: =E2=80=98auth=E2=
=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitia=
lized]
>    snprintf(buf, sizeof(buf), "AT+UAUTHREQ=3D%u,%u,\"%s\",\"%s\"",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      gcd->active_context, auth, username, password);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../git/drivers/ubloxmodem/gprs-context.c:324:11: note: =E2=80=98auth=E2=
=80=99 was declared here
>    unsigned auth;

What compiler are you using?  gcc really needs to make up its mind =

whether it warns about enums or doesn't.  The behavior between versions =

is nuts.

>             ^~~~
> ---
>   drivers/ubloxmodem/gprs-context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-=
context.c
> index 489f31e8..c5b789b6 100644
> --- a/drivers/ubloxmodem/gprs-context.c
> +++ b/drivers/ubloxmodem/gprs-context.c
> @@ -321,7 +321,7 @@ static void ublox_send_uauthreq(struct ofono_gprs_con=
text *gc,
>   {
>   	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>   	char buf[UBLOX_MAX_USER_LEN + UBLOX_MAX_PASS_LEN + 32];
> -	unsigned auth;
> +	unsigned auth =3D 0;
>   =

>   	switch (auth_method) {
>   	case OFONO_GPRS_AUTH_METHOD_PAP:
> =


anyhow, applied, thanks.

Regards,
-Denis

--===============3768249655687524594==--

