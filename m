Content-Type: multipart/mixed; boundary="===============6971921435911259591=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 2/2] bluetooth: Add Bluetooth service authorization support
Date: Mon, 07 Feb 2011 17:06:24 +0100
Message-ID: <4D501880.6050005@linux.intel.com>
In-Reply-To: <20110204180859.GA2370@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6971921435911259591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Gustavo,

Le 04/02/2011 19:08, Gustavo F. Padovan a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> * Fr=C3=A9d=C3=A9ric Danis<frederic.danis@linux.intel.com>  [2011-02-04=
 15:44:04 +0100]:
>
>> ---
>>   plugins/bluetooth.c |  125 +++++++++++++++++++++++++++++++++++++++++++=
+++----
>>   1 files changed, 115 insertions(+), 10 deletions(-)
>>
>> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
>> index b489dad..8d28b07 100644
>> --- a/plugins/bluetooth.c
>> +++ b/plugins/bluetooth.c
>> @@ -44,6 +44,8 @@ static GHashTable *adapter_address_hash =3D NULL;
>>   static gint bluetooth_refcount;
>>   static GSList *server_list =3D NULL;
>>
>> +#define TIMEOUT (60) /* Timeout for user response (seconds) */
>> +
>>   struct server {
>>   	guint8 channel;
>>   	char *sdp_record;
>> @@ -58,6 +60,8 @@ struct cb_data {
>>   	struct server *server;
>>   	char *path;
>>   	guint source;
>> +	GIOChannel *io;
>> +	gboolean pending_auth;
>>   };
>>
>>   void bluetooth_create_path(const char *dev_addr, const char *adapter_a=
ddr,
>> @@ -483,26 +487,104 @@ static void cb_data_destroy(gpointer data)
>>   	g_free(cb_data);
>>   }
>>
>> +static void cancel_authorization(struct cb_data *user_data)
>> +{
>> +	DBusMessage *msg;
>> +
>> +	if (user_data->path =3D=3D NULL)
>> +		return;
>> +
>> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, user_data->path,
>> +						BLUEZ_SERVICE_INTERFACE,
>> +						"CancelAuthorization");
>> +
>> +	if (msg =3D=3D NULL) {
>> +		ofono_error("Unable to allocate D-Bus CancelAuthorization"
>> +				" message");
>> +		return;
>> +	}
>> +
>> +	g_dbus_send_message(connection, msg);
>> +}
>> +
>>   static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpoi=
nter data)
>>   {
>>   	struct cb_data *cb_data =3D data;
>>   	struct server *server =3D cb_data->server;
>>
>> -	server->client_list =3D g_slist_remove(server->client_list,
>> +	if (cb_data->pending_auth =3D=3D TRUE) {
>> +		cancel_authorization(cb_data);
>> +
>> +		cb_data->pending_auth =3D FALSE;
>> +	} else {
>> +		server->client_list =3D g_slist_remove(server->client_list,
>>   					GUINT_TO_POINTER(cb_data->source));
>>
>> -	cb_data_destroy(cb_data);
>> +		cb_data_destroy(cb_data);
>> +	}
>
> Don't you have to call g_slist_remove and cb_data_destroy for both cases?=
 when
> pending_auth is TRUE or FALSE.

In case of socket disconnection during authorization phase (if user do =

not perform any action in authorization dialog), if g_slist_remove and =

cb_data_destroy are called here we will get a crash when auth_cb will be =

called with an error (as we will try to call both functions on already =

freed memory).
This is why I let auth_cb in charge of removing source from the list and =

freeing memory during authorization phase.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============6971921435911259591==--

