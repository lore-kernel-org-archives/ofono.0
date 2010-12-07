Content-Type: multipart/mixed; boundary="===============3836481436249671327=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 11:12:41 +0200
Message-ID: <1291713161.3613.26.camel@apaila-ThinkPad-T410>
In-Reply-To: <AANLkTimqcKbRrhthsa_PpgU2Gmhd+HRSS0qubTdAPB40@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3836481436249671327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Hi R=C3=A9mi,
> =

> 2010/12/6 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> >> +static struct tm *refresh_nw_time(struct tm *nw_time,
> >> +                             time_t received)
> >> +{
> >> +     time_t now, new_nw_time;
> >> +
> >> +     now =3D get_monotonic_time();
> >> +     new_nw_time =3D timegm(nw_time) + now - received;
> >> +     return gmtime(&new_nw_time);
> >> +}
> >
> > Brrr, the result is somewhere in static data. This can cause quite conf=
using
> > behaviour if/when the code is changed. I would much rather use gmtime_r=
().
> =

> I suppose that's a good point.
> =

> > That being said, wouldn't it be far simpler to return a second timestamp
> > instead of a broken-down time structure over D-Bus? Eventually, timed/w=
hatever
> > will want a timestamp anyway to set the system clock or whatever else i=
t wants
> > to do with the NITZ.
> >
> >> +static int fill_time_changed_signal(DBusMessage *signal,
> >> +             struct nettime_data *ntd)
> >> +{
> >> +     DBusMessageIter iter, iter_array;
> >> +     int time_available;
> >> +     char buf[MAX_TIME_STR_LEN];
> >> +     struct tm time_tm, *new_time_tm;
> >> +     const char *str =3D buf;
> >> +
> >> +     dbus_message_iter_init_append(signal, &iter);
> >> +     dbus_message_iter_open_container(&iter,
> >> +                                     DBUS_TYPE_ARRAY,
> >> +                                     "{sv}",
> >> +                                     &iter_array);
> >> +
> >> +     time_available =3D encode_time_format(&ntd->nw_time, &time_tm);
> >> +     if (time_available !=3D 0) {
> >> +             new_time_tm =3D refresh_nw_time(&time_tm, ntd->received);
> >> +             strftime(buf, MAX_TIME_STR_LEN, TIME_FORMAT, new_time_tm=
);
> >> +
> >> +             ofono_dbus_dict_append(&iter_array,
> >> +                                     "DateAndTime",
> >> +                                     DBUS_TYPE_STRING,
> >> +                                     &str);
> >> +     }
> >> +
> >> +     ofono_dbus_dict_append(&iter_array,
> >> +                             "Timezone",
> >> +                             DBUS_TYPE_INT32,
> >> +                             &ntd->nw_time.utcoff);
> >> +     ofono_dbus_dict_append(&iter_array,
> >> +                             "DST",
> >> +                             DBUS_TYPE_UINT32,
> >> +                             &ntd->nw_time.dst);
> >> +     dbus_message_iter_close_container(&iter, &iter_array);
> >> +     return 0;
> >> +}
> >
> > Are the time zone offset and the DST always available, but the current =
time
> > not? This seems odd.
> =

> Tell me about it, but this is how the spec works. Operators have the
> flexibility to send just the timezone, the timezone and DST, or the
> works.

I suppose Remi means that if the DST and time zone are optional we should a=
t least
verify that those fields are part of the MM/GMM message. Specs 24008
states that network may include the following fields to MM information
message: Local time zone, Universal time and local time zone, Network
Daylight Saving Time.

> > Passing the time over D-Bus may cause extra drift/imprecision than we a=
lready
> > have. I wonder if it would make sense to provide not just the current t=
ime but
> > both:
> > - the current time for trivial programs, and
> > - the system boot time (i.e. nw_time - received) for smarter programs;
> >  this value cannot drift.
> =

> I remember we had similar argument in the past with the timed folks,
> which actually resulted in a much more convoluted API... I'm still not
> convinced time drift is a problem, since NITZ itself is accurate to
> the second.
> =

