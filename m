Content-Type: multipart/mixed; boundary="===============1121704760256586332=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] core: notify watches of already registered atoms
Date: Tue, 29 Mar 2011 14:35:00 -0500
Message-ID: <4D923464.5000401@gmail.com>
In-Reply-To: <1301384910-28272-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1121704760256586332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/29/2011 02:48 AM, Mika Liljeberg wrote:
> ---
>  src/modem.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index 655994b..d22c718 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -271,6 +271,9 @@ unsigned int __ofono_modem_add_atom_watch(struct ofon=
o_modem *modem,
>  					void *data, ofono_destroy_func destroy)
>  {
>  	struct atom_watch *watch;
> +	unsigned int id;
> +	GSList *l;
> +	struct ofono_atom *atom;
>  =

>  	if (notify =3D=3D NULL)
>  		return 0;
> @@ -282,8 +285,19 @@ unsigned int __ofono_modem_add_atom_watch(struct ofo=
no_modem *modem,
>  	watch->item.destroy =3D destroy;
>  	watch->item.notify_data =3D data;
>  =

> -	return __ofono_watchlist_add_item(modem->atom_watches,
> +	id =3D __ofono_watchlist_add_item(modem->atom_watches,
>  					(struct ofono_watchlist_item *)watch);
> +
> +	for (l =3D modem->atoms; l; l =3D l->next) {
> +		atom =3D l->data;
> +
> +		if (atom->type !=3D type || atom->unregister =3D=3D NULL)
> +			continue;
> +
> +		notify(atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, data);
> +	}
> +
> +	return id;
>  }
>  =

>  gboolean __ofono_modem_remove_atom_watch(struct ofono_modem *modem,

This patch is behavior changing.  Whether this is a good idea or not I'm
still undecided, though I see its merits.

However, I don't see how it is fixing anything.  The watches are called
only upon registration (which means the driver is probed and ready).  So
even if you create two netreg atoms in hopes of probing the modem type,
only one should ever register and this code should not be needed.

Regards,
-Denis

--===============1121704760256586332==--

