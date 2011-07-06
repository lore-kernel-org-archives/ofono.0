Content-Type: multipart/mixed; boundary="===============1732319038846884590=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecall: api for set/clear alpha and icon id
Date: Wed, 06 Jul 2011 01:38:27 -0500
Message-ID: <4E1402E3.8000608@gmail.com>
In-Reply-To: <1309946773-7747-3-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1732319038846884590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/06/2011 05:06 AM, Jeevaka Badrappan wrote:
> ---
>  src/ofono.h     |    5 +++++
>  src/voicecall.c |   21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 0 deletions(-)
> =

> diff --git a/src/ofono.h b/src/ofono.h
> index 6524806..118d762 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -266,6 +266,11 @@ int __ofono_voicecall_dial(struct ofono_voicecall *v=
c,
>  				ofono_voicecall_dial_cb_t cb, void *user_data);
>  void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
>  =

> +void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
> +						const char *message,
> +						unsigned char icon_id);
> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *v=
c);
> +

It seems we might need more information here, in particular the phone
number being dialed by STK.  I don't see how we would obtain this
information otherwise.

Also, since emergency numbers can be dialed by STK, we probably need
special logic for inc/dec of emergency counters as well.

>  int __ofono_voicecall_tone_send(struct ofono_voicecall *vc,
>  				const char *tone_str,
>  				ofono_voicecall_tone_cb_t cb, void *user_data);
> diff --git a/src/voicecall.c b/src/voicecall.c
> index 9620838..b193d61 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -74,6 +74,8 @@ struct ofono_voicecall {
>  	struct dial_request *dial_req;
>  	GQueue *toneq;
>  	guint tone_source;
> +	char *message;
> +	uint8_t icon_id;

I don't really like this, is there a way we can re-use the dial_req
structure, as that one already contains the message, icon_id and phone
number members we need.

>  	unsigned int hfp_watch;
>  	GKeyFile *settings;
>  	char *imsi;
> @@ -656,6 +658,11 @@ static struct voicecall *voicecall_create(struct ofo=
no_voicecall *vc,
>  	v->call =3D call;
>  	v->vc =3D vc;
>  =

> +	if (vc->message !=3D NULL) {
> +		v->message =3D g_strdup(vc->message);
> +		v->icon_id =3D vc->icon_id;
> +	}
> +
>  	return v;
>  }
>  =

> @@ -3538,6 +3545,20 @@ void __ofono_voicecall_tone_cancel(struct ofono_vo=
icecall *vc, int id)
>  	}
>  }
>  =

> +void __ofono_voicecall_set_alpha_and_icon_id(struct ofono_voicecall *vc,
> +						const char *message,
> +						unsigned char icon_id)
> +{
> +	vc->message =3D g_strdup(message);
> +	vc->icon_id =3D icon_id;
> +}
> +
> +void __ofono_voicecall_clear_alpha_and_icon_id(struct ofono_voicecall *v=
c)
> +{
> +	g_free(vc->message);
> +	vc->icon_id =3D 0;
> +}
> +
>  static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
>  					unsigned int id, int code,
>  					const struct ofono_phone_number *ph)

Regards,
-Denis

--===============1732319038846884590==--

