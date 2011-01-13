Content-Type: multipart/mixed; boundary="===============2154308106534465389=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: Re: [PATCH 3/3] message: Code independent of protocol stack
Date: Thu, 13 Jan 2011 15:23:57 -0800
Message-ID: <4D2F898D.2000900@nokia.com>
In-Reply-To: <4D2F425C.8080809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2154308106534465389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On 01/13/2011 10:20 AM, ext Denis Kenzior wrote:
> Hi Faiyaz,
>
>> +static const char *message_state_to_string(enum message_state s)
>> +{
>> +	switch (s) {
>> +	case MESSAGE_STATE_PENDING:
>> +		return "pending";
>> +	case MESSAGE_STATE_SENT:
>> +		return "sent";
>> +	case MESSAGE_STATE_FAILED:
>> +		return "failed";
>> +	}
>> +
>> +	return "invalid";
>
> As mentioned previously, don't return "invalid" here.

Will remove "invalid"

>
> <snip>
>
>> +gboolean ofono_message_dbus_register(const char *atompath, struct messa=
ge *m)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *path;
>> +
>> +	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
>> +		return FALSE;
>
> Please get rid of these parentheses, they're not needed.  Also, in
> general we prefer not to use null checking in the core.  The earlier we
> crash the easier it is to find the bugs.

will fix all the occurrences.

>
>> +
>> +	path =3D ofono_message_path_from_uuid(atompath,&m->uuid);
>> +
>> +	if (!g_dbus_register_interface(conn, path, OFONO_MESSAGE_INTERFACE,
>> +					message_methods, message_signals,
>> +					NULL, m, message_destroy)) {
>> +		ofono_error("Could not register Message %s", path);
>> +		message_destroy(m);
>> +
>> +		return FALSE;
>> +	}
>> +
>> +	return TRUE;
>> +}
>> +
>> +void ofono_message_dbus_unregister(const char *atompath, struct message=
 *m)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *path;
>> +
>> +	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
>> +		return;
>
> Same comment as above about the parentheses.
>
>> +
>> +	path =3D ofono_message_path_from_uuid(atompath,&m->uuid);
>> +
>> +	g_dbus_unregister_interface(conn, path, OFONO_MESSAGE_INTERFACE);
>> +
>> +	return;
>> +}
>> +
>> +const struct ofono_uuid *ofono_message_get_uuid(const struct message *m)
>> +{
>> +	if (m =3D=3D NULL)
>> +		return NULL;
>> +
>> +	return&m->uuid;
>> +}
>> +
>> +void ofono_message_set_state(const char *atompath,
>> +			struct message *m, enum message_state new_state)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *state;
>> +	const char *path;
>> +
>> +	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
>> +		return;
>> +
>
> And again the comment about parentheses.
>
>> +	if (m->state =3D=3D new_state)
>> +		return;
>> +
>> +	path =3D ofono_message_path_from_uuid(atompath,&m->uuid);
>> +
>> +	m->state =3D new_state;
>> +	state =3D message_state_to_string(m->state);
>> +
>> +	ofono_dbus_signal_property_changed(conn, path, OFONO_MESSAGE_INTERFACE,
>> +						"State", DBUS_TYPE_STRING,
>> +									&state);
>> +}
>> +
>> +void ofono_message_append_properties(struct message *m, DBusMessageIter=
 *dict)
>> +{
>> +	const char *state;
>> +
>> +	if (m =3D=3D NULL)
>> +		return;
>> +
>> +	state =3D message_state_to_string(m->state);
>> +	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING,&state);
>> +}
>> +
>> +void ofono_emit_message_added(const char *atompath, const char *interfa=
ce,
>> +							struct message *m)
>> +{
>> +	DBusMessage *signal;
>> +	DBusMessageIter iter;
>> +	DBusMessageIter dict;
>> +	const char *path;
>> +
>> +	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
>> +		return;
>> +
>
> And here
>
>> +	signal =3D dbus_message_new_signal(atompath, interface, "MessageAdded"=
);
>> +	if (signal =3D=3D NULL)
>> +		return;
>> +
>> +	path =3D ofono_message_path_from_uuid(atompath,&m->uuid);
>> +
>> +	dbus_message_iter_init_append(signal,&iter);
>> +
>> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,&path);
>> +
>> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>> +					&dict);
>> +	ofono_message_append_properties(m,&dict);
>> +	dbus_message_iter_close_container(&iter,&dict);
>> +
>> +	g_dbus_send_message(ofono_dbus_get_connection(), signal);
>> +}
>> +
>> +void ofono_emit_message_removed(const char *atompath, const char *inter=
face,
>> +							struct message *m)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *path;
>> +
>> +	if ((atompath =3D=3D NULL) || (m =3D=3D NULL))
>> +		return;
>> +
>
> And here ;)
>
>> +	path =3D ofono_message_path_from_uuid(atompath,&m->uuid);
>> +
>> +	g_dbus_emit_signal(conn, atompath, interface,
>> +				"MessageRemoved", DBUS_TYPE_OBJECT_PATH,&path,
>> +				DBUS_TYPE_INVALID);
>> +}
>> +
>> +const char *ofono_message_path_from_uuid(const char *atompath,
>> +						const struct ofono_uuid *uuid)
>
> Please keep this as an internal API (e.g.
> __ofono_message_path_from_uuid) and update ofono.h appropriately.

