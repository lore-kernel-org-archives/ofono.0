Content-Type: multipart/mixed; boundary="===============3532244430241947180=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v6 1/1] lte: protocol and authentication for default
 ctx
Date: Thu, 18 Oct 2018 09:50:38 +0200
Message-ID: <CAKSBH7H2dSnq-27uYbGSiUFt4+OAfoh_HEq1Dw-7gdy_Ye4sLg@mail.gmail.com>
In-Reply-To: <ec6678c6-405b-8e60-87fc-52c2567cfc97@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3532244430241947180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 16, 2018 at 9:17 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/13/2018 02:34 AM, Giacinto Cifelli wrote:
> > Many LTE networks require user authentication, even for the default
> > context. In particular, most of the private APNs use this facility
> > to add some control on top of the MNO providing the service, so that
> > another user of the same network cannot access the private one.
> > As such, we add these parameters to the default context
> > settings that will attempt to use when registering to the network.
> >
> > The additional parameters added by this patch are:  protocol, user, and
> > password.  These are sufficient to allow to connect to networks
> > available to the patch author where ofono previously failed to register
> > to the network at all.
> >
> > Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
> > ---
> >   src/lte.c | 241 +++++++++++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 185 insertions(+), 56 deletions(-)
> >
>
> So I'm fine with the overall approach taken here, but the actual
> implementation still has issues:
>
> >   static void lte_set_default_attach_info_cb(const struct ofono_error *=
error,
> > -                                             void *data)
> > +                                                             void *dat=
a)
> >   {
> >       struct ofono_lte *lte =3D data;
> >       const char *path =3D __ofono_atom_get_path(lte->atom);
> >       DBusConnection *conn =3D ofono_dbus_get_connection();
> >       DBusMessage *reply;
> > -     const char *apn =3D lte->info.apn;
> > +     const char *propstr =3D NULL;
> > +     char *key =3D g_strdup(lte->key);
>
> I'd do this differently:
>
> >
> >       DBG("%s error %d", path, error->type);
> >
>
> char *key;
> char *value;
> const char *str;
> DBusMessageIter iter;
> DbusMessageIter var;
>
> ....
>
> // No error checking needed since we already validated pending:
>
> dbus_message_iter_init(lte->pending, &iter);
> dbus_message_iter_get_basic(&iter, &str);
> key =3D strdup(str);
>
> dbus_message_iter_next(&iter);
> dbus_message_iter_recurse(&iter, &var);
> dbus_message_iter_get_basic(&var, &str);
> value =3D strdup(str);
>
> > @@ -118,55 +174,68 @@ static void lte_set_default_attach_info_cb(const =
struct ofono_error *error,
> >               return;
> >       }
> >
> > -     g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > -                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +     if (!g_str_equal(lte->pending_info.apn, lte->info.apn)) {
> > +             g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > +                                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +             propstr =3D lte->info.apn;
> > +     } else if (lte->pending_info.proto !=3D lte->info.proto) {
> > +             lte->info.proto =3D lte->pending_info.proto;
> > +             key =3D LTE_PROTO;
> > +             propstr =3D gprs_proto_to_string(lte->info.proto);
> > +     } else if (lte->pending_info.auth_method !=3D lte->info.auth_meth=
od) {
> > +             lte->info.auth_method =3D lte->pending_info.auth_method;
> > +             propstr =3D gprs_auth_method_to_string(lte->info.auth_met=
hod);
> > +
> > +     } else if (!g_str_equal(lte->pending_info.username,
> > +                                                     lte->info.usernam=
e)) {
> > +             g_strlcpy(lte->info.username, lte->pending_info.username,
> > +                                     OFONO_GPRS_MAX_USERNAME_LENGTH + =
1);
> > +             propstr =3D lte->info.username;
> > +     } else if (!g_str_equal(lte->pending_info.password,
> > +                                                     lte->info.passwor=
d)) {
> > +             g_strlcpy(lte->info.password, lte->pending_info.password,
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH + =
1);
> > +             propstr =3D lte->info.password;
> > +     } else {
> > +             /*
> > +              * this should never happen, because no property change is
> > +              * checked before.
> > +              * Neverthelss, in this case it will answer the D-Bus mes=
sage
> > +              * but emit no signal
> > +              */
> > +             ofono_error("unexpected property change: ignored");
> > +             g_free(key);
> > +             key =3D NULL;
> > +     }
>
> Get rid of this entire if/else block and simply do:
>
> memcpy(&lte->info, &lte->pending_info, sizeof(lte->info));

this I like particularly.

>
> > +
> > +     reply =3D dbus_message_new_method_return(lte->pending);
> > +     __ofono_dbus_pending_reply(&lte->pending, reply);
> > +
> > +     if(!key)
> > +             return;
> >
> >       if (lte->settings) {
> > -             if (strlen(lte->info.apn) =3D=3D 0)
> > -                     /* Clear entry on empty APN. */
> > -                     g_key_file_remove_key(lte->settings, SETTINGS_GRO=
UP,
> > -                                             DEFAULT_APN_KEY, NULL);
> > +             /*
> > +              * the following code removes from storage empty APN, use=
r, pwd
> > +              * for proto and auth_method, given that they always
> > +              * have defaults, it will not do anything.
> > +              */
> > +             if (!*propstr)
> > +                     /* Clear entry on empty string. */
> > +                     g_key_file_remove_key(lte->settings,
> > +                             SETTINGS_GROUP, key, NULL);
> >               else
> > -                     g_key_file_set_string(lte->settings, SETTINGS_GRO=
UP,
> > -                                             DEFAULT_APN_KEY, lte->inf=
o.apn);
> > +                     g_key_file_set_string(lte->settings,
> > +                             SETTINGS_GROUP, key, propstr);
> >
> >               storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
> >       }
> >
> > -     reply =3D dbus_message_new_method_return(lte->pending);
> > -     __ofono_dbus_pending_reply(&lte->pending, reply);
> > -
> >       ofono_dbus_signal_property_changed(conn, path,
> >                                       OFONO_CONNECTION_CONTEXT_INTERFAC=
E,
> > -                                     DEFAULT_APN_KEY,
> > -                                     DBUS_TYPE_STRING, &apn);
>
> g_free(value);
>
> > -}
> > -
> > -static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
> > -                             DBusConnection *conn, DBusMessage *msg,
> > -                             const char *apn)
> > -{
> > -     if (lte->driver->set_default_attach_info =3D=3D NULL)
> > -             return __ofono_error_not_implemented(msg);
> > -
> > -     if (lte->pending)
> > -             return __ofono_error_busy(msg);
> > -
> > -     if (g_str_equal(apn, lte->info.apn))
> > -             return dbus_message_new_method_return(msg);
> > -
> > -     /* We do care about empty value: it can be used for reset. */
> > -     if (is_valid_apn(apn) =3D=3D FALSE && apn[0] !=3D '\0')
> > -             return __ofono_error_invalid_format(msg);
> > -
> > -     lte->pending =3D dbus_message_ref(msg);
> > -
> > -     g_strlcpy(lte->pending_info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH +=
 1);
> > -
> > -     lte->driver->set_default_attach_info(lte, &lte->pending_info,
> > -                                     lte_set_default_attach_info_cb, l=
te);
> > -
> > -     return NULL;
> > +                                     key,
> > +                                     DBUS_TYPE_STRING, &propstr);
> > +     g_free(key);
> >   }
> >
> >   static DBusMessage *lte_set_property(DBusConnection *conn,
> > @@ -177,6 +246,14 @@ static DBusMessage *lte_set_property(DBusConnectio=
n *conn,
> >       DBusMessageIter var;
> >       const char *property;
> >       const char *str;
> > +     enum ofono_gprs_auth_method auth_method;
> > +     enum ofono_gprs_proto proto;
> > +
> > +     if (lte->driver->set_default_attach_info =3D=3D NULL)
> > +             return __ofono_error_not_implemented(msg);
> > +
> > +     if (lte->pending)
> > +             return __ofono_error_busy(msg);
> >
>
> So you may want to do:
>
> memcpy(&lte->pending_info, &lte->info, sizeof(lte->info));
>
> >       if (!dbus_message_iter_init(msg, &iter))
> >               return __ofono_error_invalid_args(msg);
> > @@ -192,16 +269,68 @@ static DBusMessage *lte_set_property(DBusConnecti=
on *conn,
> >
> >       dbus_message_iter_recurse(&iter, &var);
> >
> > -     if (!strcmp(property, DEFAULT_APN_KEY)) {
> > -             if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_S=
TRING)
> > -                     return __ofono_error_invalid_args(msg);
> > +     if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
> > +             return __ofono_error_invalid_args(msg);
> >
> > -             dbus_message_iter_get_basic(&var, &str);
> > +     dbus_message_iter_get_basic(&var, &str);
> >
> > -             return lte_set_default_apn(lte, conn, msg, str);
> > -     }
> > +     if ((strcmp(property, LTE_APN) =3D=3D 0)) {
> > +
> > +             if (g_str_equal(str, lte->info.apn))
> > +                     return dbus_message_new_method_return(msg);
> > +
> > +             /* We do care about empty value: it can be used for reset=
. */
> > +             if (is_valid_apn(str) =3D=3D FALSE && str[0] !=3D '\0')
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +             g_strlcpy(lte->pending_info.apn, str,
> > +                                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +
> > +     } else if ((strcmp(property, LTE_PROTO) =3D=3D 0)) {
> > +
> > +             if (!gprs_proto_from_string(str, &proto))
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +             if (proto =3D=3D lte->info.proto)
> > +                     return dbus_message_new_method_return(msg);
> > +
> > +             lte->pending_info.proto =3D proto;
> >
> > -     return __ofono_error_invalid_args(msg);
> > +     } else if (strcmp(property, LTE_AUTH_METHOD) =3D=3D 0) {
> > +
> > +             if (!gprs_auth_method_from_string(str, &auth_method))
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +             if (auth_method =3D=3D lte->info.auth_method)
> > +                     return dbus_message_new_method_return(msg);
> > +
> > +             lte->pending_info.auth_method =3D auth_method;
> > +
> > +     } else if (strcmp(property, LTE_USERNAME) =3D=3D 0) {
> > +
> > +             if (g_str_equal(str, lte->info.username))
> > +                     return dbus_message_new_method_return(msg);
> > +
> > +             g_strlcpy(lte->pending_info.username, str,
> > +                                     OFONO_GPRS_MAX_USERNAME_LENGTH + =
1);
> > +
> > +     } else if (strcmp(property, LTE_PASSWORD) =3D=3D 0) {
> > +
> > +             if (g_str_equal(str, lte->info.password))
> > +                     return dbus_message_new_method_return(msg);
> > +
> > +             g_strlcpy(lte->pending_info.password, str,
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH + =
1);
> > +
> > +     } else
> > +             return __ofono_error_invalid_args(msg);
> > +
> > +     lte->key =3D property;
>
> And this isn't needed.  Or alternatively store both the key and value
> being set to in ofono_lte.  But I much prefer just parsing the message
> again.
>
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     lte->driver->set_default_attach_info(lte, &lte->pending_info,
> > +                                     lte_set_default_attach_info_cb, l=
te);
> > +
> > +     return NULL;
> >   }
> >
> >   static const GDBusMethodTable lte_methods[] =3D {
> >
>
> Regards,
> -Denis

I have changed my code according to your suggestions and retested
(with the Gemalto atom).

Regards,
Giacinto

--===============3532244430241947180==--

