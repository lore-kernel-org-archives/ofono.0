Content-Type: multipart/mixed; boundary="===============4109493864047792893=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sms: Add delay before submitting multiple SMS to modem
Date: Wed, 22 Aug 2012 17:57:16 -0500
Message-ID: <503563CC.2000503@gmail.com>
In-Reply-To: <1345627755-14091-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4109493864047792893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 08/22/2012 04:29 AM, Guillaume Zajac wrote:
> For 3GPP GSM test case 34.2.9.1 and 34.2.9.1 and WCDMA test
> case 16.1.9.1 and 16.1.9.2, we need to transmitmultiple SMS
> using same RRC channel.
> oFono needs to wait its tx queue to be filled in with the
> next SMS before submitting the first one to use +CMMS=3D1 modem
> option.
> ---
>   src/sms.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/src/sms.c b/src/sms.c
> index acfc39b..443e502 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -50,6 +50,8 @@
>   #define TXQ_MAX_RETRIES 4
>   #define NETWORK_TIMEOUT 332
>
> +#define SMS_TX_NEXT 500
> +
>   static gboolean tx_next(gpointer user_data);
>
>   static GSList *g_drivers =3D NULL;
> @@ -2072,7 +2074,7 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, G=
SList *list,
>   	g_queue_push_tail(sms->txq, entry);
>
>   	if (sms->registered&&  g_queue_get_length(sms->txq) =3D=3D 1)
> -		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
> +		sms->tx_source =3D g_timeout_add(SMS_TX_NEXT, tx_next, sms);
>

Umm, I don't even know how to respond to this.  Lets just say that this =

isn't going to be accepted upstream ;)  Why don't you use multi-segment =

SMS, or queue the messages offline.

>   	if (uuid)
>   		memcpy(uuid,&entry->uuid, sizeof(*uuid));

Regards,
-Denis

--===============4109493864047792893==--

