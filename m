Content-Type: multipart/mixed; boundary="===============6865390356023420047=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 1/4] modem: add modem state watch
Date: Wed, 13 Oct 2010 15:39:25 -0500
Message-ID: <4CB618FD.6050006@gmail.com>
In-Reply-To: <1286278512-3529-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6865390356023420047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras & Pekka,

<snip>

> diff --git a/src/ofono.h b/src/ofono.h
> index 6c7f649..9021f51 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -177,6 +177,21 @@ unsigned int __ofono_modemwatch_add(ofono_modemwatch=
_cb_t cb, void *user,
>  					ofono_destroy_func destroy);
>  gboolean __ofono_modemwatch_remove(unsigned int id);
>  =

> +enum ofono_modem_state {
> +	MODEM_STATE_POWER_OFF,
> +	MODEM_STATE_PRE_SIM,
> +	MODEM_STATE_OFFLINE,
> +	MODEM_STATE_ONLINE,
> +};

Personally I don't see the need for anything besides an online/offline
watch.  Nobody will ever care about the other states.

> +
> +typedef void (*ofono_modem_state_notify_func)(enum ofono_modem_state sta=
te,
> +						void *data);

So I suggest ofono_modem_online_notify_func(gboolean online, void *data)

> +unsigned int __ofono_modem_add_state_watch(struct ofono_modem *modem,
> +				ofono_modem_state_notify_func notify,
> +				void *data, ofono_destroy_func destroy);
> +void __ofono_modem_remove_state_watch(struct ofono_modem *modem,
> +					unsigned int id);
> +

And add/remove online_watch here

>  #include <ofono/call-barring.h>
>  =

>  gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);

Regards,
-Denis

--===============6865390356023420047==--

