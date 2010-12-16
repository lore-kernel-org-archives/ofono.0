Content-Type: multipart/mixed; boundary="===============1530267850029479931=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] network: query signal strength when status changes to
 registered or roaming.
Date: Thu, 16 Dec 2010 16:52:19 -0200
Message-ID: <20101216185219.GE5927@vigoh>
In-Reply-To: <1291388441-16730-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1530267850029479931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

Your commit subject is too big, you should not use more than 72 characters
there. Ideally you should not use more than 50, but up to 72 is still ok.
Leave the additional info to the commit message.

* Marit Henriksen <maritsofie.henriksen8@gmail.com> [2010-12-03 16:00:41 =
+0100]:

> From: Marit Henriksen <marit.henriksen@stericsson.com>
> =

> Signal strength is set to -1 whenever registration status changes
> and differs from registered or roaming. When registration status
> changes again to registered or roaming, the signal strength needs to
> be updated, so add query towards driver to get it.
> ---
>  src/network.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)
> =

> diff --git a/src/network.c b/src/network.c
> index d5b42a1..80fa83d 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1296,6 +1296,19 @@ emit:
>  	notify_status_watches(netreg);
>  }
>  =

> +static void signal_strength_callback(const struct ofono_error *error,
> +					int strength, void *data)
> +{
> +	struct ofono_netreg *netreg =3D data;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		DBG("Error during signal strength query");
> +		return;
> +	}
> +
> +	ofono_netreg_strength_notify(netreg, strength);
> +}
> +
>  void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
>  			int lac, int ci, int tech)
>  {
> @@ -1319,6 +1332,9 @@ void ofono_netreg_status_notify(struct ofono_netreg=
 *netreg, int status,
>  		if (netreg->driver->current_operator)
>  			netreg->driver->current_operator(netreg,
>  					current_operator_callback, netreg);
> +		if (netreg->driver->strength)
> +			netreg->driver->strength(netreg,
> +					signal_strength_callback, netreg);
>  	} else {
>  		struct ofono_error error;
>  =

> @@ -1345,19 +1361,6 @@ void ofono_netreg_time_notify(struct ofono_netreg =
*netreg,
>  	__ofono_nettime_info_received(modem, info);
>  }
>  =

> -static void signal_strength_callback(const struct ofono_error *error,
> -					int strength, void *data)
> -{
> -	struct ofono_netreg *netreg =3D data;
> -
> -	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		DBG("Error during signal strength query");
> -		return;
> -	}
> -
> -	ofono_netreg_strength_notify(netreg, strength);
> -}
> -
>  static void init_registration_status(const struct ofono_error *error,
>  					int status, int lac, int ci, int tech,
>  					void *data)

Otherwise patch looks good.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============1530267850029479931==--

