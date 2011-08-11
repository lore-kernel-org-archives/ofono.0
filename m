Content-Type: multipart/mixed; boundary="===============4983583017080992247=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/3] cdma-connman: Add D-Bus API to remove credentials
Date: Thu, 11 Aug 2011 12:19:03 +0200
Message-ID: <4E43AC97.4080009@linux.intel.com>
In-Reply-To: <4E417E5F.4070406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4983583017080992247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 09/08/2011 20:37, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/09/2011 09:48 AM, Guillaume Zajac wrote:
>> ---
>>   src/cdma-connman.c |   34 ++++++++++++++++++++++++++++++++++
>>   1 files changed, 34 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/cdma-connman.c b/src/cdma-connman.c
>> index 3967080..9f40104 100644
>> --- a/src/cdma-connman.c
>> +++ b/src/cdma-connman.c
>> @@ -510,16 +510,50 @@ static DBusMessage *cdma_connman_set_property(DBus=
Connection *conn,
>>   	return __ofono_error_invalid_args(msg);
>>   }
>>
>> +static DBusMessage *cdma_connman_remove_credentials(DBusConnection *con=
n,
>> +							DBusMessage *msg,
>> +							void *data)
>> +{
>> +	struct ofono_cdma_connman *cm =3D data;
>> +	const char *path;
>> +
>> +	DBG("");
>> +
>> +	strcpy(cm->username, "");
>> +	strcpy(cm->password, "");
>> +
>> +	if (cm->powered =3D=3D TRUE)
>> +		cm->driver->deactivate(cm, deactivate_callback, cm);
> You can't do it this way, you need to ensure no other operations are in
> progress...
>
>> +
>> +	if (cm->credentials) {
>> +		g_key_file_remove_group(cm->credentials, CREDENTIALS_GROUP,
>> +					NULL);
>> +		storage_sync(cm->serial, CREDENTIALS_STORE, cm->credentials);
>> +	}
>> +
>> +	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
>> +
>> +	path =3D __ofono_atom_get_path(cm->atom);
>> +	g_dbus_emit_signal(conn, path, OFONO_CONNECTION_MANAGER_INTERFACE,
>> +				"CredentialsRemoved", DBUS_TYPE_INVALID);
>> +
>> +	return NULL;
>> +}
>> +
>>   static GDBusMethodTable cdma_connman_methods[] =3D {
>>   	{ "GetProperties",	"",	"a{sv}",
>>   						cdma_connman_get_properties },
>>   	{ "SetProperty",	"sv",	"",	cdma_connman_set_property,
>>   						G_DBUS_METHOD_FLAG_ASYNC },
>> +	{ "RemoveCredentials",	"",	"",
>> +					cdma_connman_remove_credentials,
>> +						G_DBUS_METHOD_FLAG_ASYNC },
>>   	{ }
>>   };
>>
>>   static GDBusSignalTable cdma_connman_signals[] =3D {
>>   	{ "PropertyChanged",	"sv" },
>> +	{ "CredentialsRemoved",	"" },
>>   	{ }
>>   };
>>
> However, I'm pretty much against these changes right now.  What exactly
> is your usecase here?
>
>


At the beginning, I would have liked to be able to emit =

"CredentialsAdded" "CredentialsRemoved", to notify ConnMan
that the Cellular service can be published or removed like we do it for =

GSM Contexts.

Now, using "Status" =3D=3D "registered" property from =

cdma.NetworkRegistration to publish the service into ConnMan might be =

cleaner.

With both solutions, we should handle into oFono the ppp_disconnect =

reason G_AT_PPP_REASON_AUTH_FAIL to try again with other credentials.

Kind regards,
Guillaume

--===============4983583017080992247==--

