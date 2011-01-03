Content-Type: multipart/mixed; boundary="===============6411054797460655119=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Mon, 03 Jan 2011 12:24:54 -0800
Message-ID: <1294086294.5852.7.camel@aeonflux>
In-Reply-To: <1294059582-1801-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6411054797460655119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> In *ECAV, the number will not be included if caller id is hidden.
> Set it to an empty string in that case, and set number type to
> 128, unknown number type.
> ---
>  drivers/stemodem/voicecall.c |   16 +++++++++++-----
>  1 files changed, 11 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index bf68f52..4964fb7 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -1,4 +1,4 @@
> -/*
> +e/*
>   *
>   *  oFono - Open Source Telephony
>   *
> @@ -442,10 +442,16 @@ static void ecav_notify(GAtResult *result, gpointer=
 user_data)
>  	if (status =3D=3D CALL_STATUS_DIALING ||
>  			status =3D=3D CALL_STATUS_WAITING ||
>  			status =3D=3D CALL_STATUS_INCOMING) {
> -		if (!g_at_result_iter_next_string(&iter, &num))
> -			return;
> -
> -		if (!g_at_result_iter_next_number(&iter, &num_type))
> +		/*
> +		* If caller uses hidden id, the number and
> +		* number type might not be present. Don't
> +		* look for type if number is not present.
> +		*/

please fix the comment according coding style. See M2.

> +		if (!g_at_result_iter_next_string(&iter, &num)) {
> +			num=3D"";

This needs to be num =3D ""; btw.

> +			num_type =3D 128;
> +		}
> +		else if (!g_at_result_iter_next_number(&iter, &num_type))
>  			return;

And the else here should be on the same line as with the }.

Regards

Marcel



--===============6411054797460655119==--

