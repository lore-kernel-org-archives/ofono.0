Content-Type: multipart/mixed; boundary="===============2849258735252102753=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stemodem: Fix for MT call not working when caller id is
 hidden.
Date: Fri, 17 Dec 2010 10:09:37 -0600
Message-ID: <4D0B8B41.8020801@gmail.com>
In-Reply-To: <1292507791-23495-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2849258735252102753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

On 12/16/2010 07:56 AM, Marit Henriksen wrote:
> From: Marit Henriksen <marit.henriksen@stericsson.com>
> =

> In *ECAV, the number will not be included if caller id is hidden.
> Set it to an empty string in that case.
> ---
>  drivers/stemodem/voicecall.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
> index b9d91d2..d900666 100644
> --- a/drivers/stemodem/voicecall.c
> +++ b/drivers/stemodem/voicecall.c
> @@ -442,10 +442,14 @@ static void ecav_notify(GAtResult *result, gpointer=
 user_data)
>  	if (status =3D=3D CALL_STATUS_DIALING ||
>  			status =3D=3D CALL_STATUS_WAITING ||
>  			status =3D=3D CALL_STATUS_INCOMING) {
> +		/*
> +		* If caller uses hidden id, the number and
> +		* number type might not be present. Don't
> +		* look for type if number is not present.
> +		*/
>  		if (!g_at_result_iter_next_string(&iter, &num))
> -			return;
> -
> -		if (!g_at_result_iter_next_number(&iter, &num_type))
> +			num =3D "";
> +		else if (!g_at_result_iter_next_number(&iter, &num_type))
>  			return;

One small nitpick, but you're not initializing num_type if the number is
missing.  While this probably works out, I'd rather be a bit more
pedantic inside the driver.  Can you initialize it to unknown number
type (I think 128 is preferred by 27.007) in this case?

>  	}
>  =


I also notice that you're not ever able to report the clip_validity =3D=3D 1
case (e.g. number withheld).  Since oFono does make a distinction
between the various clip_validity types, it would be nice if there was a
way around this limitation.

Regards,
-Denis

--===============2849258735252102753==--

