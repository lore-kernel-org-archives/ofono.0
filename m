Content-Type: multipart/mixed; boundary="===============2453412514822123228=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/13] voicecall: __ofono_voicecall_send_tone internal api.
Date: Thu, 14 Oct 2010 03:47:29 -0500
Message-ID: <4CB6C3A1.3090508@gmail.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2453412514822123228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/13/2010 08:54 AM, Andrzej Zaborowski wrote:
> This provides a way for other atoms to send DTMF tones during a call.
> ---
>  src/ofono.h     |    4 ++++
>  src/voicecall.c |   16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index 6c7f649..6efd9ac 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -218,6 +218,10 @@ int __ofono_voicecall_dial(struct ofono_voicecall *v=
c,
>  				ofono_voicecall_dial_cb_t cb, void *user_data);
>  void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
>  =

> +int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
> +				const char *tone_str,
> +				ofono_voicecall_cb_t cb, void *user_data);
> +

So this one is structured according to __ofono_voicecall_dial, should we
also have __ofono_voicecall_send_tone_cancel?

>  #include <ofono/sms.h>
>  =

>  struct sms;
> diff --git a/src/voicecall.c b/src/voicecall.c
> index 7b5fe3b..45e19ce 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -2326,3 +2326,19 @@ void __ofono_voicecall_dial_cancel(struct ofono_vo=
icecall *vc)
>  =

>  	vc->dial_req->cb =3D NULL;
>  }
> +
> +int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
> +				const char *tone_str,
> +				ofono_voicecall_cb_t cb, void *user_data)
> +{
> +	if (!vc->driver->send_tones)
> +		return -ENOSYS;
> +
> +	/* Send DTMFs only if we have at least one connected call */
> +	if (!voicecalls_can_dtmf(vc))
> +		return -ENOENT;

I'm a bit worried that we never check for BUSY conditions here, in
particular since we can get into this situation:

Send DTMF
Cancel
Send DTMF

Which results in two DTMF operations being outstanding.

> +
> +	vc->driver->send_tones(vc, tone_str, cb, user_data);
> +
> +	return 0;
> +}

We also don't busy out any D-Bus operations when Send DTMF is in progress...

Regards,
-Denis

--===============2453412514822123228==--