Based on a comment in Patch 2/3, message.h and message.c are internal to =

core and to me they look more of a utility/helper functions to sms.c =

file (and in future cdma-sms.c file).  So should I even include =

"message.h" in ofono.h file. I could only rename the function to be =

message_XXX.

The sms.h still maintains the API "__ofono_sms_message_path_from_uuid" =

which is shared with "smart-messaging.c" and is defined in ofono.h


>
>> +{
>> +	static char path[256];
>> +
>> +	snprintf(path, sizeof(path), "%s/message_%s", atompath,
>> +						ofono_uuid_to_str(uuid));
>> +
>> +	return path;
>> +}
>> +
>> +void *ofono_message_get_data(struct message *m)
>> +{
>> +	return m->data;
>> +}
>
> <snip>
>
>> @@ -1904,15 +1714,16 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms=
, GSList *list,
>>   		return -ENOMEM;
>>
>>   	if (flags&  OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
>> -		m =3D message_create(&entry->uuid);
>> +		m =3D ofono_message_create(&entry->uuid, entry);
>>   		if (m =3D=3D NULL)
>>   			goto err;
>>
>> -		if (message_dbus_register(sms, m) =3D=3D FALSE)
>> +		if (ofono_message_dbus_register(
>> +					__ofono_atom_get_path(sms->atom),
>> +								m) =3D=3D FALSE)
>
> This looks a bit ugly, can you find a better way to do this?  Perhaps
> message_create should simply take an atom as well.
I think we can go with
1) Pass "sms->atom", add "struct ofono_atom *atom" in the message struct =

and initialize the reference of the same in message_create. But I am not =

sure if it will be okay to pass a reference to a private data member =

from struct ofono_sms.
struct message {
	struct ofono_uuid uuid;
	enum message_state state;
	void *data;
         struct ofono_atom *atom;
};

2) Pass "__ofono_atom_get_path(sms->atom)" and use malloc in =

message_create to initialize "atompath". Just use atompath through the =

code. But a general observation I had was that in ofono we used "static =

char xxx[]" instead of doing malloc. Hence did not go this route in the =

initial patch.

struct message {
	struct ofono_uuid uuid;
	enum message_state state;
	void *data;
	char *atompath;
};

Please let me know your thoughts on the same.

>
>>   			goto err;
>>
>> -		g_hash_table_insert(sms->messages,&m->uuid, m);
>> -		m->entry =3D entry;
>> +		g_hash_table_insert(sms->messages,&entry->uuid, m);
>>   	}
>>
>>   	if (list->next !=3D NULL) {
>> @@ -1934,7 +1745,9 @@ int __ofono_sms_txq_submit(struct ofono_sms *sms, =
GSList *list,
>>   		cb(sms,&entry->uuid, data);
>>
>>   	if (m&&  (flags&  OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS))
>> -		emit_message_added(sms, m);
>> +		ofono_emit_message_added(__ofono_atom_get_path(sms->atom),
>> +					OFONO_MESSAGE_MANAGER_INTERFACE,
>> +					m);
>>
>>   	return 0;
>>
>> @@ -1951,15 +1764,18 @@ int __ofono_sms_txq_set_submit_notify(struct ofo=
no_sms *sms,
>>   					ofono_destroy_func destroy)
>>   {
>>   	struct message *m;
>> +	struct tx_queue_entry *entry;
>>
>>   	m =3D g_hash_table_lookup(sms->messages, uuid);
>>   	if (m =3D=3D NULL)
>>   		return -ENOENT;
>>
>> -	if (m->entry =3D=3D NULL)
>> +	entry =3D (struct tx_queue_entry *)ofono_message_get_data(m);
>
> Space after the cast, rule M6

Will fix it.

>
>> +	if (entry =3D=3D NULL)
>>   		return -ENOTSUP;
>>
>> -	tx_queue_entry_set_submit_notify(m->entry, cb, data, destroy);
>> +	tx_queue_entry_set_submit_notify(entry, cb, data, destroy);
>>
>>   	return 0;
>>   }
>> +
>
> What is this empty line for?
will fix it.


>
> Regards,
> -Denis


--===============2154308106534465389==--

