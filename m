Content-Type: multipart/mixed; boundary="===============1449474258406244458=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: do not hardcode TP-ValidityPeriod
Date: Thu, 16 Dec 2010 18:55:12 -0600
Message-ID: <4D0AB4F0.1040801@gmail.com>
In-Reply-To: <1291845421-1898-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1449474258406244458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 12/08/2010 03:57 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> ---
>  src/smsutil.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index f4eee24..59faaf7 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -3162,11 +3162,10 @@ GSList *sms_datagram_prepare(const char *to,
>  	memset(&template, 0, sizeof(struct sms));
>  	template.type =3D SMS_TYPE_SUBMIT;
>  	template.submit.rd =3D FALSE;
> -	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
> +	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_ABSENT;

Can I get a bit more of an explanation from you as to why the 'absent'
validity period is better than hardcoding this to 24 hours?

Regards,
-Denis

--===============1449474258406244458==--

