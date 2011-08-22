Content-Type: multipart/mixed; boundary="===============7364076655107429578=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 1/2] modem: Change to online state when serial is set
Date: Mon, 22 Aug 2011 10:47:55 +0200
Message-ID: <4E5217BB.6030604@linux.intel.com>
In-Reply-To: <4E44C989.8040207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7364076655107429578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again Denis,

On 12/08/2011 08:34, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 08/11/2011 11:02 AM, Guillaume Zajac wrote:
>> For modems with no sim atom, we wait for serial reply to proceed post_si=
m.
>> Add API to get serial devinfo like it is done for imsi.
>> ---
>>   include/devinfo.h |    2 ++
>>   src/modem.c       |   23 ++++++++++++++++++++---
>>   2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/devinfo.h b/include/devinfo.h
>> index 5df1316..db1db67 100644
>> --- a/include/devinfo.h
>> +++ b/include/devinfo.h
>> @@ -61,6 +61,8 @@ void ofono_devinfo_remove(struct ofono_devinfo *info);
>>   void ofono_devinfo_set_data(struct ofono_devinfo *info, void *data);
>>   void *ofono_devinfo_get_data(struct ofono_devinfo *info);
>>
>> +const char *ofono_devinfo_get_serial(struct ofono_devinfo *info);
>> +
>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/src/modem.c b/src/modem.c
>> index 14c7a20..aa6b1c6 100644
>> --- a/src/modem.c
>> +++ b/src/modem.c
>> @@ -72,6 +72,7 @@ struct ofono_modem {
>>   	ofono_bool_t		powered_pending;
>>   	ofono_bool_t		get_online;
>>   	ofono_bool_t		lockdown;
>> +	ofono_bool_t		pending_post_sim;
>>   	char			*lock_owner;
>>   	guint			lock_watch;
>>   	guint			timeout;
>> @@ -1093,9 +1094,14 @@ static DBusMessage *modem_set_property(DBusConnec=
tion *conn,
>>   		if (powered) {
>>   			modem_change_state(modem, MODEM_STATE_PRE_SIM);
>>
>> -			/* Force SIM Ready for devies with no sim atom */
>> +			/*
>> +			 * Force SIM Ready for devices with no sim atom
>> +			 * Pratically, it concerns CDMA modems. We need to
>> +			 * check if their serial is set before proceeding
>> +			 * post_sim.
>> +			 */
> This comment is not true, this behavior is mostly for HFP_HF devices,
> not CDMA devices, and these don't even have a devinfo atom.  So you are
> breaking these now.
>

I have just seen on ConnMan that Marcel would like to have a cdma SIM =

atom into oFono core.
Previously, I have heard that SIM atom for cdma modem was not appropriate:
So should I give up this implementation and wait for the cdma SIM atom =

implementation to manage
credentials like it is done for GSM modem?


>>   			if (modem_has_sim(modem) =3D=3D FALSE)
>> -				sim_state_watch(OFONO_SIM_STATE_READY, modem);
>> +				modem->pending_post_sim =3D TRUE;
>>   		} else {
>>   			set_online(modem, FALSE);
>>   			modem_change_state(modem, MODEM_STATE_POWER_OFF);
>> @@ -1175,7 +1181,7 @@ void ofono_modem_set_powered(struct ofono_modem *m=
odem, ofono_bool_t powered)
>>
>>   		/* Force SIM Ready for devices with no sim atom */
>>   		if (modem_has_sim(modem) =3D=3D FALSE)
>> -			sim_state_watch(OFONO_SIM_STATE_READY, modem);
>> +			modem->pending_post_sim =3D TRUE;
>>   	} else {
>>   		set_online(modem, FALSE);
>>
>> @@ -1315,18 +1321,29 @@ void ofono_modem_remove_interface(struct ofono_m=
odem *modem,
>>   	modem->interface_update =3D g_idle_add(trigger_interface_update, mode=
m);
>>   }
>>
>> +const char *ofono_devinfo_get_serial(struct ofono_devinfo *info)
>> +{
>> +	return info->serial;
>> +}
>> +
>>   static void query_serial_cb(const struct ofono_error *error,
>>   				const char *serial, void *user)
>>   {
>>   	struct ofono_devinfo *info =3D user;
>>   	DBusConnection *conn =3D ofono_dbus_get_connection();
>>   	const char *path =3D __ofono_atom_get_path(info->atom);
>> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(info->atom);
>>
>>   	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>>   		return;
>>
>>   	info->serial =3D g_strdup(serial);
>>
>> +	if (modem->pending_post_sim =3D=3D TRUE) {
>> +		modem->pending_post_sim =3D FALSE;
>> +		sim_state_watch(OFONO_SIM_STATE_READY, modem);
>> +	}
>> +
>>   	ofono_dbus_signal_property_changed(conn, path,
>>   						OFONO_MODEM_INTERFACE,
>>   						"Serial", DBUS_TYPE_STRING,


Kind regards,
Guillaume

--===============7364076655107429578==--

