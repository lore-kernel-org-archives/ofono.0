Content-Type: multipart/mixed; boundary="===============2511943165127886482=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: set PDP/EPS minimum context ID to 1.
Date: Thu, 25 Jun 2020 11:33:07 -0500
Message-ID: <c317de86-72f0-8638-2614-0f032d78f48c@gmail.com>
In-Reply-To: <20200625092924.4677-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2511943165127886482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:29 AM, Jimmy Gysens wrote:
> There are manufacturers, like Huawei, returning profile 0 as the minimum
> PDP/EPS context ID. Profile 0, however, is the default profile used to
> register to the LTE network. It contains manufacturer specific settings a=
nd
> should not be created by +CGDCONT.
> =

> Reference: ETSI TS 127 007: AT command set for User Equipment (UE), secti=
on
> 10.1.0.

Yeah, but which version of it ;)  I think ETSI versions are lagging a bit b=
ehind =

3GPP versions and we prefer to use 3GPP 27.007 for historical reasons.

> ---
>   drivers/atmodem/gprs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 58d4eed3..bcf1eaaf 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -787,6 +787,13 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResul=
t *result,
>   	if (found =3D=3D FALSE)
>   		goto error;
>   =

> +	/*
> +	 * ETSI TS 127 007: profile 0 is manufacturer specific.
> +	 * Start from PDP/EPS context ID 1.
> +	 */
> +	if (min <=3D 0)
> +		min =3D 1;
> +

g_at_result_next_range can't really return negative numbers.  Not sure why =
we =

have it returning gints.  So I'd prefer to use min =3D=3D 0 here.

Otherwise, this looks harmless enough, but I wonder if you're breaking some =

drivers doing this since some might report cid=3D0 as the default bearer be=
ing =

activated by 'ME PDN ACT' unsolicited result code.  Which cid does Huawei r=
eport =

in this case?

Regards,
-Denis
--===============2511943165127886482==--

