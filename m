Content-Type: multipart/mixed; boundary="===============7973761125045854937=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 04/15] handsfree: Implement voice recognition function
Date: Thu, 20 Oct 2011 20:32:13 -0500
Message-ID: <4EA0CB9D.7030406@gmail.com>
In-Reply-To: <1319128700-15841-5-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7973761125045854937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/20/2011 11:38 AM, Mikel Astiz wrote:
> ---
>  src/handsfree.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 72 insertions(+), 0 deletions(-)
> =

> diff --git a/src/handsfree.c b/src/handsfree.c
> index efebcc0..7f3882f 100644
> --- a/src/handsfree.c
> +++ b/src/handsfree.c
> @@ -45,6 +45,9 @@ static GSList *g_drivers =3D NULL;
>  =

>  struct ofono_handsfree {
>  	ofono_bool_t inband_ringing;
> +	ofono_bool_t voicerec_state;
> +	ofono_bool_t pending_voicerec_state;

Please name these voice_recognition and voice_recognition_pending.

> +
>  	const struct ofono_handsfree_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> @@ -72,6 +75,24 @@ void ofono_handsfree_set_inband_ringing(struct ofono_h=
andsfree *hf,
>  					&dbus_enabled);
>  }
>  =

> +void ofono_handsfree_set_voice_recognition(struct ofono_handsfree *hf,
> +						ofono_bool_t enabled)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(hf->atom);
> +	dbus_bool_t dbus_enabled =3D enabled;
> +
> +	if (hf->voicerec_state =3D=3D enabled)
> +		return;
> +
> +	hf->voicerec_state =3D enabled;
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_HANDSFREE_INTERFACE,
> +					"VoiceRecognition", DBUS_TYPE_BOOLEAN,
> +					&dbus_enabled);
> +}
> +
>  static DBusMessage *handsfree_get_properties(DBusConnection *conn,
>  						DBusMessage *msg, void *data)
>  {
> @@ -80,6 +101,7 @@ static DBusMessage *handsfree_get_properties(DBusConne=
ction *conn,
>  	DBusMessageIter iter;
>  	DBusMessageIter dict;
>  	dbus_bool_t inband_ringing;
> +	dbus_bool_t voicerec_state;
>  =

>  	reply =3D dbus_message_new_method_return(msg);
>  	if (reply =3D=3D NULL)
> @@ -95,17 +117,49 @@ static DBusMessage *handsfree_get_properties(DBusCon=
nection *conn,
>  	ofono_dbus_dict_append(&dict, "InbandRinging", DBUS_TYPE_BOOLEAN,
>  				&inband_ringing);
>  =

> +	voicerec_state =3D hf->voicerec_state;
> +	ofono_dbus_dict_append(&dict, "VoiceRecognition", DBUS_TYPE_BOOLEAN,
> +				&voicerec_state);
> +
>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;
>  }
>  =

> +static void voicerec_set_cb(const struct ofono_error *error, void *data)
> +{
> +	struct ofono_handsfree *hf =3D data;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(hf->atom);
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		__ofono_dbus_pending_reply(&hf->pending,
> +					__ofono_error_failed(hf->pending));
> +		return;
> +	}
> +
> +	hf->voicerec_state =3D hf->pending_voicerec_state;
> +
> +	__ofono_dbus_pending_reply(&hf->pending,
> +				dbus_message_new_method_return(hf->pending));
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_HANDSFREE_INTERFACE,
> +					"VoiceRecognition",
> +					DBUS_TYPE_BOOLEAN,
> +					&hf->voicerec_state);
> +}
> +
>  static DBusMessage *handsfree_set_property(DBusConnection *conn,
>  						DBusMessage *msg, void *data)
>  {
> +	struct ofono_handsfree *hf =3D data;
>  	DBusMessageIter iter, var;
>  	const char *name;
>  =

> +	if (hf->pending)
> +		return __ofono_error_busy(msg);
> +
>  	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
>  		return __ofono_error_invalid_args(msg);
>  =

> @@ -120,6 +174,24 @@ static DBusMessage *handsfree_set_property(DBusConne=
ction *conn,
>  =

>  	dbus_message_iter_recurse(&iter, &var);
>  =

> +	if (g_str_equal(name, "VoiceRecognition") =3D=3D TRUE) {
> +		ofono_bool_t enabled;
> +
> +		if (!hf->driver->voice_recognition)
> +			return __ofono_error_not_implemented(msg);
> +
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &enabled);
> +
> +		hf->pending_voicerec_state =3D enabled;
> +		hf->pending =3D dbus_message_ref(msg);
> +		hf->driver->voice_recognition(hf, enabled, voicerec_set_cb, hf);
> +

You might want to think about whether we need to be a bit smarter here.
 For example, AG indicated BVRA is active, and us trying to set (and
potentially signal PropertyChanged) again might be bad.

Same goes for setting the property to the already set value.

> +		return NULL;
> +	}
> +
>  	return __ofono_error_invalid_args(msg);
>  }
>  =


Regards,
-Denis

--===============7973761125045854937==--

