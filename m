Content-Type: multipart/mixed; boundary="===============5004561185702087850=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/2] cdma-connman: Add cdma-netreg status watch to
 activate data call
Date: Mon, 31 Oct 2011 16:27:27 +0100
Message-ID: <4EAEBE5F.7080208@linux.intel.com>
In-Reply-To: <4EACF9CC.9010101@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5004561185702087850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/10/2011 08:16, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 10/20/2011 10:41 AM, Guillaume Zajac wrote:
>> ---
>>   src/cdma-connman.c |   74 ++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>   1 files changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/cdma-connman.c b/src/cdma-connman.c
>> index db8f6c5..edd71b5 100644
>> --- a/src/cdma-connman.c
>> +++ b/src/cdma-connman.c
>> @@ -52,6 +52,11 @@ struct cdma_connman_settings {
>>   struct ofono_cdma_connman {
>>   	ofono_bool_t powered;
>>   	ofono_bool_t dormant;
>> +	ofono_bool_t attached;
>> +	int cdma_netreg_status;
>> +	struct ofono_cdma_netreg *cdma_netreg;
>> +	unsigned int cdma_netreg_watch;
>> +	unsigned int cdma_status_watch;
>>   	struct cdma_connman_settings *settings;
>>   	DBusMessage *pending;
>>   	const struct ofono_cdma_connman_driver *driver;
>> @@ -465,7 +470,9 @@ static DBusMessage *cdma_connman_set_property(DBusCo=
nnection *conn,
>>
>>   		cm->pending =3D dbus_message_ref(msg);
>>
>> -		/* TODO: add logic to support CDMA Network Registration */
>> +		if (value&&  !cm->attached)
>> +			return __ofono_error_not_attached(msg);
>> +
> There is no concept of attachment in CDMA, so I'd prefer we not do it
> this way.  Can't we simply check the current netreg atom status here?

Fine for me. Then we should also create a new D-Bus error message like:
__ofono_error_not_registered().

>>   		if (value)
>>   			cm->driver->activate(cm, cm->username, cm->password,
>>   						activate_callback, cm);
>> @@ -531,9 +538,23 @@ static void cdma_connman_unregister(struct ofono_at=
om *atom)
>>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>>   	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
>>   	const char *path =3D __ofono_atom_get_path(atom);
>> +	struct ofono_cdma_connman *cm =3D __ofono_atom_get_data(atom);
>>
>>   	DBG("");
>>
>> +	if (cm->cdma_netreg_watch) {
>> +		if (cm->cdma_status_watch) {
>> +			__ofono_cdma_netreg_remove_status_watch(
>> +							cm->cdma_netreg,
>> +							cm->cdma_status_watch);
>> +			cm->cdma_status_watch =3D 0;
>> +		}
>> +
>> +		__ofono_modem_remove_atom_watch(modem, cm->cdma_netreg_watch);
>> +		cm->cdma_netreg_watch =3D 0;
>> +		cm->cdma_netreg =3D NULL;
>> +	}
>> +
>>   	g_dbus_unregister_interface(conn, path,
>>   				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
>>   	ofono_modem_remove_interface(modem,
>> @@ -593,6 +614,53 @@ struct ofono_cdma_connman *ofono_cdma_connman_creat=
e(
>>   	return cm;
>>   }
>>
>> +static void cdma_connman_netreg_update(struct ofono_cdma_connman *cm)
>> +{
>> +	ofono_bool_t attach;
>> +
>> +	attach =3D cm->cdma_netreg_status =3D=3D
>> +			NETWORK_REGISTRATION_STATUS_REGISTERED;
>> +
>> +	/* TODO: Manager roaming case */
>> +
>> +	cm->attached =3D attach;
>> +}
>> +
>> +static void cdma_netreg_status_changed(int status, void *data)
>> +{
>> +	struct ofono_cdma_connman *cm =3D data;
>> +
>> +	DBG("%d", status);
>> +
>> +	if (cm->cdma_netreg_status =3D=3D status)
>> +		return;
>> +
>> +	cm->cdma_netreg_status =3D status;
>> +
>> +	cdma_connman_netreg_update(cm);
>> +}
>> +
>> +static void cdma_netreg_watch(struct ofono_atom *atom,
>> +				enum ofono_atom_watch_condition cond,
>> +				void *data)
>> +{
>> +	struct ofono_cdma_connman *cm =3D data;
>> +
>> +	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
>> +		cm->cdma_netreg_status =3D
>> +				NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
>> +		return;
>> +	}
>> +
>> +	cm->cdma_netreg =3D __ofono_atom_get_data(atom);
>> +	cm->cdma_netreg_status =3D ofono_cdma_netreg_get_status(cm->cdma_netre=
g);
>> +	cm->cdma_status_watch =3D
>> +			__ofono_cdma_netreg_add_status_watch(cm->cdma_netreg,
>> +					cdma_netreg_status_changed, cm, NULL);
>> +
>> +	cdma_connman_netreg_update(cm);
>> +}
>> +
>>   void ofono_cdma_connman_register(struct ofono_cdma_connman *cm)
>>   {
>>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>> @@ -613,7 +681,9 @@ void ofono_cdma_connman_register(struct ofono_cdma_c=
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
> It seems to me that this is way too complicated.  All you want is to
> check the netreg status before trying to set powered.  If we lose netreg
> when the connection is active, then the regular cdma-connman
> notification procedures would apply.

Once we lost netreg, what are we supposed to do?
cdma-netreg atom will signal "Status" property has changed.
Is that up to ConnMan to deactivate the data call in checking the =

cdma-netreg "Status" property equal to "unregistered"?

Kind regards,
Guillaume

--===============5004561185702087850==--

