Content-Type: multipart/mixed; boundary="===============3697377421556906210=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Mon, 28 Feb 2011 16:19:07 -0600
Message-ID: <4D6C1F5B.60300@gmail.com>
In-Reply-To: <7010601938f3077559093876e1136dc9fd15afe5.1298883762.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3697377421556906210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 02/28/2011 10:28 AM, Andras Domokos wrote:
> ---
>  drivers/atmodem/ssn.c |    4 ++--
>  include/ssn.h         |    7 ++++---
>  src/ofono.h           |    5 +++--
>  src/ssn.c             |   11 ++++++-----
>  4 files changed, 15 insertions(+), 12 deletions(-)
> =

> diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
> index c927bf1..ba8f89a 100644
> --- a/drivers/atmodem/ssn.c
> +++ b/drivers/atmodem/ssn.c
> @@ -56,7 +56,7 @@ static void cssi_notify(GAtResult *result, gpointer use=
r_data)
>  	if (!g_at_result_iter_next_number(&iter, &index))
>  		index =3D 0;
>  =

> -	ofono_ssn_mo_notify(ssn, code1, index);
> +	ofono_ssn_mo_notify(ssn, 0, code1, index);
>  }
>  =

>  static void cssu_notify(GAtResult *result, gpointer user_data)
> @@ -93,7 +93,7 @@ static void cssu_notify(GAtResult *result, gpointer use=
r_data)
>  		return;
>  =

>  out:
> -	ofono_ssn_mt_notify(ssn, code2, index, &ph);
> +	ofono_ssn_mt_notify(ssn, 0, code2, index, &ph);
>  }
>  =

>  static void at_ssn_initialized(gboolean ok, GAtResult *result,
> diff --git a/include/ssn.h b/include/ssn.h
> index c8f3e0b..4f41bae 100644
> --- a/include/ssn.h
> +++ b/include/ssn.h
> @@ -37,9 +37,10 @@ struct ofono_ssn_driver {
>  };
>  =

>  /* SSN notifications (CSSI and CSSU).  */
> -void ofono_ssn_mo_notify(struct ofono_ssn *ssn, int code, int index);
> -void ofono_ssn_mt_notify(struct ofono_ssn *ssn, int code, int index,
> -				const struct ofono_phone_number *number);
> +void ofono_ssn_mo_notify(struct ofono_ssn *ssn, unsigned int id,
> +				int code1, int index);
> +void ofono_ssn_mt_notify(struct ofono_ssn *ssn, unsigned int id, int cod=
e2,
> +			int index, const struct ofono_phone_number *number);
>  =

>  int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
>  void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);

Please just remove the ssn atom completely and add these functions to
the voicecall atom.  e.g.:

ofono_voicecall_cssi_notify
ofono_voicecall_cssu_notify

or

ofono_voicecall_ssn_mt_notify
ofono_voicecall_ssn_mo_notify

> diff --git a/src/ofono.h b/src/ofono.h
> index 4e298f1..4af6f86 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -346,8 +346,9 @@ int __ofono_sms_sim_download(struct ofono_stk *stk, c=
onst struct sms *msg,
>  =

>  #include <ofono/ssn.h>
>  =

> -typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
> -typedef void (*ofono_ssn_mt_notify_cb)(int index,
> +typedef void (*ofono_ssn_mo_notify_cb)(unsigned int id, int code1, int i=
ndex,
> +					void *user);
> +typedef void (*ofono_ssn_mt_notify_cb)(unsigned int id, int code2, int i=
ndex,
>  					const struct ofono_phone_number *ph,
>  					void *user);
>  =

> diff --git a/src/ssn.c b/src/ssn.c
> index ee48fba..383114c 100644
> --- a/src/ssn.c
> +++ b/src/ssn.c
> @@ -111,7 +111,8 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn=
 *ssn, unsigned int id)
>  	return __ofono_watchlist_remove_item(ssn->mt_handler_list, id);
>  }
>  =

> -void ofono_ssn_mo_notify(struct ofono_ssn *ssn, int code1, int index)
> +void ofono_ssn_mo_notify(struct ofono_ssn *ssn, unsigned int id,
> +				int code1, int index)
>  {
>  	struct ssn_handler *h;
>  	GSList *l;
> @@ -122,12 +123,12 @@ void ofono_ssn_mo_notify(struct ofono_ssn *ssn, int=
 code1, int index)
>  		notify =3D h->item.notify;
>  =

>  		if (h->code =3D=3D code1)
> -			notify(index, h->item.notify_data);
> +			notify(id, code1, index, h->item.notify_data);
>  	}
>  }
>  =

> -void ofono_ssn_mt_notify(struct ofono_ssn *ssn, int code2, int index,
> -				const struct ofono_phone_number *ph)
> +void ofono_ssn_mt_notify(struct ofono_ssn *ssn, unsigned int id, int cod=
e2,
> +				int index, const struct ofono_phone_number *ph)
>  {
>  	struct ssn_handler *h;
>  	GSList *l;
> @@ -138,7 +139,7 @@ void ofono_ssn_mt_notify(struct ofono_ssn *ssn, int c=
ode2, int index,
>  		notify =3D h->item.notify;
>  =

>  		if (h->code =3D=3D code2)
> -			notify(index, ph, h->item.notify_data);
> +			notify(id, code2, index, ph, h->item.notify_data);
>  	}
>  }
>  =


Regards,
-Denis

--===============3697377421556906210==--

