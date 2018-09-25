Content-Type: multipart/mixed; boundary="===============5003625410153332646=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/sms: no mms support for gemalto
Date: Tue, 25 Sep 2018 09:49:25 -0500
Message-ID: <55cd4a9f-623f-1583-6528-c5b893c49870@gmail.com>
In-Reply-To: <20180925131937.19265-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5003625410153332646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/25/2018 08:19 AM, Giacinto Cifelli wrote:
> ---
>   drivers/atmodem/sms.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 64169086..64d0f6e8 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -219,10 +219,16 @@ static void at_cmgs(struct ofono_sms *sms, const un=
signed char *pdu,
>   	char buf[512];
>   	int len;
>   =

> -	if (mms) {
> -		snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
> -		g_at_chat_send(data->chat, buf, none_prefix,
> -				NULL, NULL, NULL);
> +	switch(data->vendor) {

Space after switch

> +	case OFONO_VENDOR_GEMALTO:
> +		break;
> +	default:
> +		if (mms) {
> +			snprintf(buf, sizeof(buf), "AT+CMMS=3D%d", mms);
> +			g_at_chat_send(data->chat, buf, none_prefix,
> +					NULL, NULL, NULL);
> +		}
> +		break;
>   	}

Hmm, wouldn't this be more logical & readable this way:

if (mms) {
	switch (data->vendor) {
	case:
	default:
	}
}

>   =

>   	len =3D snprintf(buf, sizeof(buf), "AT+CMGS=3D%d\r", tpdu_len);
> =


Regards,
-Denis

--===============5003625410153332646==--

