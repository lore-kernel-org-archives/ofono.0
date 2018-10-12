Content-Type: multipart/mixed; boundary="===============1938596795972118627=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 3/6] src/lte: added proto and authentication handling
Date: Fri, 12 Oct 2018 04:57:41 +0200
Message-ID: <CAKSBH7E-FUbo-JB7FH9Xw8TjUg=qDPLC3WzdVPHjC_9OaK_1zA@mail.gmail.com>
In-Reply-To: <56bbb99c-7076-7534-72d9-672eea1e44f1@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1938596795972118627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 11, 2018 at 10:07 PM Jonas Bonn <jonas@southpole.se> wrote:
>
> Hi,
>
>
> On 10/10/18 08:54, Giacinto Cifelli wrote:
> > ---
> >   src/lte.c | 242 +++++++++++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 186 insertions(+), 56 deletions(-)
> >
> > diff --git a/src/lte.c b/src/lte.c
> > index 23fe8e1c..2412fcec 100644
> > --- a/src/lte.c
> > +++ b/src/lte.c
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2016  Endocode AG. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
> >    *
> >    *  This program is free software; you can redistribute it and/or mod=
ify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -39,7 +40,11 @@
> >
> >   #define SETTINGS_STORE "lte"
> >   #define SETTINGS_GROUP "Settings"
> > -#define DEFAULT_APN_KEY "DefaultAccessPointName"
> > +#define LTE_APN "DefaultAccessPointName"
> > +#define LTE_PROTO "Protocol"
> > +#define LTE_USERNAME "Username"
> > +#define LTE_PASSWORD "Password"
> > +#define LTE_AUTH_METHOD "AuthenticationMethod"
> >
> >   struct ofono_lte {
> >       const struct ofono_lte_driver *driver;
> > @@ -57,6 +62,10 @@ static GSList *g_drivers =3D NULL;
> >   static void lte_load_settings(struct ofono_lte *lte)
> >   {
> >       char *apn;
> > +     char *proto_str;
> > +     char *auth_method_str;
> > +     char *username;
> > +     char *password;
> >
> >       if (lte->imsi =3D=3D NULL)
> >               return;
> > @@ -69,19 +78,57 @@ static void lte_load_settings(struct ofono_lte *lte)
> >               return;
> >       }
> >
> > -     apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP ,
> > -                                     DEFAULT_APN_KEY, NULL);
> > -     if (apn) {
> > +     apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_APN, NULL);
> > +     proto_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_PROTO, NULL);
> > +     auth_method_str =3D g_key_file_get_string(lte->settings, SETTINGS=
_GROUP,
> > +                             LTE_AUTH_METHOD, NULL);
> > +     username =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_USERNAME, NULL);
> > +     password =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_PASSWORD, NULL);
> > +     if (apn)
> >               strcpy(lte->info.apn, apn);
> > -             g_free(apn);
> > -     }
> > +
> > +     if (proto_str =3D=3D NULL)
> > +             proto_str =3D g_strdup("ip");
> > +
> > +     /* this must have a valid default */
> > +     if (!gprs_proto_from_string(proto_str, &lte->info.proto))
> > +             lte->info.proto =3D OFONO_GPRS_PROTO_IP;
> > +
> > +     if (auth_method_str =3D=3D NULL)
> > +             auth_method_str =3D g_strdup("none");
> > +
> > +     /* this must have a valid default */
> > +     if (!gprs_auth_method_from_string(auth_method_str,
> > +                                                     &lte->info.auth_m=
ethod))
> > +             lte->info.auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> > +
> > +     if (username)
> > +             strcpy(lte->info.username, username);
> > +
> > +     if (password)
> > +             strcpy(lte->info.password, password);
> > +
> > +     g_free(apn);
> > +     g_free(proto_str);
> > +     g_free(auth_method_str);
> > +     g_free(username);
> > +     g_free(password);
> >   }
> >
> >   static DBusMessage *lte_get_properties(DBusConnection *conn,
> >                                       DBusMessage *msg, void *data)
> >   {
> >       struct ofono_lte *lte =3D data;
> > +     const char *proto =3D gprs_proto_to_string(lte->info.proto);
> >       const char *apn =3D lte->info.apn;
> > +     const char* auth_method =3D
> > +                     gprs_auth_method_to_string(lte->info.auth_method);
> > +     const char *username =3D lte->info.username;
> > +     const char *password =3D lte->info.password;
> >       DBusMessage *reply;
> >       DBusMessageIter iter;
> >       DBusMessageIter dict;
> > @@ -95,20 +142,28 @@ static DBusMessage *lte_get_properties(DBusConnect=
ion *conn,
> >       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> >                                       OFONO_PROPERTIES_ARRAY_SIGNATURE,
> >                                       &dict);
> > -     ofono_dbus_dict_append(&dict, DEFAULT_APN_KEY, DBUS_TYPE_STRING, =
&apn);
> > +     ofono_dbus_dict_append(&dict, LTE_APN, DBUS_TYPE_STRING, &apn);
> > +     ofono_dbus_dict_append(&dict, LTE_PROTO, DBUS_TYPE_STRING, &proto=
);
> > +     ofono_dbus_dict_append(&dict, LTE_AUTH_METHOD, DBUS_TYPE_STRING,
> > +                                     &auth_method);
> > +     ofono_dbus_dict_append(&dict, LTE_USERNAME, DBUS_TYPE_STRING,
> > +                                     &username);
> > +     ofono_dbus_dict_append(&dict, LTE_PASSWORD, DBUS_TYPE_STRING,
> > +                                     &password);
> >       dbus_message_iter_close_container(&iter, &dict);
> >
> >       return reply;
> >   }
> >
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
> > +     const char *key;
> > +     const char *propstr =3D NULL;
> >
> >       DBG("%s error %d", path, error->type);
> >
> > @@ -118,55 +173,64 @@ static void lte_set_default_attach_info_cb(const =
struct ofono_error *error,
> >               return;
> >       }
> >
> > -     g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > -                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +     if (!g_str_equal(lte->pending_info.apn, lte->info.apn)) {
> > +             g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > +                                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +             key =3D LTE_APN;
> > +             propstr =3D lte->info.apn;
> > +     } else if (lte->pending_info.proto !=3D lte->info.proto) {
> > +             lte->info.proto =3D lte->pending_info.proto;
> > +             key =3D LTE_PROTO;
> > +             propstr =3D gprs_proto_to_string(lte->info.proto);
> > +     } else if (lte->pending_info.auth_method !=3D lte->info.auth_meth=
od) {
> > +             lte->info.auth_method =3D lte->pending_info.auth_method;
> > +             key =3D LTE_AUTH_METHOD;
> > +             propstr =3D gprs_auth_method_to_string(lte->info.auth_met=
hod);
> > +
> > +     } else if (!g_str_equal(lte->pending_info.username,
> > +                                                     lte->info.usernam=
e)) {
> > +             g_strlcpy(lte->info.username, lte->pending_info.username,
> > +                                     OFONO_GPRS_MAX_USERNAME_LENGTH + =
1);
> > +             key =3D LTE_USERNAME;
> > +             propstr =3D lte->info.username;
> > +     } else if (!g_str_equal(lte->pending_info.password,
> > +                                                     lte->info.passwor=
d)) {
> > +             g_strlcpy(lte->info.password, lte->pending_info.password,
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH + =
1);
> > +             key =3D LTE_PASSWORD;
> > +             propstr =3D lte->info.password;
> > +     } else {
> > +             /*
> > +              * this should never happen, because no property change is
> > +              * checked before.
>
> If this should never happen, handling it _gracefully_ doesn't make much
> sense.  If this _can't_ happen, skip the check; if it _might but
> shouldn't_, log an error, at least.

an error log is an excellent idea, thanks.

>
> > +              * Neverthelss, in this case it will answer the D-Bus mes=
sage
> > +              * but emit no signal
> > +              */
> > +             key =3D NULL;
> > +     }
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
> >   }
> >
> >   static DBusMessage *lte_set_property(DBusConnection *conn,
> > @@ -177,6 +241,14 @@ static DBusMessage *lte_set_property(DBusConnectio=
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
> >       if (!dbus_message_iter_init(msg, &iter))
> >               return __ofono_error_invalid_args(msg);
> > @@ -192,16 +264,64 @@ static DBusMessage *lte_set_property(DBusConnecti=
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
> > +
> > +     dbus_message_iter_get_basic(&var, &str);
> >
> > -             dbus_message_iter_get_basic(&var, &str);
> > +     if ((strcmp(property, LTE_APN) =3D=3D 0)) {
> >
> > -             return lte_set_default_apn(lte, conn, msg, str);
> > -     }
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
> > +
> > +     } else if (strcmp(property, LTE_AUTH_METHOD) =3D=3D 0) {
> > +
> > +             if (!gprs_auth_method_from_string(str, &auth_method))
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +             if (proto =3D=3D lte->info.proto)
> > +                     return dbus_message_new_method_return(msg);
> >
> > -     return __ofono_error_invalid_args(msg);
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
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     lte->driver->set_default_attach_info(lte, &lte->pending_info,
> > +                                     lte_set_default_attach_info_cb, l=
te);
>
> Note here that you've short-circuited the atmodem implementation (in
> patch 5/6) of this function so that the callback gets invoked
> immediately instead of on a subsequent mainloop iteration.  That often
> leads to surprising results... not sure if that's the case here, but the
> dbus_message_ref that follows looks suspicious.

that's disturbing. I will look into it.

>
> > +     return dbus_message_ref(msg);;
> >   }
> >
> >   static const GDBusMethodTable lte_methods[] =3D {
> > @@ -374,6 +494,16 @@ void *ofono_lte_get_data(const struct ofono_lte *l=
te)
> >       return lte->driver_data;
> >   }
> >
> > +void ofono_lte_set_reg_info(struct ofono_modem *modem)
> > +{
> > +     struct ofono_lte *lte =3D __ofono_atom_find(OFONO_ATOM_TYPE_LTE, =
modem);
> > +
> > +     if(!lte || !lte->driver || !lte->driver->set_reg_info)
> > +             return;
> > +
> > +     lte->driver->set_reg_info(lte, &lte->info);
> > +}
> > +
> >   struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
> >   {
> >       return __ofono_atom_get_modem(lte->atom);
>
> /Jonas

Giacinto

--===============1938596795972118627==--

