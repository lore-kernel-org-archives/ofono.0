Content-Type: multipart/mixed; boundary="===============6531199204757514350=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] src/lte: added proto and authentication handling
Date: Thu, 11 Oct 2018 22:43:18 -0500
Message-ID: <80b6a175-c51e-3179-18e8-7845dec7040e@gmail.com>
In-Reply-To: <20181010065454.15232-3-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6531199204757514350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> @@ -69,19 +78,57 @@ static void lte_load_settings(struct ofono_lte *lte)
>   		return;
>   	}
>   =

> -	apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP ,
> -					DEFAULT_APN_KEY, NULL);
> -	if (apn) {
> +	apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> +				LTE_APN, NULL);
> +	proto_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> +				LTE_PROTO, NULL);
> +	auth_method_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> +				LTE_AUTH_METHOD, NULL);
> +	username =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> +				LTE_USERNAME, NULL);
> +	password =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> +				LTE_PASSWORD, NULL);
> +	if (apn)
>   		strcpy(lte->info.apn, apn);
> -		g_free(apn);

So we may want to be more paranoid here, similar to how load_context in =

gprs.c works.

> -	}
> +
> +	if (proto_str =3D=3D NULL)
> +		proto_str =3D g_strdup("ip");
> +
> +	/* this must have a valid default */
> +	if (!gprs_proto_from_string(proto_str, &lte->info.proto))
> +		lte->info.proto =3D OFONO_GPRS_PROTO_IP;
> +
> +	if (auth_method_str =3D=3D NULL)
> +		auth_method_str =3D g_strdup("none");
> +
> +	/* this must have a valid default */
> +	if (!gprs_auth_method_from_string(auth_method_str,
> +							&lte->info.auth_method))
> +		lte->info.auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> +
> +	if (username)
> +		strcpy(lte->info.username, username);
> +
> +	if (password)
> +		strcpy(lte->info.password, password);
> +

Again, might want to be more paranoid here and ensure username / =

password don't overflow buffers.

> +	g_free(apn);
> +	g_free(proto_str);
> +	g_free(auth_method_str);
> +	g_free(username);
> +	g_free(password);
>   }
>   =


<snip>

