Content-Type: multipart/mixed; boundary="===============7698936107606043105=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] huawei: add RejectInfo signal to
 org.ofono.ConnectionManager
Date: Thu, 25 Jun 2020 11:52:48 -0500
Message-ID: <ba857619-6958-9bd1-b746-0807c377952c@gmail.com>
In-Reply-To: <20200625092825.4475-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7698936107606043105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jimmy,

On 6/25/20 4:28 AM, Jimmy Gysens wrote:
> Huawei devices can have support for ^REJINFO unsolicited event. This event
> provides useful info, regarding to the network attached state, for higher
> level applications.
> =

> This commit adds an additional property RejectInfo to the PropertyChanged
> signal for org.ofono.ConnectionManager.

So as a rule of thumb, if you're changing the D-Bus API, send the patch =

documenting the proposed change against doc/ first, before any commits =

implementing this change.

Also note that we do not export vendor specific signals over org.ofono.* =

interfaces.  If you want to do something vendor specific, implement it in t=
he =

modem driver and use org.ofono.<vendor>.* interface prefix.  See =

plugins/xmm7xxx.c for an example.

> ---
>   include/gprs.h |   3 ++
>   src/gprs.c     | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
> =

> diff --git a/include/gprs.h b/include/gprs.h
> index 20bdb7a4..92c0d260 100644
> --- a/include/gprs.h
> +++ b/include/gprs.h
> @@ -62,6 +62,9 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gprs=
);
>   void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
>   void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
>   void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer);
> +void ofono_gprs_rejectinfo_notify(struct ofono_gprs *gprs, int plmn,
> +					int service_domain, int rat_type,
> +					int reject_cause, int reject_type);
>   =

>   struct ofono_modem *ofono_gprs_get_modem(struct ofono_gprs *gprs);
>   =

> diff --git a/src/gprs.c b/src/gprs.c
> index daf2611b..d9e24840 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -136,6 +136,14 @@ struct pri_context {
>   	struct ofono_gprs *gprs;
>   };
>   =

> +struct rejectinfo {
> +	int plmn;
> +	int service_domain;
> +	int rat_type;
> +	int reject_cause;
> +	int reject_type;
> +};
> +
>   static void gprs_attached_update(struct ofono_gprs *gprs);
>   static void gprs_netreg_update(struct ofono_gprs *gprs);
>   static void gprs_deactivate_next(struct ofono_gprs *gprs);
> @@ -2734,6 +2742,124 @@ void ofono_gprs_bearer_notify(struct ofono_gprs *=
gprs, int bearer)
>   					"Bearer", DBUS_TYPE_STRING, &value);
>   }
>   =

> +static void append_rejectinfo_properties(const struct rejectinfo *ri,
> +					DBusMessageIter *iter)
> +{
> +	DBusMessageIter variant;
> +	DBusMessageIter array;
> +	char typesig[5];
> +	char arraysig[6];
> +	const char *rat;
> +	const char *service;
> +	const char *reason;
> +
> +	switch (ri->rat_type) {
> +	//GERAN
> +	case 0:
> +		rat =3D "gprs";
> +		break;
> +	//UTRAN
> +	case 1:
> +		rat =3D "umts";
> +		break;
> +	//E-UTRAN
> +	case 2:
> +		rat =3D "lte";
> +		break;
> +	default:
> +		rat =3D "unknown";
> +	}
> +
> +	switch (ri->service_domain) {
> +	case 0:
> +		service =3D "cs";
> +		break;
> +	case 1:
> +		service =3D "ps";
> +		break;
> +	case 2:
> +		service =3D "cs_ps";
> +		break;
> +	default:
> +		service =3D "unknown";
> +	}
> +
> +	switch (ri->reject_type) {
> +	case 0:
> +		reason =3D "register reject";
> +		break;
> +	case 1:
> +		reason =3D "authentication failure";
> +		break;
> +	case 2:
> +		reason =3D "service request reject";
> +		break;
> +	case 3:
> +		reason =3D "detach request from the network";
> +		break;
> +	default:
> +		reason =3D "unknown";
> +	}
> +
> +	arraysig[0] =3D DBUS_TYPE_ARRAY;
> +	arraysig[1] =3D typesig[0] =3D DBUS_DICT_ENTRY_BEGIN_CHAR;
> +	arraysig[2] =3D typesig[1] =3D DBUS_TYPE_STRING;
> +	arraysig[3] =3D typesig[2] =3D DBUS_TYPE_VARIANT;
> +	arraysig[4] =3D typesig[3] =3D DBUS_DICT_ENTRY_END_CHAR;
> +	arraysig[5] =3D typesig[4] =3D '\0';
> +
> +	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
> +						arraysig, &variant);
> +
> +	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
> +						typesig, &array);
> +
> +	ofono_dbus_dict_append(&array, "PLMN", DBUS_TYPE_INT32, &ri->plmn);
> +	ofono_dbus_dict_append(&array, "Service", DBUS_TYPE_STRING, &service);
> +	ofono_dbus_dict_append(&array, "Technology", DBUS_TYPE_STRING, &rat);
> +	ofono_dbus_dict_append(&array, "Cause", DBUS_TYPE_INT32,
> +						&ri->reject_cause);
> +	ofono_dbus_dict_append(&array, "Type", DBUS_TYPE_INT32,
> +						&ri->reject_type);
> +	ofono_dbus_dict_append(&array, "Reason", DBUS_TYPE_STRING, &reason);
> +
> +	dbus_message_iter_close_container(&variant, &array);
> +	dbus_message_iter_close_container(iter, &variant);
> +}
> +
> +void ofono_gprs_rejectinfo_notify(struct ofono_gprs *gprs, int plmn,
> +					int service_domain, int rat_type,
> +					int reject_cause, int reject_type)
> +{
> +	DBusConnection *conn;
> +	DBusMessage *signal;
> +	DBusMessageIter iter;
> +	const char *name =3D "RejectInfo";
> +	const char *path;
> +	const struct rejectinfo ri =3D { plmn, service_domain, rat_type,
> +					reject_cause, reject_type };
> +
> +	if (!gprs)
> +		return;
> +
> +	path =3D __ofono_atom_get_path(gprs->atom);
> +	signal =3D dbus_message_new_signal(path,
> +					OFONO_CONNECTION_MANAGER_INTERFACE,
> +					"PropertyChanged");
> +
> +	if (!signal)
> +		return;
> +
> +	conn =3D ofono_dbus_get_connection();
> +
> +	dbus_message_iter_init_append(signal, &iter);
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
> +
> +	append_rejectinfo_properties(&ri, &iter);
> +
> +	g_dbus_send_message(conn, signal);

Looks like RejectInfo is not really a property, but just a plain signal ins=
tead.

> +}
> +
>   void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
>   					unsigned int cid)
>   {
> =


Regards,
-Denis
--===============7698936107606043105==--

