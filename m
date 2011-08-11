Content-Type: multipart/mixed; boundary="===============1300947559395958536=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] add anwser/send flash/send tones support for cdma voice
 call
Date: Wed, 10 Aug 2011 22:35:05 -0500
Message-ID: <4E434DE9.1080806@gmail.com>
In-Reply-To: <1311564249-11492-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1300947559395958536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

Please use git-send-email to send your patches, and break them up
accordingly.  See 'Submitting patches' section in HACKING for a brief
introduction.

On 07/24/2011 10:24 PM, Caiwen Zhang wrote:
> diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
> index 9e741da..520934b 100644
> --- a/include/cdma-voicecall.h
> +++ b/include/cdma-voicecall.h
> @@ -55,8 +55,20 @@ struct ofono_cdma_voicecall_driver {
>  	/* Hangs up active, dialing, alerting or incoming calls */
>  	void (*hangup)(struct ofono_cdma_voicecall *vc,
>  			ofono_cdma_voicecall_cb_t cb, void *data);
> +
> +	void (*answer)(struct ofono_cdma_voicecall *vc,
> +			ofono_cdma_voicecall_cb_t cb, void *data);
> +
> +	void (*send_flash)(struct ofono_cdma_voicecall *vc, const char *string,
> +			ofono_cdma_voicecall_cb_t cb, void *data);
> +
> +	void (*send_tones)(struct ofono_cdma_voicecall *vc, const char *tones,
> +			ofono_cdma_voicecall_cb_t cb, void *data);
>  };
>  =

> +void ofono_cdma_voicecall_notify(struct ofono_cdma_voicecall *vc,
> +	int direction, enum cdma_call_status status, const char *number);
> +
>  void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
>  					enum ofono_disconnect_reason reason,
>  					const struct ofono_error *error);

This looks fine, but please break this up logically.  e.g.

- patch that introduces send_flash API in cdma-voicecall.h
- patch that implements it in the core
- patch that introduces send_tones API
- patch that implements it in the core
- patch that introduces notify / answer
- patch that implements them in the core

> diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
> index 183433d..20ab831 100644
> --- a/src/cdma-voicecall.c
> +++ b/src/cdma-voicecall.c
> @@ -40,6 +40,7 @@ static GSList *g_drivers;
>  =

