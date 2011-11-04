Content-Type: multipart/mixed; boundary="===============3931624991693770953=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 3/6] cdma-connman: Rely on roaming and cdma-netreg
 status to enable data call
Date: Fri, 04 Nov 2011 15:42:36 +0100
Message-ID: <4EB3F9DC.8000906@linux.intel.com>
In-Reply-To: <4EB1615F.9000105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3931624991693770953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/11/2011 16:27, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 11/02/2011 05:37 AM, Guillaume Zajac wrote:
>> ---
>>   src/cdma-connman.c |   65 ++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>>   1 files changed, 62 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/cdma-connman.c b/src/cdma-connman.c
>> index db8f6c5..42dcca2 100644
>> --- a/src/cdma-connman.c
>> +++ b/src/cdma-connman.c
>> @@ -52,8 +52,11 @@ struct cdma_connman_settings {
>>   struct ofono_cdma_connman {
>>   	ofono_bool_t powered;
>>   	ofono_bool_t dormant;
>> +	ofono_bool_t roaming_allowed;
>>   	struct cdma_connman_settings *settings;
>>   	DBusMessage *pending;
>> +	struct ofono_cdma_netreg *cdma_netreg;
>> +	unsigned int cdma_netreg_watch;
>>   	const struct ofono_cdma_connman_driver *driver;
>>   	void *driver_data;
>>   	struct ofono_atom *atom;
>> @@ -338,6 +341,17 @@ static void cdma_connman_settings_append_properties(
>>   	dbus_message_iter_close_container(dict,&entry);
>>   }
>>
>> +ofono_bool_t cdma_connman_netreg_update(struct ofono_cdma_connman *cm)
>> +{
> I think this function should be named a bit better.  Wouldn't
> is_registered be clearer?

Yes.

>> +	ofono_bool_t registered;
>> +	int status  =3D ofono_cdma_netreg_get_status(cm->cdma_netreg);
>> +
>> +	registered =3D status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED;
>> +
>> +	return registered || (cm->roaming_allowed&&
>> +			status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> You seem to be doing quite a bit of work to accomplish your goal.  If
> you use __ofono_modem_find_atom then you can drop all the atom watch
> bits and make this implementation way easier.

I will remove the atom watch and try to find it, if it fails I will =

return FALSE.

>> +}
>> +
>>   static DBusMessage *cdma_connman_get_properties(DBusConnection *conn,
>>   						DBusMessage *msg, void *data)
>>   {
>> @@ -365,6 +379,10 @@ static DBusMessage *cdma_connman_get_properties(DBu=
sConnection *conn,
>>   	value =3D cm->dormant;
>>   	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN,&value);
>>
>> +	value =3D cm->roaming_allowed;
>> +	ofono_dbus_dict_append(&dict, "RoamingAllowed",
>> +				DBUS_TYPE_BOOLEAN,&value);
>> +
>>   	if (cm->settings)
>>   		cdma_connman_settings_append_properties(cm,&dict);
>>
>> @@ -450,7 +468,23 @@ static DBusMessage *cdma_connman_set_property(DBusC=
onnection *conn,
>>
>>   	dbus_message_iter_recurse(&iter,&var);
>>
>> -	if (!strcmp(property, "Powered")) {
>> +	if (!strcmp(property, "RoamingAllowed")) {
>> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
>> +			return __ofono_error_invalid_args(msg);
>> +
>> +		dbus_message_iter_get_basic(&var,&value);
>> +
>> +		if (cm->roaming_allowed =3D=3D (ofono_bool_t) value)
>> +			return dbus_message_new_method_return(msg);
>> +
>> +		cm->roaming_allowed =3D value;
>> +
>> +		if (cdma_connman_netreg_update(cm) =3D=3D FALSE&&
>> +				cm->powered =3D=3D TRUE)
>> +			cm->driver->deactivate(cm, deactivate_callback, cm);
>> +
> Can you please put the RoamingAllowed details in a separate patch
> (preferably among the last in the series), this one might need to be
> thought about some more.

Ok I will separate it.

>> +		return NULL;
>> +	} if (!strcmp(property, "Powered")) {
>>   		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
>>   			return __ofono_error_invalid_args(msg);
>>
>> @@ -463,9 +497,11 @@ static DBusMessage *cdma_connman_set_property(DBusC=
onnection *conn,
>>   				cm->driver->deactivate =3D=3D NULL)
>>   			return __ofono_error_not_implemented(msg);
>>
>> +		if (cdma_connman_netreg_update(cm) =3D=3D FALSE)
>> +			return __ofono_error_not_registered(msg);
>> +
>>   		cm->pending =3D dbus_message_ref(msg);
>>
>> -		/* TODO: add logic to support CDMA Network Registration */
>>   		if (value)
>>   			cm->driver->activate(cm, cm->username, cm->password,
>>   						activate_callback, cm);
>> @@ -529,11 +565,18 @@ void ofono_cdma_connman_driver_unregister(
>>   static void cdma_connman_unregister(struct ofono_atom *atom)
>>   {
>>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	struct ofono_cdma_connman *cm =3D __ofono_atom_get_data(atom);
>>   	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
>>   	const char *path =3D __ofono_atom_get_path(atom);
>>
>>   	DBG("");
>>
>> +	if (cm->cdma_netreg_watch) {
>> +		__ofono_modem_remove_atom_watch(modem, cm->cdma_netreg_watch);
>> +		cm->cdma_netreg_watch =3D 0;
>> +		cm->cdma_netreg =3D NULL;
>> +	}
>> +
>>   	g_dbus_unregister_interface(conn, path,
>>   				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
>>   	ofono_modem_remove_interface(modem,
>> @@ -593,6 +636,20 @@ struct ofono_cdma_connman *ofono_cdma_connman_creat=
e(
>>   	return cm;
>>   }
>>
>> +static void cdma_netreg_watch(struct ofono_atom *atom,
>> +				enum ofono_atom_watch_condition cond,
>> +				void *data)
>> +{
>> +	struct ofono_cdma_connman *cm =3D data;
>> +
>> +	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
>> +		cm->cdma_netreg =3D NULL;
>> +		return;
>> +	}
>> +
>> +	cm->cdma_netreg =3D __ofono_atom_get_data(atom);
>> +}
>> +
>>   void ofono_cdma_connman_register(struct ofono_cdma_connman *cm)
>>   {
>>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>> @@ -613,7 +670,9 @@ void ofono_cdma_connman_register(struct ofono_cdma_c=
onnman *cm)
>>   	ofono_modem_add_interface(modem,
>>   				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
>>
>> -	/* TODO: add watch to support CDMA Network Registration atom */
>> +	cm->cdma_netreg_watch =3D __ofono_modem_add_atom_watch(modem,
>> +					OFONO_ATOM_TYPE_CDMA_NETREG,
>> +					cdma_netreg_watch, cm, NULL);
>>
>>   	__ofono_atom_register(cm->atom, cdma_connman_unregister);
>>   }
> Regards,
> -Denis
>

Kind regards,
Guillaume

--===============3931624991693770953==--

