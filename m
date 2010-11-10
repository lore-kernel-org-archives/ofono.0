Content-Type: multipart/mixed; boundary="===============6680047061922915355=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 2/3] modem: add EmergencyMode property
Date: Wed, 10 Nov 2010 16:14:56 +0200
Message-ID: <4CDAA8E0.3040403@nokia.com>
In-Reply-To: <4CD95CBD.2070705@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6680047061922915355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 11/09/2010 04:37 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 11/09/2010 02:59 AM, Andras Domokos wrote:
>    =

>> Signed-off-by: Andras Domokos<Andras.Domokos@nokia.com>
>> ---
>>   src/modem.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>   src/ofono.h |    4 ++++
>>   2 files changed, 57 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/modem.c b/src/modem.c
>> index f73cc1d..d7ad90e 100644
>> --- a/src/modem.c
>> +++ b/src/modem.c
>> @@ -72,6 +72,7 @@ struct ofono_modem {
>>   	ofono_bool_t		powered_pending;
>>   	guint			timeout;
>>   	ofono_bool_t		online;
>> +	unsigned int		emergency_mode;
>>   	struct ofono_watchlist	*online_watches;
>>   	GHashTable		*properties;
>>   	struct ofono_sim	*sim;
>> @@ -479,6 +480,50 @@ void __ofono_modem_remove_online_watch(struct ofono=
_modem *modem, unsigned id)
>>   	__ofono_watchlist_remove_item(modem->online_watches, id);
>>   }
>>
>> +ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem)
>> +{
>> +	if (modem =3D=3D NULL)
>> +		return FALSE;
>> +
>> +	return modem->emergency_mode !=3D 0;
>> +}
>> +
>> +void ofono_modem_inc_emergency_mode(struct ofono_modem *modem)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *path =3D ofono_modem_get_path(modem);
>> +	ofono_bool_t emergency_mode =3D modem->emergency_mode;
>>      =

> I suggest getting rid of this variable
>
>    =

>> +	gboolean state =3D TRUE;
>> +
>> +	modem->emergency_mode++;
>> +	if (emergency_mode)
>> +		return;
>> +
>>      =

> And checking if modem->emergency_mode>  1 here...
>
>    =

You are right, makes the code shorter with less variables.
>> +	ofono_dbus_signal_property_changed(conn, path,
>> +						OFONO_MODEM_INTERFACE,
>> +						"EmergencyMode",
>> +						DBUS_TYPE_BOOLEAN,
>> +						&state);
>> +	modem_change_state(modem, MODEM_STATE_ONLINE);
>>      =

> So we have to be a bit careful here.  You can't simply call
> modem_change_state here.  This results in calling the post_online
> method, which populates the atoms that function when the radio is on.
> Instead you need to call the set_online driver method directly.
>
> Also, you probably do not want to populate the online atoms in an
> emergency call situation.  Each atom driver / atom will perform
> initialization procedures when they're newly added.  This can
> potentially interfere with the voice call setup time, and not desirable.
>   Not to mention that if we're actually in an emergency situation with
> the SIM removed or PIN locked, we do not want to populate the atoms in
> the first place.
>
> So the modem 'ONLINE_STATE' has to be slightly de-coupled from whether
> the radio is 'online'.
>
>    =

Good point, thanks. I am going to call directly the modem driver
set_online function with my own callback.

Now the question is whether modem->online should be toggled
according to the radio state changes? I think yes, and have the
change signaled on D-Bus (modem "Online" poperty).

There is another question then, when to notify the modem online
watchers, supposedly whenever modem->online changes, including
the changes triggered by the emergency call case.

>> +}
>> +
>> +void ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
>> +{
>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>> +	const char *path =3D ofono_modem_get_path(modem);
>> +	gboolean state =3D FALSE;
>> +
>> +	modem->emergency_mode--;
>> +	if (modem->emergency_mode)
>> +		return;
>> +
>> +	ofono_dbus_signal_property_changed(conn, path,
>> +						OFONO_MODEM_INTERFACE,
>> +						"EmergencyMode",
>> +						DBUS_TYPE_BOOLEAN,
>> +						&state);
>>      =

> Here you should turn the radio off if it was off before starting the
> emergency call.
>
>    =


The rationale behind leaving the radio on after emergency calls
was to have the theoretical possibility the emergency call center
to call you back (when SIM card is present...). If this is an unrealistic
scenario, I'll disable the radio after emergency calls in case it was off
before the call.

>    =

>> +}
>> +
>>   static void online_cb(const struct ofono_error *error, void *data)
>>   {
>>   	struct ofono_modem *modem =3D data;
>> @@ -535,6 +580,9 @@ static DBusMessage *set_property_online(struct ofono=
_modem *modem,
>>   	if (modem->modem_state<  MODEM_STATE_OFFLINE)
>>   		return __ofono_error_not_available(msg);
>>
>> +	if (modem->emergency_mode&&  online =3D=3D FALSE)
>> +		return __ofono_error_failed(msg);
>> +
>>   	if (modem->online =3D=3D online)
>>   		return dbus_message_new_method_return(msg);
>>
>> @@ -562,6 +610,7 @@ void __ofono_modem_append_properties(struct ofono_mo=
dem *modem,
>>   	int i;
>>   	GSList *l;
>>   	struct ofono_atom *devinfo_atom;
>> +	ofono_bool_t state;
>>
>>   	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
>>   				&modem->online);
>> @@ -569,6 +618,10 @@ void __ofono_modem_append_properties(struct ofono_m=
odem *modem,
>>   	ofono_dbus_dict_append(dict, "Powered", DBUS_TYPE_BOOLEAN,
>>   				&modem->powered);
>>
>> +	state =3D ofono_modem_get_emergency_mode(modem);
>> +	ofono_dbus_dict_append(dict, "EmergencyMode",
>> +				DBUS_TYPE_BOOLEAN,&state);
>> +
>>   	devinfo_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_DEVIN=
FO);
>>
>>   	/* We cheat a little here and don't check the registered status */
>> diff --git a/src/ofono.h b/src/ofono.h
>> index 35335b6..b5c32b4 100644
>> --- a/src/ofono.h
>> +++ b/src/ofono.h
>> @@ -185,6 +185,10 @@ unsigned int __ofono_modem_add_online_watch(struct =
ofono_modem *modem,
>>   void __ofono_modem_remove_online_watch(struct ofono_modem *modem,
>>   		unsigned int id);
>>
>> +ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
>> +void ofono_modem_inc_emergency_mode(struct ofono_modem *modem);
>> +void ofono_modem_dec_emergency_mode(struct ofono_modem *modem);
>> +
>>   #include<ofono/call-barring.h>
>>
>>   gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
>>      =

> Regards,
> -Denis
>    =

Regards,
Andras

--===============6680047061922915355==--

