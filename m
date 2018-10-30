Content-Type: multipart/mixed; boundary="===============1231128353597851156=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Tue, 30 Oct 2018 07:10:15 +0100
Message-ID: <CAKSBH7Eec39PwwKuyyW3MSc-n2XF79SMhS-_cN2EPTK97EvMsA@mail.gmail.com>
In-Reply-To: <e2f340cd-cc8c-fe45-2bd8-ee402d4bf23a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1231128353597851156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for taking the time to look into this.

On Mon, Oct 29, 2018 at 8:58 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/26/2018 01:10 AM, Giacinto Cifelli wrote:
> > I would like to submit to your attention the new version of the Gemalto
> > plugin. It is not ready, but would already benefit from some feedback.
> > The purpose of this new plugin is to address most of the Gemalto modules
> > (excluding perhaps some LTE CatM and CatNB), interfaced either via USB
> > or RS232 interface.
>
> So just a cursory look through this, but overall my impression is that
> this code would be utterly unmaintainable.  You need to split this up
> into something without a bazillion if conditions and #ifdefs in it.
> Notice how none of our existing driver code uses #ifdefs.

In your existing code, there are a few models from each vendor,
partially supported, with hardcoded choices for several options.

>
> That means MBIM/QMI/AT logic needs to be separated into separate
> drivers.  If you have a weird QMI/AT or MBIM/AT or QMI over MBIM
> combination stuff going on, then these all need to be separate drivers.
>

Several modems are either qmi+at or mbim+at, while others are simply
at (for example with ppp, ecm, ncm networking).

The qmi and mbim part is limited to initialization and gprs-context,
the rest is common.
Shall I duplicate everything for this?

The #ifdefs are a choice of the project for the ELL, otherwise it
would be simply, well-integrated ifs (like for qmi).
I understand that the use of ELL will be extended in the future, why
not go all the way, remove the #ifdefs, and declare a full dependency?

> You may want to basically start with the basics.  Get the initial driver
> separation figured out, then you can add fancy stuff like vendor
> specific APIs, etc.  Right now they just clutter the code and are not
> really useful to a wide audience anyway.

Yes

> > +
> > +     /* mbim data */
> > +     uint16_t max_segment;
> > +     uint8_t max_outstanding;
> > +     uint8_t max_sessions;
> > +
>
> The mbim plugin is not sufficient for this?
>

there are no mbim-only gemalto modems, only mbim+at.
And so, it is not suffient, I had to duplicate all this.

> > +
> > +static const char *gemalto_get_string(struct ofono_modem *modem, const=
 char *k)
> > +{
> > +     const char *v;
> > +
> > +     if (!modem || !k || !*k)
> > +             return NULL;
> > +
> > +     v =3D ofono_modem_get_string(modem, k);
> > +
> > +     if (!v || !*v)
> > +             return NULL;
> > +
> > +     return v;
> > +}
>
> Uhh, why?

to have a simple compare for !var in the code. Because it is not
possible to remove a variable once set, only to set it to an empty
string.
Maybe I should add instead an ofono_modem_unset_string ?

> > +static void gemalto_exec_stored_cmd(struct ofono_modem *modem,
> > +                                                     const char *filen=
ame)
> > +{
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +     const char *vid =3D gemalto_get_string(modem, "Vendor");
> > +     const char *pid =3D gemalto_get_string(modem, "Model");
> > +     char store[64];
> > +     int index;
> > +     char *command, *prompt, *argument;
> > +     char key[32];
> > +     GKeyFile *f;
> > +
> > +     sprintf(store,"%s-%s/%s", vid, pid, filename);
> > +     f =3D storage_open(NULL, store);
> > +
> > +     if (!f)
> > +             return;
> > +
> > +     for (index =3D 0; ; index++) {
> > +             sprintf(key, "command_%d", index);
> > +             command =3D g_key_file_get_string(f, "Simple", key, NULL);
> > +
> > +             if (!command)
> > +                     break;
> > +
> > +             DBG(REDCOLOR"executing stored command simple: %s"NOCOLOR,=
 command);
> > +             g_at_chat_send(data->app, command, NULL, NULL, NULL, NULL=
);
> > +     }
> > +
> > +     for (index =3D 0; ; index++) {
> > +             sprintf(key, "command_%d", index);
> > +             command =3D g_key_file_get_string(f, "WithPrompt", key, N=
ULL);
> > +             sprintf(key, "prompt_%d", index);
> > +             prompt =3D g_key_file_get_string(f, "WithPrompt", key, NU=
LL);
> > +             sprintf(key, "argument_%d", index);
> > +             argument =3D g_key_file_get_string(f, "WithPrompt", key, =
NULL);
> > +
> > +             if (!command || !prompt || !argument)
> > +                     break;
> > +
> > +             DBG("executing stored command with prompt: %s", command);
> > +             executeWithPrompt(data->app, command, prompt, argument,
> > +                     NULL, NULL, NULL);
> > +     }
> > +
> > +     storage_close(NULL, store, f, FALSE);
> > +}
>
> What is this doing actually?

