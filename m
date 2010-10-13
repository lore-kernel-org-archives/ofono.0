Content-Type: multipart/mixed; boundary="===============2677891727357584209=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 3/4] gprs: watch modem state
Date: Wed, 13 Oct 2010 15:53:01 -0500
Message-ID: <4CB61C2D.7080104@gmail.com>
In-Reply-To: <1286278512-3529-4-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2677891727357584209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/05/2010 06:35 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Indicate detach when modem is in offline state.
> ---
>  src/gprs.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> =

> diff --git a/src/gprs.c b/src/gprs.c
> index 3f085ed..431275c 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -76,6 +76,7 @@ struct ofono_gprs {
>  	struct ofono_netreg *netreg;
>  	unsigned int netreg_watch;
>  	unsigned int status_watch;
> +	unsigned int online_watch;
>  	GKeyFile *settings;
>  	char *imsi;
>  	DBusMessage *pending;
> @@ -1048,8 +1049,17 @@ static void gprs_attach_callback(const struct ofon=
o_error *error, void *data)
>  =

>  static void gprs_netreg_update(struct ofono_gprs *gprs)
>  {
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>  	ofono_bool_t attach;
>  =

> +	if (!ofono_modem_get_online(modem)) {
> +		gprs->flags &=3D ~(GPRS_FLAG_RECHECK | GPRS_FLAG_ATTACHING);
> +		gprs->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +		gprs->driver_attached =3D FALSE;
> +		gprs_attached_update(gprs);
> +		return;
> +	}
> +
>  	attach =3D gprs->netreg_status =3D=3D NETWORK_REGISTRATION_STATUS_REGIS=
TERED;
>  =

>  	attach =3D attach || (gprs->roaming_allowed &&
> @@ -1740,6 +1750,11 @@ static void gprs_unregister(struct ofono_atom *ato=
m)
>  		gprs->cid_map =3D NULL;
>  	}
>  =

> +	if (gprs->online_watch) {
> +		__ofono_modem_remove_state_watch(modem, gprs->online_watch);
> +		gprs->online_watch =3D 0;
> +	}
> +
>  	if (gprs->netreg_watch) {
>  		if (gprs->status_watch) {
>  			__ofono_netreg_remove_status_watch(gprs->netreg,
> @@ -1844,6 +1859,14 @@ static void netreg_watch(struct ofono_atom *atom,
>  	gprs_netreg_update(gprs);
>  }
>  =

> +static void online_watch(enum ofono_modem_state modem_state, void *data)
> +{
> +	struct ofono_gprs *gprs =3D data;
> +
> +	if (modem_state !=3D MODEM_STATE_ONLINE)
> +		gprs_netreg_update(gprs);

So again, the question is whether it is better to watch for the netreg
atom going away instead of using an online/offline watch...

> +}
> +
>  static gboolean load_context(struct ofono_gprs *gprs, const char *group)
>  {
>  	char *name =3D NULL;
> @@ -2041,6 +2064,9 @@ void ofono_gprs_register(struct ofono_gprs *gprs)
>  	ofono_modem_add_interface(modem,
>  				OFONO_CONNECTION_MANAGER_INTERFACE);
>  =

> +	gprs->online_watch =3D __ofono_modem_add_state_watch(modem,
> +					online_watch, gprs, NULL);
> +
>  	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
>  =

>  	if (sim_atom) {

Regards,
-Denis

--===============2677891727357584209==--

