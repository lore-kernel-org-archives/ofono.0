Content-Type: multipart/mixed; boundary="===============8389402016448985117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Fri, 15 Jul 2011 11:08:14 -0500
Message-ID: <4E2065EE.7010902@gmail.com>
In-Reply-To: <1310733734-4206-3-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8389402016448985117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/15/2011 07:42 AM, Jeevaka Badrappan wrote:
> ---
>  src/ofono.h     |    6 ++++
>  src/voicecall.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 82 insertions(+), 0 deletions(-)
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
> index 3646951..33041a1 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -2204,6 +2204,25 @@ void ofono_voicecall_notify(struct ofono_voicecall=
 *vc,
>  		goto error;
>  	}
>  =

> +	if (vc->dial_req) {
> +		v->message =3D vc->dial_req->message;
> +		v->icon_id =3D vc->dial_req->icon_id;
> +
> +		vc->dial_req->message =3D NULL;
> +		vc->dial_req->call =3D v;
> +
> +		newcall->phone_number.type =3D vc->dial_req->ph.type;
> +		strncpy(newcall->phone_number.number, vc->dial_req->ph.number,
> +									20);

Do you really want to do this?  I suspect we should override the phone
number information only if the CLIP validity is not valid.

> +
> +		/*
> +		 * TS 102 223 Section 6.4.13: The terminal shall not store
> +		 * in the UICC the call set-up details (called party number
> +		 * and associated parameters)
> +		 */
> +		v->untracked =3D TRUE;
> +	}
> +

This looks fine, but there's a very subtle thing going on which breaks
one particular case.  Some background, voicecall driver is free to
notify the call before returning from the atd callback, or vice versa.

So e.g.

#1
driver->dial(.., cb, data);
ofono_voicecall_notify()
cb(data);

or

#2
driver->dial(..., cb, data);
cb(data);
ofono_voicecall_notify()

In the case that oFono generates the Set Up Call Request and assuming
driver behavior #1, you end up performing some steps twice.  Perhaps we
should set a flag in vc->flags to indicate that the call setup is being
initiated by the modem, and only trigger this path if this flag is set.

e.g.

if (vc->flags & OFONO_VOICECALL_FLAG_STK_MODEM_CALLSETUP) {
	...
}

This flag should be set by set_alpha_and_icon_id

>  	v->detect_time =3D time(NULL);
>  =

>  	if (!voicecall_dbus_register(v)) {
> @@ -3659,6 +3678,63 @@ void __ofono_voicecall_tone_cancel(struct ofono_vo=
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
> +	const char *number;
> +
> +	req =3D g_new0(struct dial_request, 1);
> +
> +	req->message =3D g_strdup(message);
> +	req->icon_id =3D icon_id;
> +
> +	req->ph.type =3D addr_type;
> +	strncpy(req->ph.number, addr, 20);
> +
> +	number =3D phone_number_to_string(&req->ph);
> +
> +	if (!strcmp(number, "112")) {
> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +
> +		__ofono_modem_inc_emergency_mode(modem);
> +	}

I think we should do this step in the block of code in
ofono_voicecall_notify dealing with modem callsetup.  See below for more:

> +
> +	vc->dial_req =3D req;
> +}
> +
> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *v=
c)
> +{
> +	const char *number;
> +
> +	if (vc->dial_req =3D=3D NULL)
> +		return;
> +
> +	number =3D phone_number_to_string(&vc->dial_req->ph);
> +
> +	/*
> +	 * Incase the modem fails to setup the call and if there is no call
> +	 * created, then the emergency mode has to be cleared.
> +	 */
> +	if (!strcmp(number, "112")) {
> +		if (voicecalls_num_active(vc) =3D=3D 0 &&
> +				voicecalls_num_connecting(vc) =3D=3D 0) {
> +			struct ofono_modem *modem =3D
> +					__ofono_atom_get_modem(vc->atom);
> +
> +			__ofono_modem_dec_emergency_mode(modem);
> +		}
> +	}

I'm guessing what you're trying to take care of here is the case that
the set up call might have been canceled before the call was notified,
right?

Wouldn't it be better to do:

if (vc->dial_req->call =3D=3D NULL)
	...

?

However, in the end I think it is simpler to only initiate the emergency
mode when we have the call, and let it be deactivated by the disconnect
notification.  Then this function becomes way simpler.

> +
> +	g_free(vc->dial_req->message);
> +	vc->dial_req->message =3D NULL;
> +
> +	g_free(vc->dial_req);
> +	vc->dial_req =3D NULL;
> +}
> +

However, I'm actually questioning the need for this function since the
cancellation can only be accomplished by hanging up the call before it
is active, in which case the modem will take care of sending the
appropriate terminal response.

>  static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
>  					unsigned int id, int code,
>  					const struct ofono_phone_number *ph)

Regards,
-Denis

--===============8389402016448985117==--

