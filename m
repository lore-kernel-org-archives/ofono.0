Content-Type: multipart/mixed; boundary="===============4788995054737184314=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Handle repeated held call indicator
Date: Mon, 11 Jan 2016 12:04:37 -0600
Message-ID: <5693EEB5.8070000@gmail.com>
In-Reply-To: <1452532775-8557-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4788995054737184314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kuba,

On 01/11/2016 11:19 AM, Kuba Pawlak wrote:
> An issue with iPhone 5C iOS 9.2 triggers desynchronization in call
> states. When an active call is put on hold and another call arrives,
> it is in WAITING state. It should be possible to answer it by issuing
> AT+CHLD=3D2 but the phone changes its state to INCOMING so ATA should be
> used. This change is advertised by sending callheld:2 event, but it is
> not handled. This event can be used to trigger CLCC poll to synchronize
> call states.
>
> +CIEV: 3,1   <- first call arrives
> AT+CLCC
> +CLCC: 1,1,4,0,0,"01234567890",129
> OK
> RING
> +CLIP: "01234567890",129
> ATA
> OK
> +CIEV: 2,1
> +CIEV: 3,0.
> AT+CHLD=3D2.$  <- first call is put on hold
> OK
> +CIEV: 7,2   <- notification confirming that call #1 is on hold
> +CCWA: "09876543210",129,1     <- second call arrives
> +CIEV: 7,2
> +CIEV: 3,1
> AT+CLCC
> +CLCC: 1,1,1,0,0,"01234567890",129
> +CLCC: 2,1,5,0,0,"09876543210",129 <- new call is still in WAITING state
> OK
> +CIEV: 7,2 <- phone iternally promotes WAITING call to INCOMING

So looks like the iPhone should be sending us a callheld=3D0 instead of =

callheld=3D2.

> AT+CHLD=3D2  <- there is no WAITING call anymore, ATA should be used
> +CME ERROR:3
> ---
>   drivers/hfpmodem/voicecall.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index d0e9353796c335a1fc876779345eedeb6556345d..2b7524e9cccbbdb9d8ce1e47a=
91d2e32ccfbb6a8 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -1111,6 +1111,18 @@ static void ciev_callheld_notify(struct ofono_voic=
ecall *vc,
>   			vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
>   							poll_clcc, vc);
>   		}
> +		else {

Can you make sure this follows our coding style?  else should be on the =

same line as the previous }

> +			if (vd->clcc_source)
> +				g_source_remove(vd->clcc_source);
> +
> +			/* We got a notification that there is a held call
> +			 * and no active call but we already are in such state.
> +			 * Let's schedule a poll to see what happened.
> +			 */

This comment is also not according to our coding style.  Item M2.

> +			vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
> +							poll_clcc, vc);
> +		}
> +
>   	}
>
>   	vd->cind_val[HFP_INDICATOR_CALLHELD] =3D value;
>

Regards,
-Denis

--===============4788995054737184314==--

