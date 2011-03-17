Content-Type: multipart/mixed; boundary="===============0427438230706390597=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] sms: limit the sms sending retry
Date: Thu, 17 Mar 2011 12:13:11 -0500
Message-ID: <4D824127.9050604@gmail.com>
In-Reply-To: <1300379798-3390-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0427438230706390597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/17/2011 11:36 AM, Jeevaka Badrappan wrote:
> ---
>  src/sms.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index 01f54dd..c4f8b54 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -47,6 +47,7 @@
>  #define SETTINGS_GROUP "Settings"
>  =

>  #define TXQ_MAX_RETRIES 4
> +#define NETWORK_TIMEOUT 332
>  =

>  static gboolean tx_next(gpointer user_data);
>  =

> @@ -630,6 +631,10 @@ static void tx_finished(const struct ofono_error *er=
ror, int mr, void *data)
>  		if (sms->registered =3D=3D FALSE)
>  			return;
>  =

> +		/* Retry done only for Network Timeout failure */
> +		if (error->error !=3D NETWORK_TIMEOUT)
> +			goto next_q;
> +

Please also check error->type here to be CMS error.

>  		if (!(entry->flags & OFONO_SMS_SUBMIT_FLAG_RETRY))
>  			goto next_q;
>  =


Regards,
-Denis

--===============0427438230706390597==--

