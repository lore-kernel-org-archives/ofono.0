Content-Type: multipart/mixed; boundary="===============0429926071605785959=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] voicecall: api for set/clear alpha and icon id
Date: Tue, 19 Jul 2011 15:52:30 -0500
Message-ID: <4E25EE8E.7060907@gmail.com>
In-Reply-To: <1311059607-10695-2-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0429926071605785959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/19/2011 02:13 AM, Jeevaka Badrappan wrote:
> ---
>  src/ofono.h     |    6 +++++
>  src/voicecall.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 68 insertions(+), 0 deletions(-)

Looks nearly there, just a few minor nitpicks:

> =

> diff --git a/src/ofono.h b/src/ofono.h
> index 6524806..808a8f1 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -266,6 +266,12 @@ int __ofono_voicecall_dial(struct ofono_voicecall *v=
c,
>  				ofono_voicecall_dial_cb_t cb, void *user_data);
>  void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
>  =

> +void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
> +						const char *addr, int addr_type,
> +						const char *message,
> +						unsigned char icon_id);
> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *v=
c);
> +
>  int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
>  				const char *tone_str,
>  				ofono_voicecall_tone_cb_t cb, void *user_data);
> diff --git a/src/voicecall.c b/src/voicecall.c
> index 3646951..03a0c96 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -42,6 +42,7 @@
>  #define MAX_VOICE_CALLS 16
>  =

>  #define VOICECALL_FLAG_SIM_ECC_READY 0x1
> +#define VOICECALL_FLAG_STK_MODEM_CALLSETUP 0x2
>  =

>  #define SETTINGS_STORE "voicecall"
>  #define SETTINGS_GROUP "Settings"
> @@ -2158,6 +2159,8 @@ void ofono_voicecall_disconnected(struct ofono_voic=
ecall *vc, int id,
>  	voicecall_dbus_unregister(vc, call);
>  =

>  	vc->call_list =3D g_slist_remove(vc->call_list, call);
> +
> +	vc->flags &=3D ~VOICECALL_FLAG_STK_MODEM_CALLSETUP;

This doesn't seem like it belongs here.  In fact there are situations
where even with an STK call setup pending, disconnections can still
happen. See TS 102.223 Section 6.4.13, in particular the case where
existing calls are put on hold (e.g. remote disconnection) or existing
calls being dropped.

>  }
>  =

>  void ofono_voicecall_notify(struct ofono_voicecall *vc,
> @@ -2204,6 +2207,31 @@ void ofono_voicecall_notify(struct ofono_voicecall=
 *vc,
>  		goto error;
>  	}
>  =

> +	if (vc->flags & VOICECALL_FLAG_STK_MODEM_CALLSETUP) {
> +		struct dial_request *req =3D vc->dial_req;
> +		const char *number =3D phone_number_to_string(&req->ph);
> +
> +		if (!strcmp(number, "112")) {
> +			struct ofono_modem *modem =3D
> +					__ofono_atom_get_modem(vc->atom);
> +
> +			__ofono_modem_inc_emergency_mode(modem);
> +		}
> +

Are you forgetting to copy CLIP information in case the call doesn't
provide one?

> +		v->message =3D req->message;
> +		v->icon_id =3D req->icon_id;
> +
> +		req->message =3D NULL;
> +		req->call =3D v;
> +
> +		/*
> +		 * TS 102 223 Section 6.4.13: The terminal shall not store
> +		 * in the UICC the call set-up details (called party number
> +		 * and associated parameters)
> +		 */
> +		v->untracked =3D TRUE;

You should probably clear the STK_MODEM_CALLSETUP flag here, unless you
have another idea.

> +	}
> +
>  	v->detect_time =3D time(NULL);
>  =

>  	if (!voicecall_dbus_register(v)) {
> @@ -3659,6 +3687,40 @@ void __ofono_voicecall_tone_cancel(struct ofono_vo=
icecall *vc, int id)
>  	}
>  }
>  =

> +void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
> +						const char *addr, int addr_type,
> +						const char *message,
> +						unsigned char icon_id)
> +{
> +	struct dial_request *req;
> +
> +	req =3D g_new0(struct dial_request, 1);
> +
> +	req->message =3D g_strdup(message);
> +	req->icon_id =3D icon_id;
> +
> +	req->ph.type =3D addr_type;
> +	strncpy(req->ph.number, addr, 20);
> +
> +	vc->dial_req =3D req;
> +
> +	vc->flags |=3D VOICECALL_FLAG_STK_MODEM_CALLSETUP;
> +}
> +
> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *v=
c)
> +{
> +	if (vc->dial_req =3D=3D NULL)
> +		return;
> +

We should not be calling this function if dial_req is NULL, so I'd
rather crash here if we do.  Especially since this API is private.

> +	g_free(vc->dial_req->message);
> +	vc->dial_req->message =3D NULL;
> +
> +	g_free(vc->dial_req);
> +	vc->dial_req =3D NULL;
> +
> +	vc->flags &=3D ~VOICECALL_FLAG_STK_MODEM_CALLSETUP;
> +}
> +
>  static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
>  					unsigned int id, int code,
>  					const struct ofono_phone_number *ph)

Regards,
-Denis

--===============0429926071605785959==--

