Content-Type: multipart/mixed; boundary="===============5423983937672449567=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/3] voicecall: add SSN handling functions
Date: Thu, 03 Mar 2011 14:03:09 -0600
Message-ID: <4D6FF3FD.2000601@gmail.com>
In-Reply-To: <f0199f9e3a809bb5fd3190897b1a252d49d946f2.1299168583.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5423983937672449567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 03/03/2011 10:48 AM, Andras Domokos wrote:
> ---
>  include/types.h     |    2 +
>  include/voicecall.h |    6 ++
>  src/voicecall.c     |  156 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 164 insertions(+), 0 deletions(-)
> =


Please make sure to split this patch into several in accordance to our
patch submission guidelines.  See HACKING document, specifically the
'Submitting Patches' section.

> diff --git a/include/types.h b/include/types.h
> index d25f409..b639c8a 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -96,6 +96,8 @@ struct ofono_call {
>  	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
>  	int clip_validity;
>  	int cnap_validity;
> +	ofono_bool_t remote_held;
> +	ofono_bool_t remote_multiparty;

I really don't like these being here.  Lets put them onto the struct
voicecall object in src/voicecall.c.  The logic for setting remote_held
and remote_multiparty is something that belongs in the core and should
not be exposed to the driver.

>  };
>  =

>  struct ofono_network_time {
> diff --git a/include/voicecall.h b/include/voicecall.h
> index f00eb08..5e6da02 100644
> --- a/include/voicecall.h
> +++ b/include/voicecall.h
> @@ -160,6 +160,12 @@ void ofono_voicecall_set_data(struct ofono_voicecall=
 *vc, void *data);
>  void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
>  int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
>  =

> +void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc, unsigned =
int id,
> +					int code, int index);
> +void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc, unsigned =
int id,
> +					int code, int index,
> +					const struct ofono_phone_number *ph);
> +

Looks good, but as I mentioned this should be a separate patch.

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/src/voicecall.c b/src/voicecall.c
> index ec001c0..e5936f5 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -400,6 +400,12 @@ static void append_voicecall_properties(struct voice=
call *v,
>  =

>  	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
>  =

> +	ofono_dbus_dict_append(dict, "RemoteHeld", DBUS_TYPE_BOOLEAN,
> +				&call->remote_held);
> +
> +	ofono_dbus_dict_append(dict, "RemoteMultiparty", DBUS_TYPE_BOOLEAN,
> +				&call->remote_multiparty);
> +
>  	if (v->message)
>  		ofono_dbus_dict_append(dict, "Information",
>  						DBUS_TYPE_STRING, &v->message);
> @@ -1869,6 +1875,8 @@ static GDBusMethodTable manager_methods[] =3D {
>  };
>  =

>  static GDBusSignalTable manager_signals[] =3D {
> +	{ "Forwarded",	 	 "s" },
> +	{ "BarringActive",	 "s" },
>  	{ "PropertyChanged",	"sv" },
>  	{ "CallAdded",		"oa{sv}" },
>  	{ "CallRemoved",	"o" },
> @@ -2684,3 +2692,151 @@ void __ofono_voicecall_tone_cancel(struct ofono_v=
oicecall *vc, int id)
>  		tone_request_run(vc);
>  	}
>  }
> +
> +static void ssn_mt_forwarded_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code,
> +					const struct ofono_phone_number *ph)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(vc->atom);
> +	char *info =3D "incoming";
> +
> +	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
> +				"Forwarded",
> +				DBUS_TYPE_STRING, &info,
> +				DBUS_TYPE_INVALID);
> +}
> +
> +static struct voicecall *voicecall_select(struct ofono_voicecall *vc,
> +						unsigned int id, int code)
> +{
> +	struct voicecall *v =3D NULL;
> +	GSList *l;
> +
> +	for (l =3D vc->call_list; l; l =3D l->next) {
> +		struct voicecall *v1 =3D l->data;
> +
> +		if (id =3D=3D 0 && g_slist_length(vc->call_list) =3D=3D 1) {
> +			if (code =3D=3D SS_MT_VOICECALL_RETRIEVED &&
> +					v1->call->remote_held =3D=3D TRUE) {
> +				v =3D v1;
> +				break;
> +			} else if (code =3D=3D SS_MT_VOICECALL_ON_HOLD &&
> +					v1->call->remote_held =3D=3D FALSE) {
> +				v =3D v1;
> +				break;
> +			} else if (code =3D=3D SS_MT_MULTIPARTY_VOICECALL &&
> +					v1->call->remote_multiparty =3D=3D FALSE) {
> +				v =3D v1;
> +				break;
> +			}
> +		} else if (v1->call->id =3D=3D id) {
> +			v =3D v1;
> +			break;
> +		}
> +	}
> +
> +	return v;
> +}

