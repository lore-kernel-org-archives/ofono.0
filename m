Content-Type: multipart/mixed; boundary="===============9099366038564408092=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 2/2] bluetooth: Add Bluetooth service authorization support
Date: Fri, 04 Feb 2011 16:08:59 -0200
Message-ID: <20110204180859.GA2370@joana>
In-Reply-To: <1296830644-15768-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9099366038564408092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-02-04 1=
5:44:04 +0100]:

> ---
>  plugins/bluetooth.c |  125 +++++++++++++++++++++++++++++++++++++++++++++=
+----
>  1 files changed, 115 insertions(+), 10 deletions(-)
> =

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index b489dad..8d28b07 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -44,6 +44,8 @@ static GHashTable *adapter_address_hash =3D NULL;
>  static gint bluetooth_refcount;
>  static GSList *server_list =3D NULL;
>  =

> +#define TIMEOUT (60) /* Timeout for user response (seconds) */
> +
>  struct server {
>  	guint8 channel;
>  	char *sdp_record;
> @@ -58,6 +60,8 @@ struct cb_data {
>  	struct server *server;
>  	char *path;
>  	guint source;
> +	GIOChannel *io;
> +	gboolean pending_auth;
>  };
>  =

>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
> @@ -483,26 +487,104 @@ static void cb_data_destroy(gpointer data)
>  	g_free(cb_data);
>  }
>  =

> +static void cancel_authorization(struct cb_data *user_data)
> +{
> +	DBusMessage *msg;
> +
> +	if (user_data->path =3D=3D NULL)
> +		return;
> +
> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, user_data->path,
> +						BLUEZ_SERVICE_INTERFACE,
> +						"CancelAuthorization");
> +
> +	if (msg =3D=3D NULL) {
> +		ofono_error("Unable to allocate D-Bus CancelAuthorization"
> +				" message");
> +		return;
> +	}
> +
> +	g_dbus_send_message(connection, msg);
> +}
> +
>  static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpoint=
er data)
>  {
>  	struct cb_data *cb_data =3D data;
>  	struct server *server =3D cb_data->server;
>  =

> -	server->client_list =3D g_slist_remove(server->client_list,
> +	if (cb_data->pending_auth =3D=3D TRUE) {
> +		cancel_authorization(cb_data);
> +
> +		cb_data->pending_auth =3D FALSE;
> +	} else {
> +		server->client_list =3D g_slist_remove(server->client_list,
>  					GUINT_TO_POINTER(cb_data->source));
>  =

> -	cb_data_destroy(cb_data);
> +		cb_data_destroy(cb_data);
> +	}

Don't you have to call g_slist_remove and cb_data_destroy for both cases? w=
hen
pending_auth is TRUE or FALSE.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============9099366038564408092==--