>   static void lte_set_default_attach_info_cb(const struct ofono_error *er=
ror,
> -						void *data)
> +								void *data)
>   {
>   	struct ofono_lte *lte =3D data;
>   	const char *path =3D __ofono_atom_get_path(lte->atom);
>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>   	DBusMessage *reply;
> -	const char *apn =3D lte->info.apn;
> +	const char *key;
> +	const char *propstr =3D NULL;
>   =

>   	DBG("%s error %d", path, error->type);
>   =

> @@ -118,55 +173,64 @@ static void lte_set_default_attach_info_cb(const st=
ruct ofono_error *error,
>   		return;
>   	}
>   =

> -	g_strlcpy(lte->info.apn, lte->pending_info.apn,
> -			OFONO_GPRS_MAX_APN_LENGTH + 1);
> +	if (!g_str_equal(lte->pending_info.apn, lte->info.apn)) {
> +		g_strlcpy(lte->info.apn, lte->pending_info.apn,
> +					OFONO_GPRS_MAX_APN_LENGTH + 1);
> +		key =3D LTE_APN;
> +		propstr =3D lte->info.apn;
> +	} else if (lte->pending_info.proto !=3D lte->info.proto) {
> +		lte->info.proto =3D lte->pending_info.proto;
> +		key =3D LTE_PROTO;
> +		propstr =3D gprs_proto_to_string(lte->info.proto);
> +	} else if (lte->pending_info.auth_method !=3D lte->info.auth_method) {
> +		lte->info.auth_method =3D lte->pending_info.auth_method;
> +		key =3D LTE_AUTH_METHOD;
> +		propstr =3D gprs_auth_method_to_string(lte->info.auth_method);
> +
> +	} else if (!g_str_equal(lte->pending_info.username,
> +							lte->info.username)) {
> +		g_strlcpy(lte->info.username, lte->pending_info.username,
> +					OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
> +		key =3D LTE_USERNAME;
> +		propstr =3D lte->info.username;
> +	} else if (!g_str_equal(lte->pending_info.password,
> +							lte->info.password)) {
> +		g_strlcpy(lte->info.password, lte->pending_info.password,
> +					OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
> +		key =3D LTE_PASSWORD;
> +		propstr =3D lte->info.password;
> +	} else {
> +		/*
> +		 * this should never happen, because no property change is
> +		 * checked before.
> +		 * Neverthelss, in this case it will answer the D-Bus message
> +		 * but emit no signal
> +		 */
> +		key =3D NULL;
> +	}

Ugh.  I'm not really liking this at all.  The property name and the new =

value are already available inside the dbus_message object (e.g. =

lte->pending).  There's nothing wrong with parsing that message again or =

simply store pointers to the data inside the dbus-message.

> +
> +	reply =3D dbus_message_new_method_return(lte->pending);
> +	__ofono_dbus_pending_reply(&lte->pending, reply);
> +
> +	if(!key)
> +		return;
>   =

>   	if (lte->settings) {
> -		if (strlen(lte->info.apn) =3D=3D 0)
> -			/* Clear entry on empty APN. */
> -			g_key_file_remove_key(lte->settings, SETTINGS_GROUP,
> -						DEFAULT_APN_KEY, NULL);
> +		if (!*propstr)
> +			/* Clear entry on empty string. */
> +			g_key_file_remove_key(lte->settings,
> +				SETTINGS_GROUP, key, NULL);
>   		else
> -			g_key_file_set_string(lte->settings, SETTINGS_GROUP,
> -						DEFAULT_APN_KEY, lte->info.apn);
> +			g_key_file_set_string(lte->settings,
> +				SETTINGS_GROUP, key, propstr);
>   =

>   		storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
>   	}

I can see this applying for APN and maybe Username/Password.  But not =

the other settings...?

>   =

> -	reply =3D dbus_message_new_method_return(lte->pending);
> -	__ofono_dbus_pending_reply(&lte->pending, reply);
> -
>   	ofono_dbus_signal_property_changed(conn, path,
>   					OFONO_CONNECTION_CONTEXT_INTERFACE,
> -					DEFAULT_APN_KEY,
> -					DBUS_TYPE_STRING, &apn);
> -}
> -
> -static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
> -				DBusConnection *conn, DBusMessage *msg,
> -				const char *apn)
> -{
> -	if (lte->driver->set_default_attach_info =3D=3D NULL)
> -		return __ofono_error_not_implemented(msg);
> -
> -	if (lte->pending)
> -		return __ofono_error_busy(msg);
> -
> -	if (g_str_equal(apn, lte->info.apn))
> -		return dbus_message_new_method_return(msg);
> -
> -	/* We do care about empty value: it can be used for reset. */
> -	if (is_valid_apn(apn) =3D=3D FALSE && apn[0] !=3D '\0')
> -		return __ofono_error_invalid_format(msg);
> -
> -	lte->pending =3D dbus_message_ref(msg);
> -
> -	g_strlcpy(lte->pending_info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH + 1);
> -
> -	lte->driver->set_default_attach_info(lte, &lte->pending_info,
> -					lte_set_default_attach_info_cb, lte);
> -
> -	return NULL;
> +					key,
> +					DBUS_TYPE_STRING, &propstr);
>   }
>   =

