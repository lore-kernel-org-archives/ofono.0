Content-Type: multipart/mixed; boundary="===============7548738331124329914=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Fri, 10 Dec 2010 13:26:27 -0800
Message-ID: <1292016387.4927.51.camel@dardoyle-desktop>
In-Reply-To: <4D00951B.2080702@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7548738331124329914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

Thank you for reviewing this series of patches. We shall submit new
versions according to your comments. Please find any other clarifying
points inline.

On Thu, 2010-12-09 at 09:36 +0100, ext Denis Kenzior wrote:

> > +
> > +static void voicecall_set_call_status(struct ofono_cdma_voicecall_mana=
ger *vc,
> > +             enum cdma_call_status status)
> > +{
> > +     DBusConnection *conn =3D ofono_dbus_get_connection();
> > +     const char *path;
> > +     const char *status_str;
> > +     enum cdma_call_status old_status;
> > +
> > +     if (vc->status =3D=3D status)
> > +             return;
> > +
> > +     old_status =3D vc->status;
> > +
> > +     vc->status =3D status;
> > +
> > +     status_str =3D cdma_call_status_to_string(status);
> > +     path =3D voicecall_build_path(vc);
> > +
> > +     ofono_dbus_signal_property_changed(conn, path,
> > +                                     OFONO_CDMA_VOICECALL_MANAGER_INTE=
RFACE,
> > +                                     "State", DBUS_TYPE_STRING,
> > +                                     &status_str);
> > +
> > +     if (status =3D=3D CDMA_CALL_STATUS_ACTIVE &&
> > +                     old_status =3D=3D CDMA_CALL_STATUS_DIALING) {
> > +             const char *timestr;
> > +
> > +             vc->start_time =3D time(NULL);
> > +             timestr =3D time_to_str(&vc->start_time);
> =

> So in GSM we only timestamp the call once it moves to the active state.
>  Do you really want to timestamp it in the dialing stage?

I'm not sure what you mean here? We are carrying out the timestamp when
the status is active having previously been dialing in a similar way to
GSM. =

In this patch, setting of the state to active is not supported yet due
to our current hardware limitations, so the time implementation has been
provided but is untested. If you would prefer us to remove the
timestamping altogether from this patch, we can do?

> =

> > +
> > +             ofono_dbus_signal_property_changed(conn, path,
> > +                                     OFONO_CDMA_VOICECALL_MANAGER_INTE=
RFACE,
> > +                                     "StartTime", DBUS_TYPE_STRING,
> > +                                     &timestr);
> > +     }
> > +}
> > +
> > +static void voicecall_set_call_lineid(struct ofono_cdma_voicecall_mana=
ger *v)
> > +{
> > +     DBusConnection *conn =3D ofono_dbus_get_connection();
> > +     const char *path;
> > +     const char *lineid_str;
> > +
> > +     path =3D voicecall_build_path(v);
> > +
> > +     /* For MO calls, LineID is the dialed phone number */
> > +     lineid_str =3D cdma_phone_number_to_string(&v->phone_number);
> > +
> > +     ofono_dbus_signal_property_changed(conn, path,
> > +                                     OFONO_CDMA_VOICECALL_MANAGER_INTE=
RFACE,
> > +                                     "LineIdentification",
> > +                                     DBUS_TYPE_STRING, &lineid_str);
> > +}
> > +
> > +static void manager_dial_callback(const struct ofono_error *error, voi=
d *data)
> > +{
> > +     struct ofono_cdma_voicecall_manager *vc =3D data;
> > +     DBusMessage *reply;
> > +
> > +     if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > +             reply =3D __ofono_error_failed(vc->pending);
> > +     } else {
> > +             const char *path =3D voicecall_build_path(vc);
> =

> what path are you returning here?  This is not in the API proposal...

This was an oversight, thank you for catching it- I will remove this.

> =

> > +
> > +             reply =3D dbus_message_new_method_return(vc->pending);
> > +
> > +             dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &p=
ath,
> > +                                             DBUS_TYPE_INVALID);
> > +     }
> =

> In general the preferred style is:
> =

> if (foo) {
>         bar
> } else
>         blah
> =

> > +
> > +     __ofono_dbus_pending_reply(&vc->pending, reply);
> > +}
> > +
> > +static DBusMessage *voicecall_manager_dial(DBusConnection *conn,
> > +                                     DBusMessage *msg, void *data)
> > +{
> > +     struct ofono_cdma_voicecall_manager *vc =3D data;
> > +     const char *number;
> > +
> > +     if (vc->pending)
> > +             return __ofono_error_busy(msg);
> > +
> > +     if (vc->status !=3D CDMA_CALL_STATUS_DISCONNECTED)
> > +             return __ofono_error_failed(msg);
> > +
> > +     if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
> > +                                     DBUS_TYPE_INVALID) =3D=3D FALSE)
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     if (!valid_cdma_phone_number_format(number))
> > +             return __ofono_error_invalid_format(msg);
> > +
> > +     if (vc->driver->dial =3D=3D NULL)
> > +             return __ofono_error_not_implemented(msg);
> > +
> > +     vc->pending =3D dbus_message_ref(msg);
> > +
> > +     string_to_cdma_phone_number(number, &vc->phone_number);
> > +     voicecall_set_call_lineid(vc);
> > +     vc->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
> > +     voicecall_set_call_status(vc, CDMA_CALL_STATUS_DIALING);
> > +     vc->driver->dial(vc, &vc->phone_number, manager_dial_callback, vc=
);
> > +
> =

> What are the expectations on how the dial works?
> =

> e.g. in GSM we don't create the call until after the dial returns.
> Normally this works this way:
> =

> ---> ATD
> <--- OK
> State Dialing
> State Alerting
> State Connected
> =

> Does CDMA work in the same manner?
> =

> My other concern here is that you set the call status, line id, etc but
> never reset them if the dial fails...

Thank you, yes CDMA dial does work in the same way as GSM essentially. I
shall move the call creation into the manager_dial_callback method, to
be executed upon a successful return from the dial.
Support for other call state support will come through with the future
work for call state transitions.

> >
> > +const char *cdma_phone_number_to_string(
> > +                     const struct ofono_cdma_phone_number *ph)
> > +{
> > +     static char buffer[OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH + 1];
> > +
> > +     strncpy(buffer, ph->number, OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH);
> > +     buffer[OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH] =3D '\0';
> > +
> > +     return buffer;
> > +}
> > +
> > +void string_to_cdma_phone_number(const char *str,
> > +                     struct ofono_cdma_phone_number *ph)
> > +{
> > +     strcpy(ph->number, str);
> =

> Do we have international '+' prefix in CDMA?
> =

Sometimes. If the CDMA networks support network based plus code dialing
then '+' can be used to replace the international direct dial prefix. =

Our intention is to support international dialing with future work.

Cheers
Dara



--===============7548738331124329914==--

