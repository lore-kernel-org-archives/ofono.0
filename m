Content-Type: multipart/mixed; boundary="===============7632410561963864740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check pins even if language checks fails
Date: Wed, 25 Aug 2010 11:48:01 -0500
Message-ID: <4C754941.40306@gmail.com>
In-Reply-To: <1282743841-25151-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7632410561963864740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/25/2010 08:44 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> ---
>  src/sim.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index a450b30..be2793b 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1373,7 +1373,7 @@ skip_efpl:
>  	}
>  =

>  	if (sim->language_prefs =3D=3D NULL)
> -		return;
> +		goto done;
>  =

>  	ofono_dbus_signal_array_property_changed(conn, path,
>  						OFONO_SIM_MANAGER_INTERFACE,
> @@ -1381,6 +1381,7 @@ skip_efpl:
>  						DBUS_TYPE_STRING,
>  						&sim->language_prefs);
>  =

> +done:
>  	sim_pin_check(sim);
>  }
>  =


Good catch, I ended up solving it slightly differently.

Regards,
-Denis

--===============7632410561963864740==--

