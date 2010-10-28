Content-Type: multipart/mixed; boundary="===============6336794377628135427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/3] modem: modem state watch added
Date: Wed, 27 Oct 2010 22:31:04 -0500
Message-ID: <4CC8EE78.1090705@gmail.com>
In-Reply-To: <20107c376577d58b02933ff17f0fb8483f50462e.1287763218.git.andras.domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6336794377628135427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 10/25/2010 03:03 AM, Andras Domokos wrote:
> From: Andras Domokos <andras.domokos@nokia.com>
> =


<snip>

> diff --git a/src/ofono.h b/src/ofono.h
> index 6c7f649..b132727 100644
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

Please see doc/coding-style.txt item M11.

> +};
> +
> +typedef void (*ofono_modem_state_notify_func)(enum ofono_modem_state sta=
te,
> +		void *data);
> +unsigned int __ofono_modem_add_state_watch(struct ofono_modem *modem,
> +		ofono_modem_state_notify_func notify,
> +		void *data, ofono_destroy_func destroy);
> +void __ofono_modem_remove_state_watch(struct ofono_modem *modem,
> +		unsigned int id);
> +

I believe that me and Pekka already agreed not to use MODEM_STATE, but
instead only watch for the online state of the modem.

>  #include <ofono/call-barring.h>
>  =

>  gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);

Regards,
-Denis

--===============6336794377628135427==--