>   static DBusMessage *lte_set_property(DBusConnection *conn,
> @@ -177,6 +241,14 @@ static DBusMessage *lte_set_property(DBusConnection =
*conn,
>   	DBusMessageIter var;
>   	const char *property;
>   	const char *str;
> +	enum ofono_gprs_auth_method auth_method;
> +	enum ofono_gprs_proto proto;
> +
> +	if (lte->driver->set_default_attach_info =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (lte->pending)
> +		return __ofono_error_busy(msg);
>   =

>   	if (!dbus_message_iter_init(msg, &iter))
>   		return __ofono_error_invalid_args(msg);
> @@ -192,16 +264,64 @@ static DBusMessage *lte_set_property(DBusConnection=
 *conn,
>   =

>   	dbus_message_iter_recurse(&iter, &var);
>   =

> -	if (!strcmp(property, DEFAULT_APN_KEY)) {
> -		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> -			return __ofono_error_invalid_args(msg);
> +	if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(&var, &str);
>   =

> -		dbus_message_iter_get_basic(&var, &str);
> +	if ((strcmp(property, LTE_APN) =3D=3D 0)) {
>   =

> -		return lte_set_default_apn(lte, conn, msg, str);
> -	}
> +		if (g_str_equal(str, lte->info.apn))
> +			return dbus_message_new_method_return(msg);
> +
> +		/* We do care about empty value: it can be used for reset. */
> +		if (is_valid_apn(str) =3D=3D FALSE && str[0] !=3D '\0')
> +			return __ofono_error_invalid_format(msg);
> +
> +		g_strlcpy(lte->pending_info.apn, str,
> +					OFONO_GPRS_MAX_APN_LENGTH + 1);
> +
> +	} else if ((strcmp(property, LTE_PROTO) =3D=3D 0)) {
> +
> +		if (!gprs_proto_from_string(str, &proto))
> +			return __ofono_error_invalid_format(msg);
> +
> +		if (proto =3D=3D lte->info.proto)
> +			return dbus_message_new_method_return(msg);
> +
> +		lte->pending_info.proto =3D proto;
> +
> +	} else if (strcmp(property, LTE_AUTH_METHOD) =3D=3D 0) {
> +
> +		if (!gprs_auth_method_from_string(str, &auth_method))
> +			return __ofono_error_invalid_format(msg);
> +
> +		if (proto =3D=3D lte->info.proto)
> +			return dbus_message_new_method_return(msg);

Umm, method?  How well tested is this submission?

>   =

> -	return __ofono_error_invalid_args(msg);
> +	} else if (strcmp(property, LTE_USERNAME) =3D=3D 0) {
> +
> +		if (g_str_equal(str, lte->info.username))
> +			return dbus_message_new_method_return(msg);
> +
> +		g_strlcpy(lte->pending_info.username, str,
> +					OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
> +
> +	} else if (strcmp(property, LTE_PASSWORD) =3D=3D 0) {
> +
> +		if (g_str_equal(str, lte->info.password))
> +			return dbus_message_new_method_return(msg);
> +
> +		g_strlcpy(lte->pending_info.password, str,
> +					OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
> +
> +	} else
> +		return __ofono_error_invalid_args(msg);
> +
> +	lte->pending =3D dbus_message_ref(msg);
> +	lte->driver->set_default_attach_info(lte, &lte->pending_info,
> +					lte_set_default_attach_info_cb, lte);
> +	return dbus_message_ref(msg);;

Your reference counting is completely wrong here.  You might want to run =

valgrind and do some testing...

>   }
>   =

>   static const GDBusMethodTable lte_methods[] =3D {
> @@ -374,6 +494,16 @@ void *ofono_lte_get_data(const struct ofono_lte *lte)
>   	return lte->driver_data;
>   }
>   =

> +void ofono_lte_set_reg_info(struct ofono_modem *modem)
> +{
> +	struct ofono_lte *lte =3D __ofono_atom_find(OFONO_ATOM_TYPE_LTE, modem);
> +
> +	if(!lte || !lte->driver || !lte->driver->set_reg_info)
> +		return;
> +
> +	lte->driver->set_reg_info(lte, &lte->info);
> +}
> +

Given that you have somewhat sane defaults for everything, I'm not =

convinced now that this is even needed...

Regards,
-Denis

--===============6531199204757514350==--

