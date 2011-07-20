Content-Type: multipart/mixed; boundary="===============0481721332328761825=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] cdma-connman: add possibility to set a username and a
 password
Date: Wed, 20 Jul 2011 11:48:27 +0200
Message-ID: <1311155307.21109.190.camel@aeonflux>
In-Reply-To: <1311154000-32353-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0481721332328761825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  src/cdma-connman.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 43 insertions(+), 1 deletions(-)
> =

> diff --git a/src/cdma-connman.c b/src/cdma-connman.c
> index 3321b87..7ca5a0a 100644
> --- a/src/cdma-connman.c
> +++ b/src/cdma-connman.c
> @@ -57,6 +57,8 @@ struct ofono_cdma_connman {
>  	const struct ofono_cdma_connman_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	char *username;
> +	char *password;
>  };

I am still not convinced that this is needed. Please provide logs where
it shows that it fails otherwise.
 =

>  static void cdma_connman_settings_free(struct cdma_connman_settings *set=
tings)
> @@ -379,6 +381,8 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
>  	DBusMessageIter var;
>  	const char *property;
>  	dbus_bool_t value;
> +	const char *username;
> +	const char *password;
>  =

>  	DBG("");
>  =

> @@ -399,7 +403,7 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
>  =

>  	dbus_message_iter_recurse(&iter, &var);
>  =

> -	if (!strcmp(property, "Powered")) {
> +	if (!g_strcmp0(property, "Powered")) {

Don't bother here. strcmp is just fine since we know both arguments are
not NULL.

Also if you wanna change this, then please have a separate patch for it.
Intermixing of code with style changes is not a good idea. And we have
always fixed style issues separately.

>  		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
>  			return __ofono_error_invalid_args(msg);
>  =

> @@ -421,6 +425,22 @@ static DBusMessage *cdma_connman_set_property(DBusCo=
nnection *conn,
>  			cm->driver->deactivate(cm, deactivate_callback, cm);
>  =

>  		return dbus_message_new_method_return(msg);
> +	} else if (!g_strcmp0(property, "Username")) {
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &username);
> +		cm->username =3D g_strdup(username);
> +		DBG("username: %s", username);
> +		return dbus_message_new_method_return(msg);
> +	} else if (!g_strcmp0(property, "Password")) {
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &password);
> +		cm->password =3D g_strdup(password);
> +		DBG("password: %s", password);
> +		return dbus_message_new_method_return(msg);
>  	}
>  =

>  	/* TODO: Dormant property. Not yet supported. */
> @@ -488,6 +508,12 @@ static void cdma_connman_remove(struct ofono_atom *a=
tom)
>  	if (cm->driver && cm->driver->remove)
>  		cm->driver->remove(cm);
>  =

> +	if (cm->username)
> +		g_free(cm->username);
> +
> +	if (cm->password)
> +		g_free(cm->password);
> +

The if check are pointless. g_free (and also free for that matter) does
a NULL check on its parameter.

> @@ -568,3 +594,19 @@ void *ofono_cdma_connman_get_data(struct ofono_cdma_=
connman *cm)
>  {
>  	return cm->driver_data;
>  }
> +
> +const char *ofono_cdma_connman_get_username(struct ofono_cdma_connman *c=
m)
> +{
> +	if (cm->username)
> +		return cm->username;
> +
> +	return NULL;
> +}
> +
> +const char *ofono_cdma_connman_get_password(struct ofono_cdma_connman *c=
m)
> +{
> +	if (cm->password)
> +		return cm->password;
> +
> +	return NULL;
> +}

What is wrong with just "return cm->password;". This example is a bit
convoluted right now ;)

The next question is where you want the NULL handling. Or do you want it
all. Please think about that a little bit and maybe have a look at what
GPRS is doing.

Regards

Marcel



--===============0481721332328761825==--