Reading stored commands and executing them.
It is intended to configure the modem for a specific application.
There are hooks for each state of the modem state machine.

There isn't much interest in passing these commands through an
interface, because each application has its own configuration and
sends a different set of commands.
And it is modem-specific, so  it is stored by USB VID-PID.

> > +/*********************************************************************=
**********
> > + * Time services interface
> > + *********************************************************************=
*********/
> > +
> > +#define GEMALTO_NITZ_TIME_INTERFACE OFONO_SERVICE ".gemalto.TimeServic=
es"
> > +
> > +static DBusMessage *set_modem_datetime(DBusConnection *conn,
> > +                                                     DBusMessage *msg,
> > +                                                     void *modem)
> > +{
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +     time_t t =3D time(NULL);
> > +     struct tm tm;
> > +     gchar cclk_cmd[32];
> > +
> > +     /* Set date and time */
> > +     tm =3D *localtime(&t);
> > +     strftime(cclk_cmd, 32, "AT+CCLK=3D\"%y/%m/%d,%T\"", &tm);
> > +     g_at_chat_send(data->app, cclk_cmd, none_prefix, NULL, NULL, NULL=
);
> > +     return dbus_message_new_method_return(msg);
> > +}
> > +
> > +static const GDBusMethodTable gsmTime_methods[] =3D {
> > +     { GDBUS_ASYNC_METHOD("SetModemDatetime",
> > +                     NULL, NULL, set_modem_datetime) },
> > +     {}
> > +};
> > +
>
> So first question is, why would you want to do this?  These days most
> systems use the time on the Application processor.  Who cares what the
> modem thinks the time is.

Some systems care: this comes in fact from an application (and will be
committed mentioning a co-author).
And it helps for timestamps in case of stack logs.

>
> Secondly, why not do this as an actual core atom?

Not sure of the general interest, but yes can do.

>
> > +static const GDBusSignalTable gsmTime_signals[] =3D {
> > +     { GDBUS_SIGNAL("NitzUpdated",
> > +                     GDBUS_ARGS({ "time", "a{sv}" }) )},
> > +     {}
> > +};
>
> You don't like ofono_netreg_time_notify?

I will look into this.

>
> > +
> > +static void gemalto_time_enable(struct ofono_modem *modem)
> > +{
> > +     DBusConnection *conn =3D ofono_dbus_get_connection();
> > +     const char *path =3D ofono_modem_get_path(modem);
> > +
> > +     if (!g_dbus_register_interface(conn, path,
> > +                                     GEMALTO_NITZ_TIME_INTERFACE,
> > +                                     gsmTime_methods,
> > +                                     gsmTime_signals,
> > +                                     NULL,
> > +                                     modem,
> > +                                     NULL)) {
> > +             ofono_error("Could not register %s interface under %s",
> > +                                     GEMALTO_NITZ_TIME_INTERFACE, path=
);
> > +             return;
> > +     }
> > +
> > +     ofono_modem_add_interface(modem, GEMALTO_NITZ_TIME_INTERFACE);
> > +}
> > +
> > +/*********************************************************************=
**********
> > + * Command passtrhough interface
> > + *********************************************************************=
*********/
> > +
> > +#define COMMAND_PASSTHROUGH_INTERFACE OFONO_SERVICE ".gemalto.CommandP=
assthrough"
> > +
>
> No AT command pass through in oFono upstream ;)  We've had this
> conversation many times, if there are useful AT commands that can be
> sent via this interface, then they should be abstracted behind a proper
> API instead.

I may have misunderstood your comments the one time we had the conversation.
I don't understand your blind refusal: cluttering the interface with
every single command that an application may need for some special
events doesn't seem that brilliant.

