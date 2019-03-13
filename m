Content-Type: multipart/mixed; boundary="===============5992656434102436386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/14] Fix whitespace weirdness
Date: Wed, 13 Mar 2019 13:14:29 -0500
Message-ID: <f9272b3c-2955-4d26-4330-f5792e346040@gmail.com>
In-Reply-To: <20190312111008.29258-2-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5992656434102436386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/12/2019 06:09 AM, Jonas Bonn wrote:
> ---
>   drivers/atmodem/network-registration.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 2482dfc3..1704f98c 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -1559,12 +1559,12 @@ static void creg_notify(GAtResult *result, gpoint=
er user_data)
>   					option_query_tech_cb, tq, g_free) > 0)
>   			return;
>   		break;
> -    case OFONO_VENDOR_GEMALTO:
> -              if (g_at_chat_send(nd->chat, "AT^SMONI",
> -                                      smoni_prefix,
> -                                      gemalto_query_tech_cb, tq, g_free)=
 > 0)
> -                      return;
> -              break;
> +	case OFONO_VENDOR_GEMALTO:
> +		if (g_at_chat_send(nd->chat, "AT^SMONI",
> +			      smoni_prefix,
> +			      gemalto_query_tech_cb, tq, g_free) > 0)

You still left some spaces in here.  Anyway I fixed this up for you and =

applied.

> +			return;
> +		break;
>   	}
>   =

>   	g_free(tq);
> =


Regards,
-Denis

--===============5992656434102436386==--

