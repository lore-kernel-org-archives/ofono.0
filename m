Content-Type: multipart/mixed; boundary="===============0315866766933222333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: Add EmergencyCall property.
Date: Thu, 11 Nov 2010 09:26:37 -0600
Message-ID: <4CDC0B2D.6010407@gmail.com>
In-Reply-To: <1289488333-1481-1-git-send-email-john.mathew@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0315866766933222333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

> +static gboolean voicecall_isemergency(struct voicecall *v)

Please use voicecall_is_emergency

> +{
> +	struct ofono_call *call =3D v->call;
> +	const char *lineid_str;
> +
> +	lineid_str =3D phone_number_to_string(&call->phone_number);
> +
> +	if (g_slist_find_custom(v->vc->en_list, lineid_str,
> +						(GCompareFunc) strcmp))

As a general rule, the only function casting we allow is for GFunc use
of g_free.  I really prefer that you write a separate function here.

> +		return TRUE;
> +	else

Please drop the else, it isn't actually required and makes the code
slightly cleaner.

> +		return FALSE;
> +}
> +
>  static void append_voicecall_properties(struct voicecall *v,
>  					DBusMessageIter *dict)
>  {
> @@ -322,7 +336,8 @@ static void append_voicecall_properties(struct voicec=
all *v,
>  	const char *status;
>  	const char *callerid;
>  	const char *timestr;
> -	ofono_bool_t mpty;
> +	ofono_bool_t mpt;

Is there a reason you're changing this variable name?

> +	dbus_bool_t emergency_call;
>  =

>  	status =3D call_status_to_string(call->status);
>  	callerid =3D phone_number_to_string(&call->phone_number);
> @@ -358,6 +373,14 @@ static void append_voicecall_properties(struct voice=
call *v,
>  	if (v->icon_id)
>  		ofono_dbus_dict_append(dict, "Icon", DBUS_TYPE_BYTE,
>  					&v->icon_id);
> +
> +	if (voicecall_isemergency(v))
> +			emergency_call =3D TRUE;
> +	else
> +			emergency_call =3D FALSE;
> +
> +	ofono_dbus_dict_append(dict, "EmergencyCall", DBUS_TYPE_BOOLEAN,
> +					&emergency_call);
>  }
>  =

>  static DBusMessage *voicecall_get_properties(DBusConnection *conn,
> @@ -722,6 +745,15 @@ static void voicecall_set_call_lineid(struct voiceca=
ll *v,
>  						OFONO_VOICECALL_INTERFACE,
>  						"LineIdentification",
>  						DBUS_TYPE_STRING, &lineid_str);
> +
> +	if (voicecall_isemergency(v)) {
> +		dbus_bool_t emergency_call =3D TRUE;

In general we prefer an empty line after every variable declaration block.

> +		ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_VOICECALL_INTERFACE,
> +						"EmergencyCall",
> +						DBUS_TYPE_BOOLEAN,
> +						&emergency_call);
> +	}
>  }
>  =

>  static gboolean voicecall_dbus_register(struct voicecall *v)

Regards,
-Denis

--===============0315866766933222333==--

