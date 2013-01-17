Content-Type: multipart/mixed; boundary="===============5042019011495533495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Delay AT+CLCC request after outgoing callsetup
Date: Wed, 16 Jan 2013 21:37:12 -0600
Message-ID: <50F771E8.1000305@gmail.com>
In-Reply-To: <c97f1d8ae1e614a832b53b2b0c6f5da33c710a97.1357896034.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5042019011495533495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On 01/11/2013 07:00 AM, mail(a)timomueller.eu wrote:
> From: Timo Mueller<timo.mueller@bmw-carit.de>
>
> Currently the list of current calls is requested right after an
> outgoing callsetup has been reported by the AG device. If the AG
> device updates the list after reporting the callsetup the +CLCC
> response may not contain the new call and it is not registered
> with oFono.
>
> AT sequence that exhibited the failure (AG device was a Nokia N9
> placing an outgoing call)
>
> <  \r\n+CIEV: 5,2\r\n

So here it tells us that the callsetup is 2 (e.g. dialing)

>> AT+CLCC\r
> <  \r\nOK\r\n

And then it tells us "There are no calls to see here..."

Big. Fail. ;)

> <  \r\n+VGS=3D7\r\n
> <  \r\n+VGM=3D7\r\n
> <  \r\n+CIEV: 5,3\r\n
> <  \r\n+CIEV: 4,1\r\n
> <  \r\n+CIEV: 5,0\r\n
> ---
>   drivers/hfpmodem/voicecall.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index 505601c..c7c5f45 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -912,8 +912,11 @@ static void ciev_callsetup_notify(struct ofono_voice=
call *vc,
>   		 * from HF: query and sync the phone number.
>   		 * from AG: query and create call.
>   		 */
> -		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
> -				clcc_poll_cb, vc, NULL);
> +		if (vd->clcc_source)
> +			g_source_remove(vd->clcc_source);
> +
> +		vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
> +							poll_clcc, vc);

Actually I really don't like this, you are delaying the call detection =

for all devices (even good ones) because of one broken one.

I'd rather we request the CLCC immediately, but set a flag to retry the =

CLCC after a timeout in case the call list is not what we expected.

>   		break;
>
>   	case 3:

Regards,
-Denis

--===============5042019011495533495==--