> > +/*********************************************************************=
**********
> > + * GNSS interface
> > + *********************************************************************=
*********/
> > +
> > +#define GNSS_INTERFACE OFONO_SERVICE ".gemalto.GNSS"
> > +
> > +static void gnss_get_properties_cb(gboolean ok, GAtResult *result,
> > +                                                     gpointer user_dat=
a)
> > +{
> > +     struct ofono_modem *modem =3D user_data;
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +     const char *port =3D ofono_modem_get_string(modem, "GNSS");
> > +     GAtResultIter iter;
> > +     DBusMessage *reply;
> > +     DBusMessageIter dbusiter;
> > +     DBusMessageIter dict;
> > +
> > +     if (data->gnss_msg =3D=3D NULL)
> > +             return;
> > +
> > +     if (!ok)
> > +             goto error;
> > +
> > +     reply =3D dbus_message_new_method_return(data->gnss_msg);
> > +     dbus_message_iter_init_append(reply, &dbusiter);
> > +     dbus_message_iter_open_container(&dbusiter, DBUS_TYPE_ARRAY,
> > +                                     OFONO_PROPERTIES_ARRAY_SIGNATURE,
> > +                                     &dict);
> > +     g_at_result_iter_init(&iter, result);
> > +
> > +     /* supported format: ^SGPSC: "Nmea/Output","off" */
> > +     while (g_at_result_iter_next(&iter, "^SGPSC:")) {
> > +             const char *name =3D "";
> > +             const char *val =3D "";
> > +
> > +             if (!g_at_result_iter_next_string(&iter, &name))
> > +                     continue;
> > +
> > +             /*
> > +              * skip the "Info" property:
> > +              * different line format and different usage
> > +              */
> > +             if (g_str_equal(name,"Info"))
> > +                     continue;
> > +
> > +             if (!g_at_result_iter_next_string(&iter, &val))
> > +                     continue;
> > +
> > +             ofono_dbus_dict_append(&dict, name, DBUS_TYPE_STRING, &va=
l);
> > +     }
> > +
> > +     ofono_dbus_dict_append(&dict, "Port", DBUS_TYPE_STRING, &port);
> > +     dbus_message_iter_close_container(&dbusiter, &dict);
> > +     __ofono_dbus_pending_reply(&data->gnss_msg, reply);
> > +     return;
> > +
> > +error:
> > +     __ofono_dbus_pending_reply(&data->gnss_msg,
> > +                     __ofono_error_failed(data->gnss_msg));
> > +}
> > +
> > +static DBusMessage *gnss_get_properties(DBusConnection *conn,
> > +                                     DBusMessage *msg, void *user_data)
> > +{
> > +     struct ofono_modem *modem =3D user_data;
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +
> > +     if (data->gnss_msg !=3D NULL)
> > +             return __ofono_error_busy(msg);
> > +
> > +     if (!g_at_chat_send(data->app, "AT^SGPSC?", sgpsc_prefix,
> > +                                     gnss_get_properties_cb, modem, NU=
LL))
> > +             return __ofono_error_failed(msg);
> > +
> > +     data->gnss_msg =3D dbus_message_ref(msg);
> > +
> > +     return NULL;
> > +}
> > +
> > +static void gnss_set_properties_cb(gboolean ok, GAtResult *result,
> > +                                                     gpointer user_dat=
a)
> > +{
> > +     struct ofono_modem *modem =3D user_data;
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +     DBusMessage *reply;
> > +
> > +     if (data->gnss_msg =3D=3D NULL)
> > +             return;
> > +
> > +     if (!ok) {
> > +             __ofono_dbus_pending_reply(&data->gnss_msg,
> > +                                     __ofono_error_failed(data->gnss_m=
sg));
> > +             return;
> > +     }
> > +
> > +     reply =3D dbus_message_new_method_return(data->gnss_msg);
> > +     __ofono_dbus_pending_reply(&data->gnss_msg, reply);
> > +}
> > +
> > +static DBusMessage *gnss_set_property(DBusConnection *conn,
> > +                                     DBusMessage *msg, void *user_data)
> > +{
> > +     struct ofono_modem *modem =3D user_data;
> > +     struct gemalto_data *data =3D ofono_modem_get_data(modem);
> > +     DBusMessageIter iter, var;
> > +     const char *name;
> > +     char *value;
> > +     char buf[256];
> > +
> > +     if (data->gnss_msg !=3D NULL)
> > +             return __ofono_error_busy(msg);
> > +
> > +     if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     dbus_message_iter_get_basic(&iter, &name);
> > +     dbus_message_iter_next(&iter);
> > +
> > +     if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     dbus_message_iter_recurse(&iter, &var);
> > +
> > +     if (dbus_message_iter_get_arg_type(&var) !=3D
> > +                                     DBUS_TYPE_STRING)
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     dbus_message_iter_get_basic(&var, &value);
> > +
> > +     snprintf(buf, sizeof(buf), "AT^SGPSC=3D\"%s\",\"%s\"", name, valu=
e);
> > +
>
> So the modem is doing the property validation?  Yeah, not happening ;)

