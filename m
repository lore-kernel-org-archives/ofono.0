Content-Type: multipart/mixed; boundary="===============6535676563572660068=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 09:51:57 +0200
Message-ID: <AANLkTimqcKbRrhthsa_PpgU2Gmhd+HRSS0qubTdAPB40@mail.gmail.com>
In-Reply-To: <201012061900.50380.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6535676563572660068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2010/12/6 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
>> +static struct tm *refresh_nw_time(struct tm *nw_time,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_t received)
>> +{
>> + =C2=A0 =C2=A0 time_t now, new_nw_time;
>> +
>> + =C2=A0 =C2=A0 now =3D get_monotonic_time();
>> + =C2=A0 =C2=A0 new_nw_time =3D timegm(nw_time) + now - received;
>> + =C2=A0 =C2=A0 return gmtime(&new_nw_time);
>> +}
>
> Brrr, the result is somewhere in static data. This can cause quite confus=
ing
> behaviour if/when the code is changed. I would much rather use gmtime_r().

I suppose that's a good point.

> That being said, wouldn't it be far simpler to return a second timestamp
> instead of a broken-down time structure over D-Bus? Eventually, timed/wha=
tever
> will want a timestamp anyway to set the system clock or whatever else it =
wants
> to do with the NITZ.
>
>> +static int fill_time_changed_signal(DBusMessage *signal,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct nettime_data *ntd)
>> +{
>> + =C2=A0 =C2=A0 DBusMessageIter iter, iter_array;
>> + =C2=A0 =C2=A0 int time_available;
>> + =C2=A0 =C2=A0 char buf[MAX_TIME_STR_LEN];
>> + =C2=A0 =C2=A0 struct tm time_tm, *new_time_tm;
>> + =C2=A0 =C2=A0 const char *str =3D buf;
>> +
>> + =C2=A0 =C2=A0 dbus_message_iter_init_append(signal, &iter);
>> + =C2=A0 =C2=A0 dbus_message_iter_open_container(&iter,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_ARRAY,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "{sv}",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &iter_array);
>> +
>> + =C2=A0 =C2=A0 time_available =3D encode_time_format(&ntd->nw_time, &ti=
me_tm);
>> + =C2=A0 =C2=A0 if (time_available !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_time_tm =3D refresh_nw_t=
ime(&time_tm, ntd->received);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strftime(buf, MAX_TIME_STR_L=
EN, TIME_FORMAT, new_time_tm);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_dbus_dict_append(&iter=
_array,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "DateAndTime",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_STRING,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &str);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 ofono_dbus_dict_append(&iter_array,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "Timezone",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_INT32,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &ntd->nw_time.utcoff);
>> + =C2=A0 =C2=A0 ofono_dbus_dict_append(&iter_array,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 "DST",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBUS_TYPE_UINT32,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &ntd->nw_time.dst);
>> + =C2=A0 =C2=A0 dbus_message_iter_close_container(&iter, &iter_array);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> Are the time zone offset and the DST always available, but the current ti=
me
> not? This seems odd.

Tell me about it, but this is how the spec works. Operators have the
flexibility to send just the timezone, the timezone and DST, or the
works.

> Passing the time over D-Bus may cause extra drift/imprecision than we alr=
eady
> have. I wonder if it would make sense to provide not just the current tim=
e but
> both:
> - the current time for trivial programs, and
> - the system boot time (i.e. nw_time - received) for smarter programs;
> =C2=A0this value cannot drift.

I remember we had similar argument in the past with the timed folks,
which actually resulted in a much more convoluted API... I'm still not
convinced time drift is a problem, since NITZ itself is accurate to
the second.

However, thinking about this, I actually don't see any value in
providing a human readable time over D-Bus. No application should
directly ask oFono for time, this is why timed is there to begin with.

So sending a plain time_t over D-Bus is actually sufficient. This
leaves us with having to send timestamps over D-Bus, which is ugly.
Can you explain how you see clock drift a problem here exactly?

>> +static DBusMessage *create_time_changed_signal(
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
struct ofono_nettime_context *context)
>> +{
>> + =C2=A0 =C2=A0 DBusMessage *signal;
>> + =C2=A0 =C2=A0 struct nettime_data *ntd =3D context->data;
>> + =C2=A0 =C2=A0 const char *path =3D ofono_modem_get_path(context->modem=
);
>> +
>> + =C2=A0 =C2=A0 if (path =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Fetching path f=
or modem failed");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 signal =3D dbus_message_new_signal(path, OFONO_NETWORK_T=
IME_INTERFACE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "NetworkTimeChanged=
");
>> + =C2=A0 =C2=A0 fill_time_changed_signal(signal, ntd);
>> +
>> + =C2=A0 =C2=A0 return signal;
>> +}
>> +
>> +static void init_time(struct ofono_nettime_context *context)
>> +{
>> + =C2=A0 =C2=A0 struct nettime_data *nettime_data;
>> + =C2=A0 =C2=A0 context->data =3D g_try_new0(struct nettime_data, 1);
>
> Hmm, if you don't check the result, I suspect you should g_new0() instead.

Good point.

>> + =C2=A0 =C2=A0 nettime_data =3D context->data;
>> + =C2=A0 =C2=A0 nettime_data->nw_time.year =3D -1;
>> +}
>> +
>> +static int nettime_probe(struct ofono_nettime_context *context)
>> +{
>> + =C2=A0 =C2=A0 ofono_debug("Network Time Probe for modem: %p", context-=
>modem);
>> +
>> + =C2=A0 =C2=A0 init_time(context);
>> +
>> + =C2=A0 =C2=A0 nettime_register(context);
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static void nettime_remove(struct ofono_nettime_context *context)
>> +{
>> + =C2=A0 =C2=A0 DBusConnection *conn;
>> + =C2=A0 =C2=A0 const char *path;
>> +
>> + =C2=A0 =C2=A0 ofono_debug("Network Time Remove for modem: %p", context=
->modem);
>> +
>> + =C2=A0 =C2=A0 g_free(context->data);
>> +
>> + =C2=A0 =C2=A0 conn =3D ofono_dbus_get_connection();
>> + =C2=A0 =C2=A0 path =3D ofono_modem_get_path(context->modem);
>> +
>> + =C2=A0 =C2=A0 if (!g_dbus_unregister_interface(conn,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 path,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_NETWORK_TIME_=
INTERFACE))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_error("Could not unreg=
ister %s interface",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_NETWORK_TIME_INTERFACE);
>> +
>> + =C2=A0 =C2=A0 ofono_modem_remove_interface(context->modem,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
OFONO_NETWORK_TIME_INTERFACE);
>> +}
>> +
>> +static void nettime_info_received(struct ofono_nettime_context *context,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ofono_network_time *info)
>> +{
>> + =C2=A0 =C2=A0 DBusMessage *nt_signal;
>> + =C2=A0 =C2=A0 struct nettime_data *ntd =3D context->data;
>> +
>> + =C2=A0 =C2=A0 if (info =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 ofono_debug("Received a network time notification on mod=
em: %p",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
context->modem);
>> +
>> + =C2=A0 =C2=A0 ntd->nw_time =3D *info;
>> + =C2=A0 =C2=A0 ntd->received =3D get_monotonic_time();
>
> That works. But I would do the gmtime() conversion here, and store the re=
sult
> once and for all, instead of copying the raw data and recompute the conve=
rsion
> every time.

Sounds good.

Also, should use memcpy() for the info above.

Cheers,
Aki

--===============6535676563572660068==--