>  struct ofono_cdma_voicecall {
>  	struct ofono_cdma_phone_number phone_number;
> +	struct ofono_cdma_phone_number waiting_number;
>  	int direction;
>  	enum cdma_call_status status;
>  	time_t start_time;
> @@ -108,14 +109,33 @@ static void append_voicecall_properties(struct ofon=
o_cdma_voicecall *vc,
>  {
>  	const char *status;
>  	const char *lineid;
> +	const char *waiting_call =3D NULL;
> +	ofono_bool_t call_waiting;
>  =

>  	status =3D cdma_call_status_to_string(vc->status);
> -	lineid =3D cdma_phone_number_to_string(&vc->phone_number);
>  =

>  	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
>  =

> -	ofono_dbus_dict_append(dict, "LineIdentification",
> -				DBUS_TYPE_STRING, &lineid);
> +	if (vc->status !=3D CDMA_CALL_STATUS_DISCONNECTED) {
> +		if (vc->phone_number.number[0] !=3D '\0') {
> +			lineid =3D cdma_phone_number_to_string(&vc->phone_number);
> +			ofono_dbus_dict_append(dict, "LineIdentification",
> +						DBUS_TYPE_STRING, &lineid);
> +		}
> +
> +		if (vc->waiting_number.number[0] !=3D '\0') {
> +			waiting_call =3D cdma_phone_number_to_string(
> +						&vc->waiting_number);
> +
> +			ofono_dbus_dict_append(dict, "CallWaitingNumber",
> +					DBUS_TYPE_STRING, &waiting_call);
> +		}
> +	}
> +
> +	call_waiting =3D (waiting_call !=3D NULL);
> +
> +	ofono_dbus_dict_append(dict, "CallWaiting",
> +					DBUS_TYPE_BOOLEAN, &call_waiting);
>  =


Why do you put the CallWaitingNumber handling in the if above, but not
the CallWaiting property?

>  	if (vc->status =3D=3D CDMA_CALL_STATUS_ACTIVE) {
>  		const char *timestr =3D time_to_str(&vc->start_time);
> @@ -172,6 +192,7 @@ static void voicecall_set_call_status(struct ofono_cd=
ma_voicecall *vc,
>  	const char *status_str;
>  	enum cdma_call_status old_status;
>  =

> +	DBG("status: %s", cdma_call_status_to_string(status));
>  	if (vc->status =3D=3D status)
>  		return;
>  =

> @@ -198,6 +219,14 @@ static void voicecall_set_call_status(struct ofono_c=
dma_voicecall *vc,
>  					"StartTime", DBUS_TYPE_STRING,
>  					&timestr);
>  	}
> +
> +	if (status =3D=3D CDMA_CALL_STATUS_DISCONNECTED) {
> +		memset(&vc->phone_number, 0,
> +				sizeof(struct ofono_cdma_phone_number));
> +
> +		memset(&vc->waiting_number, 0,
> +			sizeof(struct ofono_cdma_phone_number));
> +	}

What happens to the waiting call?

>  }
>  =

>  static void voicecall_set_call_lineid(struct ofono_cdma_voicecall *vc)
> @@ -215,6 +244,32 @@ static void voicecall_set_call_lineid(struct ofono_c=
dma_voicecall *vc)
>  					DBUS_TYPE_STRING, &lineid_str);
>  }
>  =

> +static void voicecall_set_call_waiting_number(struct ofono_cdma_voicecal=
l *vc,
> +				const struct ofono_cdma_phone_number *ph)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path  =3D __ofono_atom_get_path(vc->atom);
> +	const char *waiting_number;
> +	ofono_bool_t call_waiting =3D TRUE;
> +
> +	if (ph->number[0] =3D=3D '\0')
> +		return;
> +
> +	memcpy(&vc->waiting_number, ph, sizeof(struct ofono_cdma_phone_number));
> +
> +	waiting_number =3D cdma_phone_number_to_string(ph);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
> +					"CallWaitingNumber", DBUS_TYPE_STRING,
> +					&waiting_number);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
> +					"CallWaiting", DBUS_TYPE_BOOLEAN,
> +					&call_waiting);
> +}
> +
>  static void manager_dial_callback(const struct ofono_error *error, void =
*data)
>  {
>  	struct ofono_cdma_voicecall *vc =3D data;
> @@ -229,7 +284,9 @@ static void manager_dial_callback(const struct ofono_=
error *error, void *data)
>  =

>  	voicecall_set_call_lineid(vc);
>  	vc->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
> -	voicecall_set_call_status(vc, CDMA_CALL_STATUS_DIALING);
> +
> +	if (vc->status !=3D CDMA_CALL_STATUS_ACTIVE)
> +		voicecall_set_call_status(vc, CDMA_CALL_STATUS_DIALING);
>  =

>  	reply =3D dbus_message_new_method_return(vc->pending);
>  	__ofono_dbus_pending_reply(&vc->pending, reply);
> @@ -286,6 +343,105 @@ static DBusMessage *voicecall_manager_hangup(DBusCo=
nnection *conn,
>  	return NULL;
>  }
>  =

> +static DBusMessage *voicecall_manager_answer(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_cdma_voicecall *vc =3D data;
> +
> +	if (vc->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (vc->driver->answer =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (vc->status !=3D CDMA_CALL_STATUS_INCOMING)
> +		return __ofono_error_failed(msg);
> +
> +	vc->pending =3D dbus_message_ref(msg);
> +
> +	vc->driver->answer(vc, generic_callback, vc);
> +
> +	return NULL;
> +}
> +
> +static DBusMessage *voicecall_manager_flash(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_cdma_voicecall *vc =3D data;
> +	const char *string;
> +
> +	if (vc->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (vc->driver->send_flash =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &string,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (vc->status =3D=3D CDMA_CALL_STATUS_DISCONNECTED)
> +		return __ofono_error_failed(msg);
> +
> +	vc->pending =3D dbus_message_ref(msg);
> +
> +	vc->driver->send_flash(vc, string, generic_callback, vc);
> +
> +	return NULL;
> +}
> +
> +static ofono_bool_t is_valid_tones(const char *tones)
> +{
> +	int len;
> +	int i;
> +
> +	if (tones =3D=3D NULL)
> +		return FALSE;
> +
> +	len =3D strlen(tones);
> +	if (len =3D=3D 0)
> +		return FALSE;
> +
> +	for (i =3D 0; i < len; i++) {
> +		if (g_ascii_isdigit(tones[i]) || tones[i] =3D=3D '*' ||
> +				tones[i] =3D=3D '#')
> +			continue;
> +		else
> +			return FALSE;
> +	}
> +
> +	return TRUE;
> +}
> +
> +static DBusMessage *voicecall_manager_tone(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_cdma_voicecall *vc =3D data;
> +	const char *tones;
> +
> +	if (vc->pending)
> +		return __ofono_error_busy(msg);
> +
> +	if (vc->driver->send_tones =3D=3D NULL)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (vc->status !=3D CDMA_CALL_STATUS_ACTIVE)
> +		return __ofono_error_failed(msg);
> +
> +	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &tones,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (is_valid_tones(tones) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	vc->pending =3D dbus_message_ref(msg);
> +
> +	vc->driver->send_tones(vc,  tones, generic_callback, vc);
> +
> +	return NULL;
> +}
> +
>  static GDBusMethodTable manager_methods[] =3D {
>  	{ "GetProperties",    "",    "a{sv}",
>  					voicecall_manager_get_properties },
> @@ -293,6 +449,12 @@ static GDBusMethodTable manager_methods[] =3D {
>  						G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "Hangup",           "",    "",         voicecall_manager_hangup,
>  						G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "Answer",           "",    "",         voicecall_manager_answer,
> +						G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "SendFlash",      "s",    "",         voicecall_manager_flash,
> +						G_DBUS_METHOD_FLAG_ASYNC },
> +	{ "SendTones",     "s",    "",        voicecall_manager_tone,
> +						G_DBUS_METHOD_FLAG_ASYNC },
>  	{ }
>  };
>  =

> @@ -302,6 +464,31 @@ static GDBusSignalTable manager_signals[] =3D {
>  	{ }
>  };
>  =

> +void ofono_cdma_voicecall_notify(struct ofono_cdma_voicecall *vc,
> +			int direction, enum cdma_call_status status,
> +			const char *number)
> +{
> +	struct ofono_cdma_phone_number ph;
> +
> +	DBG("direction: %d; status: %d; num: %s", direction, status, number);
> +
> +	string_to_cdma_phone_number(number, &ph);
> +
> +	if (status =3D=3D CDMA_CALL_STATUS_INCOMING
> +			&& vc->status =3D=3D CDMA_CALL_STATUS_ACTIVE) {
> +		voicecall_set_call_waiting_number(vc, &ph);

Would it be a good idea to formalize the waiting state?

> +	} else {
> +		memcpy(&vc->phone_number, &ph,
> +				sizeof(struct ofono_cdma_phone_number));
> +
> +		voicecall_set_call_lineid(vc);
> +	}
> +
> +	vc->direction =3D direction;
> +
> +	voicecall_set_call_status(vc, status);
> +}
> +
>  void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
>  					enum ofono_disconnect_reason reason,
>  					const struct ofono_error *error)

I'd also like to see some cdma-voicecall drivers in order to visualize
what is going on better.

Regards,
-Denis

--===============1300947559395958536==--