The name and number of properties vary by the models.
There isn't much to validate in a general way. Null perhaps, or an
arbitrary maximum length.
This interface is supposed to use GetProperties and then can change
some of them.
That the set property is in the list returned by GetProperties can be verif=
ied.

> Why don't you just configure the device into NMEA mode and use
> location_reporting atom ?

that atom is not compatible with gpsd and takes arbitrary choices on
how to handle the receiver, it is incomplete and adds constrains on
the dbus version.
For example, for the gemalto atom, it starts the engine in
assisted-gps mode, without loading the corresponding data files.


> > +/*
> > + * powersave for older modules:
> > + *   command_0=3DAT+CFUN=3D7
> > + * return:
> > + *   command_0=3DAT+CFUN=3D1
> > + *
> > + * powersave example for modules with GNSS (could also only stop the o=
utput):
> > + *   command_0=3DAT+CREG=3D0
> > + *   command_1=3DAT+CGREG=3D0
> > + *   command_2=3DAT+CEREG=3D0
> > + *   command_3=3DAT^SGPSC=3D"Engine","0"
> > + *   command_4=3DAT^SGPSC=3D"Power/Antenna","off"
> > + * return:
> > + *   command_0=3DAT+CREG=3D2
> > + *   command_1=3DAT+CGREG=3D2
> > + *   command_2=3DAT+CEREG=3D2
> > + *   command_4=3DAT^SGPSC=3D"Power/Antenna","on"
> > + *   command_3=3DAT^SGPSC=3D"Engine","1"
> > + */
>
> How is 'powersave' useful?

If you go on holiday for 1 week, you may like that your car still
starts when you come back.
The modem in this kind of applications is always on, for anti-theft of
simply so that you can blink the lights when coming out of a
supermarket.
But when parked, the modem remains listening for network events, and
only ping the application (and ofono) in case of sms, for example (up
to the specific application how to come back from sleep).
Above, a common setting: no reg events (if we lose coverage we don't
react instead of re-powering) and stop the gnss engine.

> > +
> > +#ifdef HAVE_ELL
> > +static int mbim_parse_descriptors(struct gemalto_data *md, const char =
*file)
>
> Why is MBIM driver not enough?

for this yes, pure duplication. It would be good to have this code in
an atom or in common.c or similar.
Otherwise, all Gemalto modems are MBIM+AT, so the pure mbim is not enough.

> > +
> > +static void gemalto_remove(struct ofono_modem *modem)
> > +{
> > +     struct gemalto_data *data;
> > +     DBusConnection *conn =3D ofono_dbus_get_connection();
> > +     const char *path;
> > +
> > +     if (!modem)
> > +             return;
> > +
> > +     data =3D ofono_modem_get_data(modem);
> > +     path =3D ofono_modem_get_path(modem);
> > +
> > +     if (!data)
> > +             return;
> > +
> > +#ifdef HAVE_ELL
> > +     if (data->mbim =3D=3D STATE_PRESENT) {
> > +             mbim_device_shutdown(data->device);
> > +     }
> > +#endif
> > +
> > +     if (data->qmi =3D=3D STATE_PRESENT) {
> > +             qmi_device_unref(data->device);
> > +     }
> > +
>
> No, we're not doing MBIM/QMI/AT all in one driver.  These should
> basically be 3 different drivers or merged into plugins/mbim
> plugins/gobi or whatever.

again, the modems are all mixed-mode with AT.
To support them properly, I need both views.
But there is no mbim+qmi combination.

Is there a way to support mbim+at today?
What do you suggest?

Regards,
Giacinto

--===============1231128353597851156==--