> However, thinking about this, I actually don't see any value in
> providing a human readable time over D-Bus. No application should
> directly ask oFono for time, this is why timed is there to begin with.
> =

> So sending a plain time_t over D-Bus is actually sufficient. This
> leaves us with having to send timestamps over D-Bus, which is ugly.
> Can you explain how you see clock drift a problem here exactly?

I wonder what is drifting since the reception time is updated only when
network indicates new time. While polling time, the correction is
calculated with respect to this reception time. The exactness of the
network time is questionable anyway since the network delivers the time
which may have been when the information was sent. Accuracy is of the
order of minutes rather that seconds.

> =

> >> +static DBusMessage *create_time_changed_signal(
> >> +                     struct ofono_nettime_context *context)
> >> +{
> >> +     DBusMessage *signal;
> >> +     struct nettime_data *ntd =3D context->data;
> >> +     const char *path =3D ofono_modem_get_path(context->modem);
> >> +
> >> +     if (path =3D=3D NULL) {
> >> +             ofono_error("Fetching path for modem failed");
> >> +             return NULL;
> >> +     }
> >> +
> >> +     signal =3D dbus_message_new_signal(path, OFONO_NETWORK_TIME_INTE=
RFACE,
> >> +                                     "NetworkTimeChanged");
> >> +     fill_time_changed_signal(signal, ntd);
> >> +
> >> +     return signal;
> >> +}
> >> +
> >> +static void init_time(struct ofono_nettime_context *context)
> >> +{
> >> +     struct nettime_data *nettime_data;
> >> +     context->data =3D g_try_new0(struct nettime_data, 1);
> >
> > Hmm, if you don't check the result, I suspect you should g_new0() inste=
ad.
> =

> Good point.
> =

> >> +     nettime_data =3D context->data;
> >> +     nettime_data->nw_time.year =3D -1;
> >> +}
> >> +
> >> +static int nettime_probe(struct ofono_nettime_context *context)
> >> +{
> >> +     ofono_debug("Network Time Probe for modem: %p", context->modem);
> >> +
> >> +     init_time(context);
> >> +
> >> +     nettime_register(context);
> >> +     return 0;
> >> +}
> >> +
> >> +static void nettime_remove(struct ofono_nettime_context *context)
> >> +{
> >> +     DBusConnection *conn;
> >> +     const char *path;
> >> +
> >> +     ofono_debug("Network Time Remove for modem: %p", context->modem);
> >> +
> >> +     g_free(context->data);
> >> +
> >> +     conn =3D ofono_dbus_get_connection();
> >> +     path =3D ofono_modem_get_path(context->modem);
> >> +
> >> +     if (!g_dbus_unregister_interface(conn,
> >> +                                     path,
> >> +                                     OFONO_NETWORK_TIME_INTERFACE))
> >> +             ofono_error("Could not unregister %s interface",
> >> +                             OFONO_NETWORK_TIME_INTERFACE);
> >> +
> >> +     ofono_modem_remove_interface(context->modem,
> >> +                     OFONO_NETWORK_TIME_INTERFACE);
> >> +}
> >> +
> >> +static void nettime_info_received(struct ofono_nettime_context *conte=
xt,
> >> +                             struct ofono_network_time *info)
> >> +{
> >> +     DBusMessage *nt_signal;
> >> +     struct nettime_data *ntd =3D context->data;
> >> +
> >> +     if (info =3D=3D NULL)
> >> +             return;
> >> +
> >> +     ofono_debug("Received a network time notification on modem: %p",
> >> +                     context->modem);
> >> +
> >> +     ntd->nw_time =3D *info;
> >> +     ntd->received =3D get_monotonic_time();
> >
> > That works. But I would do the gmtime() conversion here, and store the =
result
> > once and for all, instead of copying the raw data and recompute the con=
version
> > every time.
> =

> Sounds good.
> =

> Also, should use memcpy() for the info above.

Thanks for the comments.

-Antti



--===============3836481436249671327==--

