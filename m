Content-Type: multipart/mixed; boundary="===============3038110074973724379=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv9 15/16] lookup-apn: Follow plugin's duplicates approach
Date: Wed, 12 Oct 2011 17:01:28 -0500
Message-ID: <4E960E38.1050109@gmail.com>
In-Reply-To: <1317820719-23609-16-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3038110074973724379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 10/05/2011 08:18 AM, Oleg Zhurakivskyy wrote:
> ---
>  tools/lookup-apn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
> index 3918f18..9c0d345 100644
> --- a/tools/lookup-apn.c
> +++ b/tools/lookup-apn.c
> @@ -42,7 +42,7 @@ static void lookup_apn(const char *match_mcc, const cha=
r *match_mnc)
>  =

>  	printf("Searching for info for network: %s%s\n", match_mcc, match_mnc);
>  =

> -	apns =3D mbpi_lookup(match_mcc, match_mnc, TRUE, &error);
> +	apns =3D mbpi_lookup(match_mcc, match_mnc, FALSE, &error);

Can we make this a command line option instead and default to TRUE here?

>  =

>  	if (apns =3D=3D NULL) {
>  		if (error !=3D NULL) {

Regards,
-Denis

--===============3038110074973724379==--

