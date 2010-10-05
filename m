Content-Type: multipart/mixed; boundary="===============0470208372721358777=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC online/offline atoms PATCH 1/4] modem: add modem state watch
Date: Tue, 05 Oct 2010 13:56:38 +0200
Message-ID: <1286279798.17473.78.camel@aeonflux>
In-Reply-To: <1286278512-3529-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0470208372721358777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> Modem state notifiers get called after modem state has been changed
> and atoms have been added or flushed.
> =

> The modem state watch benefit the atoms that are active in several
> states, such as voicecall, sms, or gprs.
> ---
>  src/modem.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++------=
-----
>  src/ofono.h |   15 +++++++++++++
>  2 files changed, 67 insertions(+), 12 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index 7a29edf..dc7c1b2 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -51,16 +51,9 @@ enum property_type {
>  	PROPERTY_TYPE_BOOLEAN,
>  };
>  =

> -enum modem_state {
> -	MODEM_STATE_POWER_OFF,
> -	MODEM_STATE_PRE_SIM,
> -	MODEM_STATE_OFFLINE,
> -	MODEM_STATE_ONLINE,
> -};
> -
>  struct ofono_modem {
>  	char			*path;
> -	enum modem_state	modem_state;
> +	enum ofono_modem_state	modem_state;
>  	GSList			*atoms;
>  	struct ofono_watchlist	*atom_watches;
>  	GSList			*interface_list;
> @@ -72,6 +65,7 @@ struct ofono_modem {
>  	ofono_bool_t		powered_pending;
>  	guint			timeout;
>  	ofono_bool_t		online;
> +	struct ofono_watchlist *state_watches;
>  	GHashTable		*properties;
>  	struct ofono_sim	*sim;
>  	unsigned int		sim_watch;
> @@ -94,7 +88,7 @@ struct ofono_devinfo {
>  =

>  struct ofono_atom {
>  	enum ofono_atom_type type;
> -	enum modem_state modem_state;
> +	enum ofono_modem_state modem_state;
>  	void (*destruct)(struct ofono_atom *atom);
>  	void (*unregister)(struct ofono_atom *atom);
>  	void *data;
> @@ -324,7 +318,8 @@ void __ofono_atom_free(struct ofono_atom *atom)
>  	g_free(atom);
>  }
>  =

> -static void flush_atoms(struct ofono_modem *modem, enum modem_state new_=
state)
> +static void flush_atoms(struct ofono_modem *modem,
> +			enum ofono_modem_state new_state)
>  {
>  	GSList *cur;
>  	GSList *prev;
> @@ -360,11 +355,50 @@ static void flush_atoms(struct ofono_modem *modem, =
enum modem_state new_state)
>  	}
>  }
>  =

> +static void notify_state_watches(struct ofono_modem *modem)
> +{
> +	struct ofono_watchlist_item *item;
> +	GSList *l;
> +	ofono_modem_state_notify_func notify;
> +
> +	if (modem->state_watches =3D=3D NULL)
> +		return;
> +
> +	for (l =3D modem->state_watches->items; l; l =3D l->next) {
> +		item =3D l->data;
> +		notify =3D item->notify;
> +		notify(modem->modem_state, item->notify_data);
> +	}
> +}
> +
> +unsigned __ofono_modem_add_state_watch(struct ofono_modem *modem,
> +					ofono_modem_state_notify_func notify,
> +					void *data, ofono_destroy_func destroy)
> +{
> +	struct ofono_watchlist_item *item;
> +
> +	if (modem =3D=3D NULL || notify =3D=3D NULL)
> +		return 0;
> +
> +	item =3D g_new0(struct ofono_watchlist_item, 1);
> +
> +	item->notify =3D notify;
> +	item->destroy =3D destroy;
> +	item->notify_data =3D data;
> +
> +	return __ofono_watchlist_add_item(modem->state_watches, item);
> +}
> +
> +void __ofono_modem_remove_state_watch(struct ofono_modem *modem, unsigne=
d id)
> +{
> +	__ofono_watchlist_remove_item(modem->state_watches, id);
> +}
> +
>  static void modem_change_state(struct ofono_modem *modem,
> -				enum modem_state new_state)
> +				enum ofono_modem_state new_state)
>  {
>  	struct ofono_modem_driver const *driver =3D modem->driver;
> -	enum modem_state old_state =3D modem->modem_state;
> +	enum ofono_modem_state old_state =3D modem->modem_state;
>  	ofono_bool_t new_online =3D new_state =3D=3D MODEM_STATE_ONLINE;
>  =

>  	if (old_state =3D=3D new_state)
> @@ -407,6 +441,8 @@ static void modem_change_state(struct ofono_modem *mo=
dem,
>  			driver->post_online(modem);
>  		break;
>  	}
> +
> +	notify_state_watches(modem);
>  }
>  =

>  static void sim_state_watch(enum ofono_sim_state new_state, void *user)
> @@ -1457,6 +1493,7 @@ int ofono_modem_register(struct ofono_modem *modem)
>  	modem->driver_type =3D NULL;
>  =

>  	modem->atom_watches =3D __ofono_watchlist_new(g_free);
> +	modem->state_watches =3D __ofono_watchlist_new(g_free);
>  =

>  	emit_modem_added(modem);
>  	call_modemwatches(modem, TRUE);
> @@ -1488,6 +1525,9 @@ static void modem_unregister(struct ofono_modem *mo=
dem)
>  	__ofono_watchlist_free(modem->atom_watches);
>  	modem->atom_watches =3D NULL;
>  =

> +	__ofono_watchlist_free(modem->state_watches);
> +	modem->state_watches =3D NULL;
> +
>  	modem->sim_watch =3D 0;
>  	modem->sim_ready_watch =3D 0;
>  =

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

so I am not sure if we wanna have separate modem notifiers or just a
generic one for state. I like to have Denis comment on this one.

However in case we decide to use a state, then just using MODEM_STATE_*
without a proper OFONO_ prefix is not a good idea. It can potentially
clash. Even if this is internal API only, I don't think it is a good
idea to just go without any proper namespacing.

Regards

Marcel



--===============0470208372721358777==--