I suspect this might be easier to understand if it was re-written to use
g_slist_find_custom instead of jumbling unrelated logic (with a similar
implementation) into a single function.

> +
> +static void ssn_mt_remote_held_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code,
> +					const struct ofono_phone_number *ph)
> +{
> +	struct voicecall *v =3D voicecall_select(vc, id, code);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path;
> +
> +	if (v =3D=3D NULL)
> +		return;
> +
> +	if (code =3D=3D SS_MT_VOICECALL_ON_HOLD)
> +		v->call->remote_held =3D TRUE;
> +	else
> +		v->call->remote_held =3D FALSE;
> +
> +	path =3D voicecall_build_path(vc, v->call);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_VOICECALL_INTERFACE,
> +						"RemoteHeld", DBUS_TYPE_BOOLEAN,
> +						&v->call->remote_held);
> +}
> +
> +static void ssn_mt_remote_multiparty_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code,
> +					const struct ofono_phone_number *ph)
> +{
> +	struct voicecall *v =3D voicecall_select(vc, id, code);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path;
> +
> +	if (v =3D=3D NULL)
> +		return;
> +
> +	v->call->remote_multiparty =3D TRUE;
> +
> +	path =3D voicecall_build_path(vc, v->call);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +					OFONO_VOICECALL_INTERFACE,
> +					"RemoteMultiparty", DBUS_TYPE_BOOLEAN,
> +					&v->call->remote_multiparty);
> +}
> +
> +void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code, int index,
> +					const struct ofono_phone_number *ph)
> +{
> +
> +	if (code =3D=3D SS_MT_CALL_FORWARDED)
> +		ssn_mt_forwarded_notify(vc, id, code, ph);
> +	else if (code =3D=3D SS_MT_VOICECALL_ON_HOLD)
> +		ssn_mt_remote_held_notify(vc, id, code, ph);
> +	else if (code =3D=3D SS_MT_VOICECALL_RETRIEVED)
> +		ssn_mt_remote_held_notify(vc, id, code, ph);
> +	else if (code =3D=3D SS_MT_MULTIPARTY_VOICECALL)
> +		ssn_mt_remote_multiparty_notify(vc, id, code, ph);

Please use a switch/case here

> +}
> +
> +static void ssn_mo_call_barred_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(vc->atom);
> +	const char *info;
> +
> +	if (code =3D=3D SS_MO_INCOMING_BARRING)
> +		info =3D "remote";
> +	else
> +		info =3D "local";
> +
> +	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
> +				"BarringActive",
> +				DBUS_TYPE_STRING, &info,
> +				DBUS_TYPE_INVALID);
> +}
> +
> +static void ssn_mo_forwarded_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(vc->atom);
> +	char *info =3D "outgoing";
> +
> +	g_dbus_emit_signal(conn, path, OFONO_VOICECALL_MANAGER_INTERFACE,
> +				"Forwarded",
> +				DBUS_TYPE_STRING, &info,
> +				DBUS_TYPE_INVALID);
> +}
> +
> +void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc,
> +					unsigned int id, int code, int index)
> +{
> +	if (code =3D=3D SS_MO_OUTGOING_BARRING)
> +		ssn_mo_call_barred_notify(vc, id, code);
> +	else if (code =3D=3D SS_MO_INCOMING_BARRING)
> +		ssn_mo_call_barred_notify(vc, id, code);
> +	else if (code =3D=3D SS_MO_CALL_FORWARDED)
> +		ssn_mo_forwarded_notify(vc, id, code);

Please use a switch/case here.  It is much easier to read and extend.

> +}

Regards,
-Denis

--===============5423983937672449567==--

