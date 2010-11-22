Content-Type: multipart/mixed; boundary="===============8938672606002194001=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/5] history: expand history API include file
Date: Mon, 22 Nov 2010 09:32:40 -0600
Message-ID: <4CEA8D18.5020303@gmail.com>
In-Reply-To: <0db5c7f505293243a66ef977ba41f2d793e3c38b.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8938672606002194001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 11/15/2010 05:50 AM, Andras Domokos wrote:
> ---
>  include/history.h |    3 +++
>  src/ofono.h       |    4 ++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/include/history.h b/include/history.h
> index c1c4aa1..a2490f6 100644
> --- a/include/history.h
> +++ b/include/history.h
> @@ -49,6 +49,9 @@ struct ofono_history_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_history_context *context);
>  	void (*remove)(struct ofono_history_context *context);
> +	void (*call_started)(struct ofono_history_context *context,
> +				const struct ofono_call *call,
> +				time_t start);
>  	void (*call_ended)(struct ofono_history_context *context,
>  				const struct ofono_call *call,
>  				time_t start, time_t end);

This belongs in a separate patch.

> diff --git a/src/ofono.h b/src/ofono.h
> index 4d76d20..61a0637 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -368,6 +368,10 @@ void __ofono_netreg_set_base_station_name(struct ofo=
no_netreg *netreg,
>  =

>  void __ofono_history_probe_drivers(struct ofono_modem *modem);
>  =

> +void __ofono_history_call_started(struct ofono_modem *modem,
> +				const struct ofono_call *call,
> +				time_t start);
> +
>  void __ofono_history_call_ended(struct ofono_modem *modem,
>  				const struct ofono_call *call,
>  				time_t start, time_t end);

This one should be grouped together with patch #2.

Regards,
-Denis

--===============8938672606002194001==--

