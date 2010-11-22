Content-Type: multipart/mixed; boundary="===============2964309876837818267=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 1/6] voicecall: fix dial result
 handling
Date: Mon, 22 Nov 2010 07:43:56 -0600
Message-ID: <4CEA739C.4070401@gmail.com>
In-Reply-To: <1289927124-30133-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2964309876837818267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/16/2010 11:05 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> If there is an existing active call when dialing the existing call will
> be automatically put on hold. The dialing result handling depended on
> the voicecall driver putting the call on hold before the dial command
> callback is called.
> =

> However, this is not true on isimodem driver, where the dial request
> returns immediately before the existing call have changed its
> status. The dial result handling now checks if the active call has been
> resulted from the dial request.
> ---
>  src/voicecall.c |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index bd64432..e3ce2a5 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -68,6 +68,7 @@ struct voicecall {
>  	char *message;
>  	uint8_t icon_id;
>  	gboolean untracked;
> +	gboolean dial_result_handled;
>  };
>  =

>  struct dial_request {
> @@ -1096,9 +1097,20 @@ static struct voicecall *dial_handle_result(struct=
 ofono_voicecall *vc,
>  		v =3D l->data;
>  =

>  		if (v->call->status =3D=3D CALL_STATUS_DIALING ||
> -				v->call->status =3D=3D CALL_STATUS_ALERTING ||
> -				v->call->status =3D=3D CALL_STATUS_ACTIVE)
> +				v->call->status =3D=3D CALL_STATUS_ALERTING)
>  			return v;
> +
> +		/*
> +		 * Dial request may return before existing active call
> +		 * is put on hold or after dialed call has got active
> +		 */
> +		if (v->call->status =3D=3D CALL_STATUS_ACTIVE &&
> +				v->call->direction =3D=3D
> +				CALL_DIRECTION_MOBILE_ORIGINATED &&
> +				!v->dial_result_handled) {
> +			v->dial_result_handled =3D TRUE;
> +			return v;
> +		}

I really don't see how this can work, since you never reset
dial_result_handled to FALSE anywhere.

>  	}
>  =

>  	call =3D synthesize_outgoing_call(vc, number);
> @@ -1119,6 +1131,8 @@ static struct voicecall *dial_handle_result(struct =
ofono_voicecall *vc,
>  =

>  	*need_to_emit =3D TRUE;
>  =

> +	v->dial_result_handled =3D TRUE;
> +

dial_handle_result is ever called once, why do you need to set this here?

>  	return v;
>  }
>  =


This seems to be the wrong way to go, is there any way for you to delay
returning from the dial operation until the call is put on hold?

Regards,
-Denis

--===============2964309876837818267==--

