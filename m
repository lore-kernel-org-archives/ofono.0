Content-Type: multipart/mixed; boundary="===============6581181898024812746=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Wed, 19 Sep 2018 18:07:55 +0200
Message-ID: <CAKSBH7EXVzFTHPdG3QofsHW5ULP=XnpgHfKpp=Y+E_44eHoGzQ@mail.gmail.com>
In-Reply-To: <e56297a0-e44e-d9d2-5fef-b5d60c773a60@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6581181898024812746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Sep 19, 2018 at 5:04 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Giacinto,
>
> On 09/19/2018 12:37 AM, Giacinto Cifelli wrote:
> > ---
> >   src/gprs.c |  13 ++-
> >   src/lte.c  | 372
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
> >   src/main.c |   5 -
> >   3 files changed, 341 insertions(+), 49 deletions(-)
>
> So you seem to have 3 completely unrelated things going on here...  At
> the very minimum this should be 3 commits.
>
> Also, you're adding LTE D-Bus implementation without updating or
> proposing changes to doc/lte-api.txt.
>

so, first the documentation?


>
> > diff --git a/src/gprs.c b/src/gprs.c
> > index 377eced..40f43e3 100644
> > --- a/src/gprs.c
> > +++ b/src/gprs.c
> > @@ -261,6 +261,10 @@ static const char *gprs_auth_method_to_string(enum
> ofono_gprs_auth_method auth)
> >               return "chap";
> >       case OFONO_GPRS_AUTH_METHOD_PAP:
> >               return "pap";
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
> > +             return "none";
> > +     default:
> > +             return NULL;
> >       };
>
> Okay, but this patch likely needs to also ensure that username /
> password are not settable if method is NONE.  And follow up with an
> update of all things that depend on OFONO_GPRS_AUTH_METHOD usage.  E.g.
> drivers, provisioning plugins, etc.
>

Ok, I will take care of this as well.

>
> >       return NULL;
> > @@ -275,6 +279,9 @@ static gboolean gprs_auth_method_from_string(const
> char *str,
> >       } else if (g_str_equal(str, "pap")) {
> >               *auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
> >               return TRUE;
> > +     } else if (g_str_equal(str, "none")) {
> > +             *auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
> > +             return TRUE;
> >       }
> >
> >       return FALSE;
> > @@ -1008,7 +1015,7 @@ static void pri_read_settings_callback(const
> struct ofono_error *error,
> >
> >       value =3D pri_ctx->active;
> >
> > -     gprs->flags &=3D !GPRS_FLAG_ATTACHING;
> > +     gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
>
> Okay, but this is a separate fix and should be documented properly.
>

Okay


>
> >
> >       gprs->driver_attached =3D TRUE;
> >       gprs_set_attached_property(gprs, TRUE);
> > @@ -1635,6 +1642,9 @@ static void release_active_contexts(struct
> ofono_gprs *gprs)
> >
> >               if (gc->driver->detach_shutdown !=3D NULL)
> >                       gc->driver->detach_shutdown(gc, ctx->context.cid);
> > +
> > +             /* Make sure the context is properly cleared */
> > +             release_context(ctx);
>
> As above, seems to be an unrelated fix.
>

It is. I will submit another patch. the same below.


> >       }
> >   }
> >
> > @@ -2234,6 +2244,7 @@ static DBusMessage
> *gprs_remove_context(DBusConnection *conn,
> >       }
> >
> >       DBG("Unregistering context: %s", ctx->path);
> > +     release_context(ctx);
>
> As above.  You can't just lump these changes into something unrelated.
> You need to submit these fixes separately and describe what each one is
> fixing and why.
>
> >       context_dbus_unregister(ctx);
> >       gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
> >
> > diff --git a/src/lte.c b/src/lte.c
> > index a6d26b3..21b6a19 100644
> > --- a/src/lte.c
> > +++ b/src/lte.c
> > @@ -3,6 +3,7 @@
> >    *  oFono - Open Source Telephony
> >    *
> >    *  Copyright (C) 2016  Endocode AG. All rights reserved.
> > + *  Copyright (C) 2018 Gemalto M2M
> >    *
> >    *  This program is free software; you can redistribute it and/or
> modify
> >    *  it under the terms of the GNU General Public License version 2 as
> > @@ -39,7 +40,11 @@
> >
> >   #define SETTINGS_STORE "lte"
> >   #define SETTINGS_GROUP "Settings"
> > -#define DEFAULT_APN_KEY "DefaultAccessPointName"
> > +#define LTE_APN "AccessPointName"
>
> No.  You can't do that.  The D-Bus API is stable and cannot be changed.
> This is why you propose D-Bus API changes first, so that they can be
> reviewed separately for any impacts.
>

So there can be no unification with the GPRS naming now that the D-Bus API
is set?



> > +#define LTE_PROTO "Protocol"
> > +#define LTE_USERNAME "Username"
> > +#define LTE_PASSWORD "Password"
> > +#define LTE_AUTH_METHOD "AuthenticationMethod"
> >
> >   struct ofono_lte {
> >       const struct ofono_lte_driver *driver;
> > @@ -50,13 +55,82 @@ struct ofono_lte {
> >       DBusMessage *pending;
> >       struct ofono_lte_default_attach_info pending_info;
> >       struct ofono_lte_default_attach_info info;
> > +     const char *prop_changed;
>
> ??  What memory location is this const char pointing to?
>

it is initialized to null with the containing structure.


> Why don't you just use an enum.  Or even better, don't do this at all
> and simply compare pending_info & info to generate the right signal.
>

I will try to change it this way.


>
> >   };
> >
> >   static GSList *g_drivers =3D NULL;
> >
> > +static const char *gprs_proto_to_string(enum ofono_gprs_proto proto)
> > +{
> > +     switch (proto) {
> > +     case OFONO_GPRS_PROTO_IP:
> > +             return "ip";
> > +     case OFONO_GPRS_PROTO_IPV6:
> > +             return "ipv6";
> > +     case OFONO_GPRS_PROTO_IPV4V6:
> > +             return "dual";
> > +     };
> > +
> > +     return NULL;
> > +}
>
> This needs to be moved to common.c
>

I have tried and failed miserably. But in your email to Slava you have
mentioned moving also stuff to types.h, maybe that is the key.


>
> > +
> > +static gboolean gprs_proto_from_string(const char *str,
> > +                                     enum ofono_gprs_proto *proto)
> > +{
> > +     if (g_str_equal(str, "ip")) {
> > +             *proto =3D OFONO_GPRS_PROTO_IP;
> > +             return TRUE;
> > +     } else if (g_str_equal(str, "ipv6")) {
> > +             *proto =3D OFONO_GPRS_PROTO_IPV6;
> > +             return TRUE;
> > +     } else if (g_str_equal(str, "dual")) {
> > +             *proto =3D OFONO_GPRS_PROTO_IPV4V6;
> > +             return TRUE;
> > +     }
> > +
> > +     return FALSE;
> > +}
> > +
> > +static const char *gprs_auth_method_to_string(enum
> ofono_gprs_auth_method auth)
> > +{
> > +     switch (auth) {
> > +     case OFONO_GPRS_AUTH_METHOD_CHAP:
> > +             return "chap";
> > +     case OFONO_GPRS_AUTH_METHOD_PAP:
> > +             return "pap";
> > +     case OFONO_GPRS_AUTH_METHOD_NONE:
> > +             return "none";
> > +     default:
> > +             return NULL;
> > +     };
> > +
> > +     return NULL;
> > +}
> > +
> > +static gboolean gprs_auth_method_from_string(const char *str,
> > +                                     enum ofono_gprs_auth_method *auth)
> > +{
> > +     if (g_str_equal(str, "chap")) {
> > +             *auth =3D OFONO_GPRS_AUTH_METHOD_CHAP;
> > +             return TRUE;
> > +     } else if (g_str_equal(str, "pap")) {
> > +             *auth =3D OFONO_GPRS_AUTH_METHOD_PAP;
> > +             return TRUE;
> > +     } else if (g_str_equal(str, "none")) {
> > +             *auth =3D OFONO_GPRS_AUTH_METHOD_NONE;
> > +             return TRUE;
> > +     }
> > +
> > +     return FALSE;
> > +}
> > +
>
> And all these as well
>
> >   static void lte_load_settings(struct ofono_lte *lte)
> >   {
> > +     char *proto_str;
> >       char *apn;
> > +     char *auth_method_str;
> > +     char *username;
> > +     char *password;
> >
> >       if (lte->imsi =3D=3D NULL)
> >               return;
> > @@ -69,114 +143,276 @@ static void lte_load_settings(struct ofono_lte
> *lte)
> >               return;
> >       }
> >
> > -     apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP ,
> > -                                     DEFAULT_APN_KEY, NULL);
> > -     if (apn) {
> > +     proto_str =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_PROTO, NULL);
> > +     apn =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_APN, NULL);
>
> And now you broke the default attach APN setting of every existing oFono
> user.  No, you cannot do that.
>

What about reading also the previous key?

> +     auth_method_str =3D g_key_file_get_string(lte->settings,
> SETTINGS_GROUP,
> > +                             LTE_AUTH_METHOD, NULL);
> > +     username =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_USERNAME, NULL);
> > +     password =3D g_key_file_get_string(lte->settings, SETTINGS_GROUP,
> > +                             LTE_PASSWORD, NULL);
> > +     if (proto_str =3D=3D NULL)
> > +             proto_str =3D g_strdup("ip");
> > +
> > +     /* this must have a valid default */
> > +     if (!gprs_proto_from_string(proto_str, &lte->info.proto))
> > +             lte->info.proto =3D OFONO_GPRS_PROTO_IP;
> > +
> > +     if (apn)
> >               strcpy(lte->info.apn, apn);
> > -             g_free(apn);
> > -     }
> > +
> > +     if (auth_method_str =3D=3D NULL)
> > +             auth_method_str =3D g_strdup("none");
> > +
> > +     /* this must have a valid default */
> > +     if (!gprs_auth_method_from_string(auth_method_str,
> > +
>  &lte->info.auth_method))
> > +             lte->info.auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> > +
> > +     if (username)
> > +             strcpy(lte->info.username, username);
> > +
> > +     if (password)
> > +             strcpy(lte->info.password, password);
> > +
> > +     g_free(proto_str);
> > +     g_free(apn);
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
> >
> >       reply =3D dbus_message_new_method_return(msg);
> > +
>
> Don't change random code that doesn't need to be changed.  You should be
> keeping your changes minimal and on-point.  Any changes unrelated to the
> purpose of the patch need to be submitted separately.
>

ok.


> >       if (reply =3D=3D NULL)
> >               return NULL;
> >
> >       dbus_message_iter_init_append(reply, &iter);
> > -
> >       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> >                                       OFONO_PROPERTIES_ARRAY_SIGNATURE,
> >                                       &dict);
> > -     ofono_dbus_dict_append(&dict, DEFAULT_APN_KEY, DBUS_TYPE_STRING,
> &apn);
> > +     ofono_dbus_dict_append(&dict, LTE_PROTO, DBUS_TYPE_STRING, &proto=
);
> > +     ofono_dbus_dict_append(&dict, LTE_APN, DBUS_TYPE_STRING, &apn);
> > +     ofono_dbus_dict_append(&dict, LTE_AUTH_METHOD, DBUS_TYPE_STRING,
> > +                                     &auth_method);
> > +     ofono_dbus_dict_append(&dict, LTE_USERNAME, DBUS_TYPE_STRING,
> > +                                     &username);
> > +     ofono_dbus_dict_append(&dict, LTE_PASSWORD, DBUS_TYPE_STRING,
> > +                                     &password);
> >       dbus_message_iter_close_container(&iter, &dict);
> > -
> >       return reply;
> >   }
> >
> >   static void lte_set_default_attach_info_cb(const struct ofono_error
> *error,
> > -                                             void *data)
> > +                                                             void *dat=
a)
> >   {
> >       struct ofono_lte *lte =3D data;
> >       const char *path =3D __ofono_atom_get_path(lte->atom);
> >       DBusConnection *conn =3D ofono_dbus_get_connection();
> >       DBusMessage *reply;
> > -     const char *apn =3D lte->info.apn;
> > +     const char *propstr;
> >
> > -     DBG("%s error %d", path, error->type);
> > +     if (error !=3D NULL) {
> > +             DBG("%s error %d", path, error->type);
>
> Why?  Error should never be NULL.  If you're faking a call to this
> function, why don't you just pass a proper error structure in instead of
> messing with this?  And even then I would think it would be much cleaner
> not to do this in the first place...
>

ok.


>
> >
> > -     if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > -             __ofono_dbus_pending_reply(&lte->pending,
> > -                             __ofono_error_failed(lte->pending));
> > -             return;
> > +             if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> > +                     __ofono_dbus_pending_reply(&lte->pending,
> > +
>  __ofono_error_failed(lte->pending));
> > +                     return;
> > +             }
>
> This change is non-sense.
>
> >       }
> >
> > -     g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > -                     OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +     if (g_str_equal(lte->prop_changed, LTE_PROTO)) {
> > +             lte->info.proto =3D lte->pending_info.proto;
> > +             propstr =3D gprs_proto_to_string(lte->info.proto);
> >
> > -     if (lte->settings) {
> > -             if (strlen(lte->info.apn) =3D=3D 0)
> > -                     /* Clear entry on empty APN. */
> > -                     g_key_file_remove_key(lte->settings,
> SETTINGS_GROUP,
> > -                                             DEFAULT_APN_KEY, NULL);
> > -             else
> > +             if (lte->settings)
> >                       g_key_file_set_string(lte->settings,
> SETTINGS_GROUP,
> > -                                             DEFAULT_APN_KEY,
> lte->info.apn);
> > +                                                     LTE_PROTO,
> propstr);
> >
> > -             storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
> > +     } else if (g_str_equal(lte->prop_changed, LTE_APN)) {
> > +             g_strlcpy(lte->info.apn, lte->pending_info.apn,
> > +                                             OFONO_GPRS_MAX_APN_LENGTH
> + 1);
> > +             propstr =3D lte->info.apn;
> > +
> > +             if (lte->settings) {
> > +
> > +                     if (!*lte->info.apn)
> > +                             /* Clear entry on empty APN. */
> > +                             g_key_file_remove_key(lte->settings,
> > +                                     SETTINGS_GROUP, LTE_APN, NULL);
> > +                     else
> > +                             g_key_file_set_string(lte->settings,
> > +                                     SETTINGS_GROUP, LTE_APN,
> lte->info.apn);
> > +             }
> > +
> > +     } else if (g_str_equal(lte->prop_changed, LTE_AUTH_METHOD)) {
> > +             lte->info.auth_method =3D lte->pending_info.auth_method;
> > +             propstr =3D
> gprs_auth_method_to_string(lte->info.auth_method);
> > +
> > +             if (lte->settings)
> > +                     g_key_file_set_string(lte->settings,
> SETTINGS_GROUP,
> > +                                             LTE_AUTH_METHOD, propstr);
> > +
> > +     } else if (g_str_equal(lte->prop_changed, LTE_USERNAME)) {
> > +             g_strlcpy(lte->info.username, lte->pending_info.username,
> > +                     OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
> > +             propstr =3D lte->info.username;
> > +
> > +             if (lte->settings) {
> > +
> > +                     if (!*lte->info.username)
> > +                             /* Clear entry on empty Username. */
> > +                             g_key_file_remove_key(lte->settings,
> > +                                     SETTINGS_GROUP, LTE_USERNAME,
> NULL);
> > +                     else
> > +                             g_key_file_set_string(lte->settings,
> > +                                     SETTINGS_GROUP,
> > +                                     LTE_USERNAME, lte->info.username);
> > +             }
> > +
>
> You have boiler-plate code for nearly all of these settings.  Why don't
> you actually use a function for this?
>

Yes.


>
> > +     } else if (g_str_equal(lte->prop_changed, LTE_PASSWORD)) {
> > +             g_strlcpy(lte->info.password, lte->pending_info.password,
> > +                     OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
> > +             propstr =3D lte->info.password;
> > +
> > +             if (lte->settings) {
> > +
> > +                     if (strlen(lte->info.password) =3D=3D 0)
> > +                             /* Clear entry on empty Password. */
> > +                             g_key_file_remove_key(lte->settings,
> > +                                     SETTINGS_GROUP, LTE_PASSWORD,
> NULL);
> > +                     else
> > +                             g_key_file_set_string(lte->settings,
> > +                                     SETTINGS_GROUP,
> > +                                     LTE_PASSWORD, lte->info.password);
> > +             }
> > +
> > +     } else {
> > +             return;
>
> You have a dbus message pending, you can't do that...
>

I looked at this line for a long time, and looked bad, but couldn't put my
finger on it.
Thank you for highlighting the issue.


>
> >       }
> >
> > +     if (lte->settings)
> > +             storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
> > +
> >       reply =3D dbus_message_new_method_return(lte->pending);
> >       __ofono_dbus_pending_reply(&lte->pending, reply);
> > -
> >       ofono_dbus_signal_property_changed(conn, path,
> >                                       OFONO_CONNECTION_CONTEXT_INTERFAC=
E,
> > -                                     DEFAULT_APN_KEY,
> > -                                     DBUS_TYPE_STRING, &apn);
> > +                                     lte->prop_changed,
> > +                                     DBUS_TYPE_STRING, &propstr);
> >   }
> >
> > -static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
> > +static DBusMessage *lte_set_proto(struct ofono_lte *lte,
> >                               DBusConnection *conn, DBusMessage *msg,
> > -                             const char *apn)
> > +                             enum ofono_gprs_proto proto)
> >   {
> > -     if (lte->driver->set_default_attach_info =3D=3D NULL)
> > -             return __ofono_error_not_implemented(msg);
> > -
> > -     if (lte->pending)
> > -             return __ofono_error_busy(msg);
> > +     void *data =3D lte;
> >
> > -     if (g_str_equal(apn, lte->info.apn))
> > +     if (proto =3D=3D lte->info.proto)
> >               return dbus_message_new_method_return(msg);
> >
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     lte->pending_info.proto =3D proto;
> > +     lte_set_default_attach_info_cb(NULL, data);
> > +     return dbus_message_ref(msg);;
>
> I have no idea what is happening here.  Whatever it is, it is wrong.
>

It works.


>
> > +}
> > +
> > +static DBusMessage *lte_set_default_apn(struct ofono_lte *lte,
> > +                             DBusConnection *conn, DBusMessage *msg,
> > +                             const char *apn)
> > +{
> >       /* We do care about empty value: it can be used for reset. */
> >       if (is_valid_apn(apn) =3D=3D FALSE && apn[0] !=3D '\0')
> >               return __ofono_error_invalid_format(msg);
> >
> >       lte->pending =3D dbus_message_ref(msg);
> > +     g_strlcpy(lte->info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH + 1);
> > +     lte->driver->set_default_attach_info(lte, &lte->info,
> > +                                     lte_set_default_attach_info_cb,
> lte);
> > +     return dbus_message_ref(msg);
> > +}
> >
> > -     g_strlcpy(lte->pending_info.apn, apn, OFONO_GPRS_MAX_APN_LENGTH +
> 1);
> > +static DBusMessage *lte_set_auth_method(struct ofono_lte *lte,
> > +                             DBusConnection *conn, DBusMessage *msg,
> > +                             enum ofono_gprs_auth_method auth_method)
> > +{
> > +     void *data =3D lte;
> >
> > -     lte->driver->set_default_attach_info(lte, &lte->pending_info,
> > -                                     lte_set_default_attach_info_cb,
> lte);
> > +     if (auth_method =3D=3D lte->info.auth_method)
> > +             return dbus_message_new_method_return(msg);
> >
> > -     return NULL;
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     lte->pending_info.auth_method =3D auth_method;
> > +     lte_set_default_attach_info_cb(NULL, data);
> > +     return dbus_message_ref(msg);;
> > +}
> > +
> > +static DBusMessage *lte_set_username(struct ofono_lte *lte,
> > +                             DBusConnection *conn, DBusMessage *msg,
> > +                             const char *username)
> > +{
> > +     void *data =3D lte;
> > +
> > +     if (g_str_equal(username, lte->info.username))
> > +             return dbus_message_new_method_return(msg);
> > +
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     g_strlcpy(lte->pending_info.username, username,
> > +                                     OFONO_GPRS_MAX_USERNAME_LENGTH +
> 1);
> > +     lte_set_default_attach_info_cb(NULL, data);
> > +     return dbus_message_ref(msg);;
> > +}
> > +
> > +static DBusMessage *lte_set_password(struct ofono_lte *lte,
> > +                             DBusConnection *conn, DBusMessage *msg,
> > +                             const char *password)
> > +{
> > +     void *data =3D lte;
> > +
> > +     if (g_str_equal(password, lte->info.password))
> > +             return dbus_message_new_method_return(msg);
> > +
> > +     lte->pending =3D dbus_message_ref(msg);
> > +     g_strlcpy(lte->pending_info.password, password,
> > +                                     OFONO_GPRS_MAX_PASSWORD_LENGTH +
> 1);
> > +     lte_set_default_attach_info_cb(NULL, data);
> > +
>
> You do realize you're never actually calling into the driver method,
> right?  So none of these changes actually go out to the modem.  Have you
> actually tested any of this?
>

Yes, it works. Actually the only call is when the APN is set, as mentioned
in the lte-api.txt.
And at that point all parameters are also set in the module.
It is not possible to set separately protocol and apn, and auth_method,
username, and password.
For ublox modules, the auth_method is also part of the APN name.

So we kept the call into the module when the APN is set, and previously to
it all other parameters are set.

You have also mentioned that somewhere we should also verify that with
AUTH_NONE there are no user/pwd.
This also can only be verified at the end.

Any suggestions to improve this, given these limitations?


> +     return dbus_message_ref(msg);;
> >   }
> >
> >   static DBusMessage *lte_set_property(DBusConnection *conn,
> > -                                     DBusMessage *msg, void *data)
> > +                                             DBusMessage *msg, void
> *data)
> >   {
> >       struct ofono_lte *lte =3D data;
> >       DBusMessageIter iter;
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
> > @@ -192,13 +428,58 @@ static DBusMessage
> *lte_set_property(DBusConnection *conn,
> >
> >       dbus_message_iter_recurse(&iter, &var);
> >
> > -     if (!strcmp(property, DEFAULT_APN_KEY)) {
> > +     lte->prop_changed=3Dproperty;
> > +
> > +     if (!strcmp(property, LTE_PROTO)) {
> > +
> > +             if (dbus_message_iter_get_arg_type(&var) !=3D
> DBUS_TYPE_STRING)
> > +                     return __ofono_error_invalid_args(msg);
> > +
> > +             dbus_message_iter_get_basic(&var, &str);
> > +
> > +             if (gprs_proto_from_string(str, &proto))
> > +                     return lte_set_proto(lte, conn, msg, proto);
>
> The return from this callback is always supposed to be a method_return
> or NULL if the method_return will be done asynchronously (in your case
> always)  You're somehow returning the method_call itself...
>

I am not sure I follow you, but you suggested to restructure the code, so I
will come back on this later.


>
> > +             else
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +     } else if (!strcmp(property, LTE_APN)) {
> > +
> >               if (dbus_message_iter_get_arg_type(&var) !=3D
> DBUS_TYPE_STRING)
> >                       return __ofono_error_invalid_args(msg);
> >
> >               dbus_message_iter_get_basic(&var, &str);
> >
> >               return lte_set_default_apn(lte, conn, msg, str);
> > +
> > +     } else if (!strcmp(property, LTE_AUTH_METHOD)) {
> > +
> > +             if (dbus_message_iter_get_arg_type(&var) !=3D
> DBUS_TYPE_STRING)
> > +                     return __ofono_error_invalid_args(msg);
> > +
> > +             dbus_message_iter_get_basic(&var, &str);
> > +
> > +             if (gprs_auth_method_from_string(str, &auth_method))
> > +                     return lte_set_auth_method(lte, conn, msg,
> auth_method);
> > +             else
> > +                     return __ofono_error_invalid_format(msg);
> > +
> > +     } else  if (!strcmp(property, LTE_USERNAME)) {
> > +
> > +             if (dbus_message_iter_get_arg_type(&var) !=3D
> DBUS_TYPE_STRING)
> > +                     return __ofono_error_invalid_args(msg);
> > +
> > +             dbus_message_iter_get_basic(&var, &str);
> > +
> > +             return lte_set_username(lte, conn, msg, str);
> > +
> > +     } else  if (!strcmp(property, LTE_PASSWORD)) {
> > +
> > +             if (dbus_message_iter_get_arg_type(&var) !=3D
> DBUS_TYPE_STRING)
> > +                     return __ofono_error_invalid_args(msg);
> > +
> > +             dbus_message_iter_get_basic(&var, &str);
> > +
> > +             return lte_set_password(lte, conn, msg, str);
> >       }
> >
> >       return __ofono_error_invalid_args(msg);
> > @@ -373,3 +654,8 @@ void *ofono_lte_get_data(const struct ofono_lte *lt=
e)
> >   {
> >       return lte->driver_data;
> >   }
> > +
> > +struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte)
> > +{
> > +     return __ofono_atom_get_modem(lte->atom);
> > +}
> > \ No newline at end of file
>
> Fix this.
>

?


>
> > diff --git a/src/main.c b/src/main.c
> > index 2d359dd..d8a06ba 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -211,11 +211,6 @@ int main(int argc, char **argv)
> >       struct ell_event_source *source;
> >   #endif
> >
> > -#ifdef NEED_THREADS
> > -     if (g_thread_supported() =3D=3D FALSE)
> > -             g_thread_init(NULL);
> > -#endif
> > -
>
> Why? This is completely unrelated and can be turned off via configure.
>
> >       context =3D g_option_context_new(NULL);
> >       g_option_context_add_main_entries(context, options, NULL);
> >
> >
>
>
I agree it is unrelated, I will post a separate post, but I turn on
NEED_THREADS, and the build fails. Looking at the g_thread documentations,
nowadays it has to come out of the code:

g_thread_init has been deprecated since version 2.32 and should not be used
in newly-written code.

This function is no longer necessary. The GLib threading system is
automatically initialized at the start of your program.



> Regards,
> -Denis
>

Regards,
Giacinto

--===============6581181898024812746==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gV2VkLCBTZXAgMTksIDIwMTggYXQgNTowNCBQTSBEZW5pcyBLZW56
aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPkhpIEdpYWNpbnRvLDxicj4KPGJyPgpPbiAwOS8xOS8yMDE4IDEyOjM3
IEFNLCBHaWFjaW50byBDaWZlbGxpIHdyb3RlOjxicj4KJmd0OyAtLS08YnI+CiZndDvCoCDCoHNy
Yy9ncHJzLmMgfMKgIDEzICsrLTxicj4KJmd0O8KgIMKgc3JjL2x0ZS5jwqAgfCAzNzIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLTxi
cj4KJmd0O8KgIMKgc3JjL21haW4uYyB8wqAgwqA1IC08YnI+CiZndDvCoCDCoDMgZmlsZXMgY2hh
bmdlZCwgMzQxIGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKTxicj4KPGJyPgpTbyB5b3Ug
c2VlbSB0byBoYXZlIDMgY29tcGxldGVseSB1bnJlbGF0ZWQgdGhpbmdzIGdvaW5nIG9uIGhlcmUu
Li7CoCBBdCA8YnI+CnRoZSB2ZXJ5IG1pbmltdW0gdGhpcyBzaG91bGQgYmUgMyBjb21taXRzLjxi
cj4KPGJyPgpBbHNvLCB5b3UmIzM5O3JlIGFkZGluZyBMVEUgRC1CdXMgaW1wbGVtZW50YXRpb24g
d2l0aG91dCB1cGRhdGluZyBvciA8YnI+CnByb3Bvc2luZyBjaGFuZ2VzIHRvIGRvYy9sdGUtYXBp
LnR4dC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+c28sIGZpcnN0IHRoZSBk
b2N1bWVudGF0aW9uPzwvZGl2PjxkaXY+wqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4mZ3Q7IDxicj4KJmd0OyBkaWZmIC0t
Z2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJzLmM8YnI+CiZndDsgaW5kZXggMzc3ZWNlZC4uNDBm
NDNlMyAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvc3JjL2dwcnMuYzxicj4KJmd0OyArKysgYi9zcmMv
Z3Bycy5jPGJyPgomZ3Q7IEBAIC0yNjEsNiArMjYxLDEwIEBAIHN0YXRpYyBjb25zdCBjaGFyICpn
cHJzX2F1dGhfbWV0aG9kX3RvX3N0cmluZyhlbnVtIG9mb25vX2dwcnNfYXV0aF9tZXRob2QgYXV0
aCk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAmcXVvdDtjaGFwJnF1b3Q7
Ozxicj4KJmd0O8KgIMKgIMKgIMKgY2FzZSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX1BBUDo8YnI+
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAmcXVvdDtwYXAmcXVvdDs7PGJyPgom
Z3Q7ICvCoCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9OT05FOjxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gJnF1b3Q7bm9uZSZxdW90Ozs8YnI+CiZndDsgK8Kg
IMKgIMKgZGVmYXVsdDo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7
PGJyPgomZ3Q7wqAgwqAgwqAgwqB9Ozxicj4KPGJyPgpPa2F5LCBidXQgdGhpcyBwYXRjaCBsaWtl
bHkgbmVlZHMgdG8gYWxzbyBlbnN1cmUgdGhhdCB1c2VybmFtZSAvIDxicj4KcGFzc3dvcmQgYXJl
IG5vdCBzZXR0YWJsZSBpZiBtZXRob2QgaXMgTk9ORS7CoCBBbmQgZm9sbG93IHVwIHdpdGggYW4g
PGJyPgp1cGRhdGUgb2YgYWxsIHRoaW5ncyB0aGF0IGRlcGVuZCBvbiBPRk9OT19HUFJTX0FVVEhf
TUVUSE9EIHVzYWdlLsKgIEUuZy4gPGJyPgpkcml2ZXJzLCBwcm92aXNpb25pbmcgcGx1Z2lucywg
ZXRjLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5PaywgSSB3aWxsIHRha2Ug
Y2FyZSBvZiB0aGlzIGFzIHdlbGwuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Jmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAg
wqByZXR1cm4gTlVMTDs8YnI+CiZndDsgQEAgLTI3NSw2ICsyNzksOSBAQCBzdGF0aWMgZ2Jvb2xl
YW4gZ3Byc19hdXRoX21ldGhvZF9mcm9tX3N0cmluZyhjb25zdCBjaGFyICpzdHIsPGJyPgomZ3Q7
wqAgwqAgwqAgwqB9IGVsc2UgaWYgKGdfc3RyX2VxdWFsKHN0ciwgJnF1b3Q7cGFwJnF1b3Q7KSkg
ezxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKmF1dGggPSBPRk9OT19HUFJTX0FVVEhf
TUVUSE9EX1BBUDs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBUUlVFOzxi
cj4KJmd0OyArwqAgwqAgwqB9IGVsc2UgaWYgKGdfc3RyX2VxdWFsKHN0ciwgJnF1b3Q7bm9uZSZx
dW90OykpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgKmF1dGggPSBPRk9OT19HUFJT
X0FVVEhfTUVUSE9EX05PTkU7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBU
UlVFOzxicj4KJmd0O8KgIMKgIMKgIMKgfTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAg
wqByZXR1cm4gRkFMU0U7PGJyPgomZ3Q7IEBAIC0xMDA4LDcgKzEwMTUsNyBAQCBzdGF0aWMgdm9p
ZCBwcmlfcmVhZF9zZXR0aW5nc19jYWxsYmFjayhjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVy
cm9yLDxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqB2YWx1ZSA9IHByaV9jdHgtJmd0
O2FjdGl2ZTs8YnI+CiZndDvCoCDCoDxicj4KJmd0OyAtwqAgwqAgwqBncHJzLSZndDtmbGFncyAm
YW1wOz0gIUdQUlNfRkxBR19BVFRBQ0hJTkc7PGJyPgomZ3Q7ICvCoCDCoCDCoGdwcnMtJmd0O2Zs
YWdzICZhbXA7PSB+R1BSU19GTEFHX0FUVEFDSElORzs8YnI+Cjxicj4KT2theSwgYnV0IHRoaXMg
aXMgYSBzZXBhcmF0ZSBmaXggYW5kIHNob3VsZCBiZSBkb2N1bWVudGVkIHByb3Blcmx5Ljxicj48
L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5Pa2F5PC9kaXY+PGRpdj7CoDwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDvCoCDC
oDxicj4KJmd0O8KgIMKgIMKgIMKgZ3Bycy0mZ3Q7ZHJpdmVyX2F0dGFjaGVkID0gVFJVRTs8YnI+
CiZndDvCoCDCoCDCoCDCoGdwcnNfc2V0X2F0dGFjaGVkX3Byb3BlcnR5KGdwcnMsIFRSVUUpOzxi
cj4KJmd0OyBAQCAtMTYzNSw2ICsxNjQyLDkgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9hY3RpdmVf
Y29udGV4dHMoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpPGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChnYy0mZ3Q7ZHJpdmVyLSZndDtkZXRhY2hfc2h1dGRv
d24gIT0gTlVMTCk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdj
LSZndDtkcml2ZXItJmd0O2RldGFjaF9zaHV0ZG93bihnYywgY3R4LSZndDtjb250ZXh0LmNpZCk7
PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgLyogTWFrZSBzdXJlIHRo
ZSBjb250ZXh0IGlzIHByb3Blcmx5IGNsZWFyZWQgKi88YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgcmVsZWFzZV9jb250ZXh0KGN0eCk7PGJyPgo8YnI+CkFzIGFib3ZlLCBzZWVtcyB0byBi
ZSBhbiB1bnJlbGF0ZWQgZml4Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5J
dCBpcy4gSSB3aWxsIHN1Ym1pdCBhbm90aGVyIHBhdGNoLiB0aGUgc2FtZSBiZWxvdy7CoDwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPgo8YnI+CiZndDvCoCDCoCDCoCDCoH08YnI+CiZndDvCoCDCoH08YnI+CiZndDvCoCDCoDxi
cj4KJmd0OyBAQCAtMjIzNCw2ICsyMjQ0LDcgQEAgc3RhdGljIERCdXNNZXNzYWdlICpncHJzX3Jl
bW92ZV9jb250ZXh0KERCdXNDb25uZWN0aW9uICpjb25uLDxicj4KJmd0O8KgIMKgIMKgIMKgfTxi
cj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqBEQkcoJnF1b3Q7VW5yZWdpc3RlcmluZyBj
b250ZXh0OiAlcyZxdW90OywgY3R4LSZndDtwYXRoKTs8YnI+CiZndDsgK8KgIMKgIMKgcmVsZWFz
ZV9jb250ZXh0KGN0eCk7PGJyPgo8YnI+CkFzIGFib3ZlLsKgIFlvdSBjYW4mIzM5O3QganVzdCBs
dW1wIHRoZXNlIGNoYW5nZXMgaW50byBzb21ldGhpbmcgdW5yZWxhdGVkLiA8YnI+CllvdSBuZWVk
IHRvIHN1Ym1pdCB0aGVzZSBmaXhlcyBzZXBhcmF0ZWx5IGFuZCBkZXNjcmliZSB3aGF0IGVhY2gg
b25lIGlzIDxicj4KZml4aW5nIGFuZCB3aHkuPGJyPgo8YnI+CiZndDvCoCDCoCDCoCDCoGNvbnRl
eHRfZGJ1c191bnJlZ2lzdGVyKGN0eCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBncHJzLSZndDtjb250
ZXh0cyA9IGdfc2xpc3RfcmVtb3ZlKGdwcnMtJmd0O2NvbnRleHRzLCBjdHgpOzxicj4KJmd0O8Kg
IMKgPGJyPgomZ3Q7IGRpZmYgLS1naXQgYS9zcmMvbHRlLmMgYi9zcmMvbHRlLmM8YnI+CiZndDsg
aW5kZXggYTZkMjZiMy4uMjFiNmExOSAxMDA2NDQ8YnI+CiZndDsgLS0tIGEvc3JjL2x0ZS5jPGJy
PgomZ3Q7ICsrKyBiL3NyYy9sdGUuYzxicj4KJmd0OyBAQCAtMyw2ICszLDcgQEA8YnI+CiZndDvC
oCDCoCAqwqAgb0Zvbm8gLSBPcGVuIFNvdXJjZSBUZWxlcGhvbnk8YnI+CiZndDvCoCDCoCAqPGJy
PgomZ3Q7wqAgwqAgKsKgIENvcHlyaWdodCAoQykgMjAxNsKgIEVuZG9jb2RlIEFHLiBBbGwgcmln
aHRzIHJlc2VydmVkLjxicj4KJmd0OyArICrCoCBDb3B5cmlnaHQgKEMpIDIwMTggR2VtYWx0byBN
Mk08YnI+CiZndDvCoCDCoCAqPGJyPgomZ3Q7wqAgwqAgKsKgIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5PGJyPgomZ3Q7
wqAgwqAgKsKgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyIGFzPGJyPgomZ3Q7IEBAIC0zOSw3ICs0MCwxMSBAQDxicj4KJmd0O8Kg
IMKgPGJyPgomZ3Q7wqAgwqAjZGVmaW5lIFNFVFRJTkdTX1NUT1JFICZxdW90O2x0ZSZxdW90Ozxi
cj4KJmd0O8KgIMKgI2RlZmluZSBTRVRUSU5HU19HUk9VUCAmcXVvdDtTZXR0aW5ncyZxdW90Ozxi
cj4KJmd0OyAtI2RlZmluZSBERUZBVUxUX0FQTl9LRVkgJnF1b3Q7RGVmYXVsdEFjY2Vzc1BvaW50
TmFtZSZxdW90Ozxicj4KJmd0OyArI2RlZmluZSBMVEVfQVBOICZxdW90O0FjY2Vzc1BvaW50TmFt
ZSZxdW90Ozxicj4KPGJyPgpOby7CoCBZb3UgY2FuJiMzOTt0IGRvIHRoYXQuwqAgVGhlIEQtQnVz
IEFQSSBpcyBzdGFibGUgYW5kIGNhbm5vdCBiZSBjaGFuZ2VkLiA8YnI+ClRoaXMgaXMgd2h5IHlv
dSBwcm9wb3NlIEQtQnVzIEFQSSBjaGFuZ2VzIGZpcnN0LCBzbyB0aGF0IHRoZXkgY2FuIGJlIDxi
cj4KcmV2aWV3ZWQgc2VwYXJhdGVseSBmb3IgYW55IGltcGFjdHMuPGJyPjwvYmxvY2txdW90ZT48
ZGl2Pjxicj48L2Rpdj48ZGl2PlNvIHRoZXJlIGNhbiBiZSBubyB1bmlmaWNhdGlvbiB3aXRoIHRo
ZSBHUFJTIG5hbWluZyBub3cgdGhhdCB0aGUgRC1CdXMgQVBJIGlzIHNldD88L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+Jmd0OyArI2RlZmluZSBMVEVfUFJPVE8gJnF1b3Q7UHJvdG9jb2wmcXVvdDs8YnI+
CiZndDsgKyNkZWZpbmUgTFRFX1VTRVJOQU1FICZxdW90O1VzZXJuYW1lJnF1b3Q7PGJyPgomZ3Q7
ICsjZGVmaW5lIExURV9QQVNTV09SRCAmcXVvdDtQYXNzd29yZCZxdW90Ozxicj4KJmd0OyArI2Rl
ZmluZSBMVEVfQVVUSF9NRVRIT0QgJnF1b3Q7QXV0aGVudGljYXRpb25NZXRob2QmcXVvdDs8YnI+
CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgc3RydWN0IG9mb25vX2x0ZSB7PGJyPgomZ3Q7wqAgwqAg
wqAgwqBjb25zdCBzdHJ1Y3Qgb2Zvbm9fbHRlX2RyaXZlciAqZHJpdmVyOzxicj4KJmd0OyBAQCAt
NTAsMTMgKzU1LDgyIEBAIHN0cnVjdCBvZm9ub19sdGUgezxicj4KJmd0O8KgIMKgIMKgIMKgREJ1
c01lc3NhZ2UgKnBlbmRpbmc7PGJyPgomZ3Q7wqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRlX2Rl
ZmF1bHRfYXR0YWNoX2luZm8gcGVuZGluZ19pbmZvOzxicj4KJmd0O8KgIMKgIMKgIMKgc3RydWN0
IG9mb25vX2x0ZV9kZWZhdWx0X2F0dGFjaF9pbmZvIGluZm87PGJyPgomZ3Q7ICvCoCDCoCDCoGNv
bnN0IGNoYXIgKnByb3BfY2hhbmdlZDs8YnI+Cjxicj4KPz/CoCBXaGF0IG1lbW9yeSBsb2NhdGlv
biBpcyB0aGlzIGNvbnN0IGNoYXIgcG9pbnRpbmcgdG8/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pml0IGlzIGluaXRpYWxpemVkIHRvIG51bGwgd2l0aCB0aGUgY29udGFpbmlu
ZyBzdHJ1Y3R1cmUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KV2h5IGRvbiYjMzk7dCB5b3UganVzdCB1c2UgYW4g
ZW51bS7CoCBPciBldmVuIGJldHRlciwgZG9uJiMzOTt0IGRvIHRoaXMgYXQgYWxsIDxicj4KYW5k
IHNpbXBseSBjb21wYXJlIHBlbmRpbmdfaW5mbyAmYW1wOyBpbmZvIHRvIGdlbmVyYXRlIHRoZSBy
aWdodCBzaWduYWwuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2lsbCB0
cnkgdG8gY2hhbmdlIGl0IHRoaXMgd2F5LjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7wqAgwqB9Ozxicj4KJmd0
O8KgIMKgPGJyPgomZ3Q7wqAgwqBzdGF0aWMgR1NMaXN0ICpnX2RyaXZlcnMgPSBOVUxMOzxicj4K
Jmd0O8KgIMKgPGJyPgomZ3Q7ICtzdGF0aWMgY29uc3QgY2hhciAqZ3Byc19wcm90b190b19zdHJp
bmcoZW51bSBvZm9ub19ncHJzX3Byb3RvIHByb3RvKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAg
wqAgwqBzd2l0Y2ggKHByb3RvKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19Q
Uk9UT19JUDo8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuICZxdW90O2lwJnF1
b3Q7Ozxicj4KJmd0OyArwqAgwqAgwqBjYXNlIE9GT05PX0dQUlNfUFJPVE9fSVBWNjo8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuICZxdW90O2lwdjYmcXVvdDs7PGJyPgomZ3Q7
ICvCoCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19QUk9UT19JUFY0VjY6PGJyPgomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAmcXVvdDtkdWFsJnF1b3Q7Ozxicj4KJmd0OyArwqAgwqAgwqB9
Ozxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoHJldHVybiBOVUxMOzxicj4KJmd0OyArfTxi
cj4KPGJyPgpUaGlzIG5lZWRzIHRvIGJlIG1vdmVkIHRvIGNvbW1vbi5jPGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgaGF2ZSB0cmllZCBhbmQgZmFpbGVkIG1pc2VyYWJseS4g
QnV0IGluIHlvdXIgZW1haWwgdG8gU2xhdmEgeW91IGhhdmUgbWVudGlvbmVkIG1vdmluZyBhbHNv
IHN0dWZmIHRvIHR5cGVzLmgsIG1heWJlIHRoYXQgaXMgdGhlIGtleS48L2Rpdj48ZGl2PsKgPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0
OyArPGJyPgomZ3Q7ICtzdGF0aWMgZ2Jvb2xlYW4gZ3Byc19wcm90b19mcm9tX3N0cmluZyhjb25z
dCBjaGFyICpzdHIsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudW0gb2Zvbm9fZ3Byc19wcm90byAqcHJvdG8pPGJyPgom
Z3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChnX3N0cl9lcXVhbChzdHIsICZxdW90O2lwJnF1
b3Q7KSkgezxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAqcHJvdG8gPSBPRk9OT19HUFJT
X1BST1RPX0lQOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gVFJVRTs8YnI+
CiZndDsgK8KgIMKgIMKgfSBlbHNlIGlmIChnX3N0cl9lcXVhbChzdHIsICZxdW90O2lwdjYmcXVv
dDspKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCpwcm90byA9IE9GT05PX0dQUlNf
UFJPVE9fSVBWNjs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIFRSVUU7PGJy
PgomZ3Q7ICvCoCDCoCDCoH0gZWxzZSBpZiAoZ19zdHJfZXF1YWwoc3RyLCAmcXVvdDtkdWFsJnF1
b3Q7KSkgezxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAqcHJvdG8gPSBPRk9OT19HUFJT
X1BST1RPX0lQVjRWNjs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIFRSVUU7
PGJyPgomZ3Q7ICvCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4g
RkFMU0U7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRpYyBjb25zdCBjaGFy
ICpncHJzX2F1dGhfbWV0aG9kX3RvX3N0cmluZyhlbnVtIG9mb25vX2dwcnNfYXV0aF9tZXRob2Qg
YXV0aCk8YnI+CiZndDsgK3s8YnI+CiZndDsgK8KgIMKgIMKgc3dpdGNoIChhdXRoKSB7PGJyPgom
Z3Q7ICvCoCDCoCDCoGNhc2UgT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9DSEFQOjxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gJnF1b3Q7Y2hhcCZxdW90Ozs8YnI+CiZndDsgK8Kg
IMKgIMKgY2FzZSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX1BBUDo8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuICZxdW90O3BhcCZxdW90Ozs8YnI+CiZndDsgK8KgIMKgIMKgY2Fz
ZSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX05PTkU6PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiAmcXVvdDtub25lJnF1b3Q7Ozxicj4KJmd0OyArwqAgwqAgwqBkZWZhdWx0Ojxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gTlVMTDs8YnI+CiZndDsgK8KgIMKg
IMKgfTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4gTlVMTDs8YnI+CiZndDsg
K308YnI+CiZndDsgKzxicj4KJmd0OyArc3RhdGljIGdib29sZWFuIGdwcnNfYXV0aF9tZXRob2Rf
ZnJvbV9zdHJpbmcoY29uc3QgY2hhciAqc3RyLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbnVtIG9mb25vX2dwcnNfYXV0
aF9tZXRob2QgKmF1dGgpPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChnX3N0cl9l
cXVhbChzdHIsICZxdW90O2NoYXAmcXVvdDspKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCphdXRoID0gT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9DSEFQOzxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gVFJVRTs8YnI+CiZndDsgK8KgIMKgIMKgfSBlbHNlIGlmIChn
X3N0cl9lcXVhbChzdHIsICZxdW90O3BhcCZxdW90OykpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgKmF1dGggPSBPRk9OT19HUFJTX0FVVEhfTUVUSE9EX1BBUDs8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIFRSVUU7PGJyPgomZ3Q7ICvCoCDCoCDCoH0gZWxzZSBp
ZiAoZ19zdHJfZXF1YWwoc3RyLCAmcXVvdDtub25lJnF1b3Q7KSkgezxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAqYXV0aCA9IE9GT05PX0dQUlNfQVVUSF9NRVRIT0RfTk9ORTs8YnI+CiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIFRSVUU7PGJyPgomZ3Q7ICvCoCDCoCDCoH08
YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4gRkFMU0U7PGJyPgomZ3Q7ICt9PGJy
PgomZ3Q7ICs8YnI+Cjxicj4KQW5kIGFsbCB0aGVzZSBhcyB3ZWxsPGJyPgo8YnI+CiZndDvCoCDC
oHN0YXRpYyB2b2lkIGx0ZV9sb2FkX3NldHRpbmdzKHN0cnVjdCBvZm9ub19sdGUgKmx0ZSk8YnI+
CiZndDvCoCDCoHs8YnI+CiZndDsgK8KgIMKgIMKgY2hhciAqcHJvdG9fc3RyOzxicj4KJmd0O8Kg
IMKgIMKgIMKgY2hhciAqYXBuOzxicj4KJmd0OyArwqAgwqAgwqBjaGFyICphdXRoX21ldGhvZF9z
dHI7PGJyPgomZ3Q7ICvCoCDCoCDCoGNoYXIgKnVzZXJuYW1lOzxicj4KJmd0OyArwqAgwqAgwqBj
aGFyICpwYXNzd29yZDs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgaWYgKGx0ZS0m
Z3Q7aW1zaSA9PSBOVUxMKTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxi
cj4KJmd0OyBAQCAtNjksMTE0ICsxNDMsMjc2IEBAIHN0YXRpYyB2b2lkIGx0ZV9sb2FkX3NldHRp
bmdzKHN0cnVjdCBvZm9ub19sdGUgKmx0ZSk8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybjs8YnI+CiZndDvCoCDCoCDCoCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0OyAtwqAg
wqAgwqBhcG4gPSBnX2tleV9maWxlX2dldF9zdHJpbmcobHRlLSZndDtzZXR0aW5ncywgU0VUVElO
R1NfR1JPVVAgLDxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBERUZBVUxUX0FQTl9LRVksIE5VTEwpOzxicj4KJmd0OyAtwqAg
wqAgwqBpZiAoYXBuKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoHByb3RvX3N0ciA9IGdfa2V5X2ZpbGVf
Z2V0X3N0cmluZyhsdGUtJmd0O3NldHRpbmdzLCBTRVRUSU5HU19HUk9VUCw8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTFRFX1BST1RPLCBOVUxM
KTs8YnI+CiZndDsgK8KgIMKgIMKgYXBuID0gZ19rZXlfZmlsZV9nZXRfc3RyaW5nKGx0ZS0mZ3Q7
c2V0dGluZ3MsIFNFVFRJTkdTX0dST1VQLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMVEVfQVBOLCBOVUxMKTs8YnI+Cjxicj4KQW5kIG5vdyB5
b3UgYnJva2UgdGhlIGRlZmF1bHQgYXR0YWNoIEFQTiBzZXR0aW5nIG9mIGV2ZXJ5IGV4aXN0aW5n
IG9Gb25vIDxicj4KdXNlci7CoCBObywgeW91IGNhbm5vdCBkbyB0aGF0Ljxicj48L2Jsb2NrcXVv
dGU+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGF0IGFib3V0IHJlYWRpbmcgYWxzbyB0aGUgcHJldmlv
dXMga2V5PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPiZndDsgK8KgIMKgIMKgYXV0aF9tZXRob2Rfc3RyID0gZ19rZXlfZmls
ZV9nZXRfc3RyaW5nKGx0ZS0mZ3Q7c2V0dGluZ3MsIFNFVFRJTkdTX0dST1VQLDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMVEVfQVVUSF9NRVRI
T0QsIE5VTEwpOzxicj4KJmd0OyArwqAgwqAgwqB1c2VybmFtZSA9IGdfa2V5X2ZpbGVfZ2V0X3N0
cmluZyhsdGUtJmd0O3NldHRpbmdzLCBTRVRUSU5HU19HUk9VUCw8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTFRFX1VTRVJOQU1FLCBOVUxMKTs8
YnI+CiZndDsgK8KgIMKgIMKgcGFzc3dvcmQgPSBnX2tleV9maWxlX2dldF9zdHJpbmcobHRlLSZn
dDtzZXR0aW5ncywgU0VUVElOR1NfR1JPVVAsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoExURV9QQVNTV09SRCwgTlVMTCk7PGJyPgomZ3Q7ICvC
oCDCoCDCoGlmIChwcm90b19zdHIgPT0gTlVMTCk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgcHJvdG9fc3RyID0gZ19zdHJkdXAoJnF1b3Q7aXAmcXVvdDspOzxicj4KJmd0OyArPGJyPgom
Z3Q7ICvCoCDCoCDCoC8qIHRoaXMgbXVzdCBoYXZlIGEgdmFsaWQgZGVmYXVsdCAqLzxicj4KJmd0
OyArwqAgwqAgwqBpZiAoIWdwcnNfcHJvdG9fZnJvbV9zdHJpbmcocHJvdG9fc3RyLCAmYW1wO2x0
ZS0mZ3Q7aW5mby5wcm90bykpPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGx0ZS0mZ3Q7
aW5mby5wcm90byA9IE9GT05PX0dQUlNfUFJPVE9fSVA7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8Kg
IMKgIMKgaWYgKGFwbik8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmNweShsdGUt
Jmd0O2luZm8uYXBuLCBhcG4pOzxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2ZyZWUo
YXBuKTs8YnI+CiZndDsgLcKgIMKgIMKgfTxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlm
IChhdXRoX21ldGhvZF9zdHIgPT0gTlVMTCk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
YXV0aF9tZXRob2Rfc3RyID0gZ19zdHJkdXAoJnF1b3Q7bm9uZSZxdW90Oyk7PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK8KgIMKgIMKgLyogdGhpcyBtdXN0IGhhdmUgYSB2YWxpZCBkZWZhdWx0ICovPGJy
PgomZ3Q7ICvCoCDCoCDCoGlmICghZ3Byc19hdXRoX21ldGhvZF9mcm9tX3N0cmluZyhhdXRoX21l
dGhvZF9zdHIsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7bHRlLSZndDtp
bmZvLmF1dGhfbWV0aG9kKSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgbHRlLSZndDtp
bmZvLmF1dGhfbWV0aG9kID0gT0ZPTk9fR1BSU19BVVRIX01FVEhPRF9OT05FOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoGlmICh1c2VybmFtZSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgc3RyY3B5KGx0ZS0mZ3Q7aW5mby51c2VybmFtZSwgdXNlcm5hbWUpOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChwYXNzd29yZCk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgc3RyY3B5KGx0ZS0mZ3Q7aW5mby5wYXNzd29yZCwgcGFzc3dvcmQpOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoGdfZnJlZShwcm90b19zdHIpOzxicj4KJmd0OyArwqAgwqAgwqBn
X2ZyZWUoYXBuKTs8YnI+CiZndDsgK8KgIMKgIMKgZ19mcmVlKGF1dGhfbWV0aG9kX3N0cik7PGJy
PgomZ3Q7ICvCoCDCoCDCoGdfZnJlZSh1c2VybmFtZSk7PGJyPgomZ3Q7ICvCoCDCoCDCoGdfZnJl
ZShwYXNzd29yZCk7PGJyPgomZ3Q7wqAgwqB9PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoHN0
YXRpYyBEQnVzTWVzc2FnZSAqbHRlX2dldF9wcm9wZXJ0aWVzKERCdXNDb25uZWN0aW9uICpjb25u
LDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSk8YnI+CiZndDvCoCDCoHs8
YnI+CiZndDvCoCDCoCDCoCDCoHN0cnVjdCBvZm9ub19sdGUgKmx0ZSA9IGRhdGE7PGJyPgomZ3Q7
ICvCoCDCoCDCoGNvbnN0IGNoYXIgKnByb3RvID0gZ3Byc19wcm90b190b19zdHJpbmcobHRlLSZn
dDtpbmZvLnByb3RvKTs8YnI+CiZndDvCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKmFwbiA9IGx0ZS0m
Z3Q7aW5mby5hcG47PGJyPgomZ3Q7ICvCoCDCoCDCoGNvbnN0IGNoYXIqIGF1dGhfbWV0aG9kID08
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Byc19hdXRoX21ldGhv
ZF90b19zdHJpbmcobHRlLSZndDtpbmZvLmF1dGhfbWV0aG9kKTs8YnI+CiZndDsgK8KgIMKgIMKg
Y29uc3QgY2hhciAqdXNlcm5hbWUgPSBsdGUtJmd0O2luZm8udXNlcm5hbWU7PGJyPgomZ3Q7ICvC
oCDCoCDCoGNvbnN0IGNoYXIgKnBhc3N3b3JkID0gbHRlLSZndDtpbmZvLnBhc3N3b3JkOzxicj4K
Jmd0O8KgIMKgIMKgIMKgREJ1c01lc3NhZ2UgKnJlcGx5Ozxicj4KJmd0O8KgIMKgIMKgIMKgREJ1
c01lc3NhZ2VJdGVyIGl0ZXI7PGJyPgomZ3Q7wqAgwqAgwqAgwqBEQnVzTWVzc2FnZUl0ZXIgZGlj
dDs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgcmVwbHkgPSBkYnVzX21lc3NhZ2Vf
bmV3X21ldGhvZF9yZXR1cm4obXNnKTs8YnI+CiZndDsgKzxicj4KPGJyPgpEb24mIzM5O3QgY2hh
bmdlIHJhbmRvbSBjb2RlIHRoYXQgZG9lc24mIzM5O3QgbmVlZCB0byBiZSBjaGFuZ2VkLsKgIFlv
dSBzaG91bGQgYmUgPGJyPgprZWVwaW5nIHlvdXIgY2hhbmdlcyBtaW5pbWFsIGFuZCBvbi1wb2lu
dC7CoCBBbnkgY2hhbmdlcyB1bnJlbGF0ZWQgdG8gdGhlIDxicj4KcHVycG9zZSBvZiB0aGUgcGF0
Y2ggbmVlZCB0byBiZSBzdWJtaXR0ZWQgc2VwYXJhdGVseS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXY+b2suPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2Nj
IHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPiZndDvCoCDCoCDCoCDCoGlmIChyZXBseSA9PSBOVUxM
KTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPgomZ3Q7wqAg
wqA8YnI+CiZndDvCoCDCoCDCoCDCoGRidXNfbWVzc2FnZV9pdGVyX2luaXRfYXBwZW5kKHJlcGx5
LCAmYW1wO2l0ZXIpOzxicj4KJmd0OyAtPGJyPgomZ3Q7wqAgwqAgwqAgwqBkYnVzX21lc3NhZ2Vf
aXRlcl9vcGVuX2NvbnRhaW5lcigmYW1wO2l0ZXIsIERCVVNfVFlQRV9BUlJBWSw8YnI+CiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oE9GT05PX1BST1BFUlRJRVNfQVJSQVlfU0lHTkFUVVJFLDxicj4KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtkaWN0KTs8
YnI+CiZndDsgLcKgIMKgIMKgb2Zvbm9fZGJ1c19kaWN0X2FwcGVuZCgmYW1wO2RpY3QsIERFRkFV
TFRfQVBOX0tFWSwgREJVU19UWVBFX1NUUklORywgJmFtcDthcG4pOzxicj4KJmd0OyArwqAgwqAg
wqBvZm9ub19kYnVzX2RpY3RfYXBwZW5kKCZhbXA7ZGljdCwgTFRFX1BST1RPLCBEQlVTX1RZUEVf
U1RSSU5HLCAmYW1wO3Byb3RvKTs8YnI+CiZndDsgK8KgIMKgIMKgb2Zvbm9fZGJ1c19kaWN0X2Fw
cGVuZCgmYW1wO2RpY3QsIExURV9BUE4sIERCVVNfVFlQRV9TVFJJTkcsICZhbXA7YXBuKTs8YnI+
CiZndDsgK8KgIMKgIMKgb2Zvbm9fZGJ1c19kaWN0X2FwcGVuZCgmYW1wO2RpY3QsIExURV9BVVRI
X01FVEhPRCwgREJVU19UWVBFX1NUUklORyw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDthdXRoX21ldGhvZCk7PGJy
PgomZ3Q7ICvCoCDCoCDCoG9mb25vX2RidXNfZGljdF9hcHBlbmQoJmFtcDtkaWN0LCBMVEVfVVNF
Uk5BTUUsIERCVVNfVFlQRV9TVFJJTkcsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7dXNlcm5hbWUpOzxicj4KJmd0
OyArwqAgwqAgwqBvZm9ub19kYnVzX2RpY3RfYXBwZW5kKCZhbXA7ZGljdCwgTFRFX1BBU1NXT1JE
LCBEQlVTX1RZUEVfU1RSSU5HLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO3Bhc3N3b3JkKTs8YnI+CiZndDvCoCDC
oCDCoCDCoGRidXNfbWVzc2FnZV9pdGVyX2Nsb3NlX2NvbnRhaW5lcigmYW1wO2l0ZXIsICZhbXA7
ZGljdCk7PGJyPgomZ3Q7IC08YnI+CiZndDvCoCDCoCDCoCDCoHJldHVybiByZXBseTs8YnI+CiZn
dDvCoCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgc3RhdGljIHZvaWQgbHRlX3NldF9k
ZWZhdWx0X2F0dGFjaF9pbmZvX2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPGJy
PgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQgKmRhdGEpPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQgKmRhdGEpPGJyPgomZ3Q7wqAgwqB7PGJyPgomZ3Q7wqAg
wqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUgPSBkYXRhOzxicj4KJmd0O8KgIMKgIMKgIMKg
Y29uc3QgY2hhciAqcGF0aCA9IF9fb2Zvbm9fYXRvbV9nZXRfcGF0aChsdGUtJmd0O2F0b20pOzxi
cj4KJmd0O8KgIMKgIMKgIMKgREJ1c0Nvbm5lY3Rpb24gKmNvbm4gPSBvZm9ub19kYnVzX2dldF9j
b25uZWN0aW9uKCk7PGJyPgomZ3Q7wqAgwqAgwqAgwqBEQnVzTWVzc2FnZSAqcmVwbHk7PGJyPgom
Z3Q7IC3CoCDCoCDCoGNvbnN0IGNoYXIgKmFwbiA9IGx0ZS0mZ3Q7aW5mby5hcG47PGJyPgomZ3Q7
ICvCoCDCoCDCoGNvbnN0IGNoYXIgKnByb3BzdHI7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsgLcKg
IMKgIMKgREJHKCZxdW90OyVzIGVycm9yICVkJnF1b3Q7LCBwYXRoLCBlcnJvci0mZ3Q7dHlwZSk7
PGJyPgomZ3Q7ICvCoCDCoCDCoGlmIChlcnJvciAhPSBOVUxMKSB7PGJyPgomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoERCRygmcXVvdDslcyBlcnJvciAlZCZxdW90OywgcGF0aCwgZXJyb3ItJmd0
O3R5cGUpOzxicj4KPGJyPgpXaHk/wqAgRXJyb3Igc2hvdWxkIG5ldmVyIGJlIE5VTEwuwqAgSWYg
eW91JiMzOTtyZSBmYWtpbmcgYSBjYWxsIHRvIHRoaXMgPGJyPgpmdW5jdGlvbiwgd2h5IGRvbiYj
Mzk7dCB5b3UganVzdCBwYXNzIGEgcHJvcGVyIGVycm9yIHN0cnVjdHVyZSBpbiBpbnN0ZWFkIG9m
IDxicj4KbWVzc2luZyB3aXRoIHRoaXM/wqAgQW5kIGV2ZW4gdGhlbiBJIHdvdWxkIHRoaW5rIGl0
IHdvdWxkIGJlIG11Y2ggY2xlYW5lciA8YnI+Cm5vdCB0byBkbyB0aGlzIGluIHRoZSBmaXJzdCBw
bGFjZS4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5vay48L2Rpdj48ZGl2
PsKgPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
Pgo8YnI+CiZndDvCoCDCoDxicj4KJmd0OyAtwqAgwqAgwqBpZiAoZXJyb3ItJmd0O3R5cGUgIT0g
T0ZPTk9fRVJST1JfVFlQRV9OT19FUlJPUikgezxicj4KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqBfX29mb25vX2RidXNfcGVuZGluZ19yZXBseSgmYW1wO2x0ZS0mZ3Q7cGVuZGluZyw8YnI+CiZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgX19vZm9ub19l
cnJvcl9mYWlsZWQobHRlLSZndDtwZW5kaW5nKSk7PGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybjs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVycm9yLSZndDt0
eXBlICE9IE9GT05PX0VSUk9SX1RZUEVfTk9fRVJST1IpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgX19vZm9ub19kYnVzX3BlbmRpbmdfcmVwbHkoJmFtcDtsdGUt
Jmd0O3BlbmRpbmcsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9fb2Zvbm9fZXJyb3JfZmFpbGVkKGx0ZS0mZ3Q7cGVuZGlu
ZykpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJy
PgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+Cjxicj4KVGhpcyBjaGFuZ2UgaXMgbm9u
LXNlbnNlLjxicj4KPGJyPgomZ3Q7wqAgwqAgwqAgwqB9PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsg
LcKgIMKgIMKgZ19zdHJsY3B5KGx0ZS0mZ3Q7aW5mby5hcG4sIGx0ZS0mZ3Q7cGVuZGluZ19pbmZv
LmFwbiw8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgT0ZPTk9fR1BS
U19NQVhfQVBOX0xFTkdUSCArIDEpOzxicj4KJmd0OyArwqAgwqAgwqBpZiAoZ19zdHJfZXF1YWwo
bHRlLSZndDtwcm9wX2NoYW5nZWQsIExURV9QUk9UTykpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgbHRlLSZndDtpbmZvLnByb3RvID0gbHRlLSZndDtwZW5kaW5nX2luZm8ucHJvdG87
PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHByb3BzdHIgPSBncHJzX3Byb3RvX3RvX3N0
cmluZyhsdGUtJmd0O2luZm8ucHJvdG8pOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC3CoCDCoCDC
oGlmIChsdGUtJmd0O3NldHRpbmdzKSB7PGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChzdHJsZW4obHRlLSZndDtpbmZvLmFwbikgPT0gMCk8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgLyogQ2xlYXIgZW50cnkgb24gZW1wdHkgQVBOLiAqLzxicj4KJmd0
OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2tleV9maWxlX3JlbW92ZV9rZXko
bHRlLSZndDtzZXR0aW5ncywgU0VUVElOR1NfR1JPVVAsPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERF
RkFVTFRfQVBOX0tFWSwgTlVMTCk7PGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2U8
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGx0ZS0mZ3Q7c2V0dGluZ3MpPGJyPgom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2tleV9maWxlX3NldF9zdHJp
bmcobHRlLSZndDtzZXR0aW5ncywgU0VUVElOR1NfR1JPVVAsPGJyPgomZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oERFRkFVTFRfQVBOX0tFWSwgbHRlLSZndDtpbmZvLmFwbik7PGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoExURV9QUk9UTywgcHJvcHN0cik7PGJyPgomZ3Q7wqAgwqA8YnI+CiZndDsg
LcKgIMKgIMKgIMKgIMKgIMKgIMKgc3RvcmFnZV9zeW5jKGx0ZS0mZ3Q7aW1zaSwgU0VUVElOR1Nf
U1RPUkUsIGx0ZS0mZ3Q7c2V0dGluZ3MpOzxicj4KJmd0OyArwqAgwqAgwqB9IGVsc2UgaWYgKGdf
c3RyX2VxdWFsKGx0ZS0mZ3Q7cHJvcF9jaGFuZ2VkLCBMVEVfQVBOKSkgezxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqBnX3N0cmxjcHkobHRlLSZndDtpbmZvLmFwbiwgbHRlLSZndDtwZW5k
aW5nX2luZm8uYXBuLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBPRk9OT19HUFJTX01BWF9BUE5fTEVO
R1RIICsgMSk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHByb3BzdHIgPSBsdGUtJmd0
O2luZm8uYXBuOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChs
dGUtJmd0O3NldHRpbmdzKSB7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKCEqbHRlLSZndDtpbmZvLmFwbik8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQ2xlYXIgZW50cnkgb24gZW1w
dHkgQVBOLiAqLzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBnX2tleV9maWxlX3JlbW92ZV9rZXkobHRlLSZndDtzZXR0aW5ncyw8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
U0VUVElOR1NfR1JPVVAsIExURV9BUE4sIE5VTEwpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlbHNlPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGdfa2V5X2ZpbGVfc2V0X3N0cmluZyhsdGUtJmd0O3NldHRpbmdz
LDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBTRVRUSU5HU19HUk9VUCwgTFRFX0FQTiwgbHRlLSZndDtpbmZvLmFwbik7PGJy
PgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqB9IGVsc2UgaWYgKGdfc3RyX2VxdWFsKGx0ZS0mZ3Q7cHJvcF9jaGFuZ2VkLCBMVEVfQVVUSF9N
RVRIT0QpKSB7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGx0ZS0mZ3Q7aW5mby5hdXRo
X21ldGhvZCA9IGx0ZS0mZ3Q7cGVuZGluZ19pbmZvLmF1dGhfbWV0aG9kOzxicj4KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcm9wc3RyID0gZ3Byc19hdXRoX21ldGhvZF90b19zdHJpbmcobHRl
LSZndDtpbmZvLmF1dGhfbWV0aG9kKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAobHRlLSZndDtzZXR0aW5ncyk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZ19rZXlfZmlsZV9zZXRfc3RyaW5nKGx0ZS0mZ3Q7c2V0dGluZ3MsIFNF
VFRJTkdTX0dST1VQLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMVEVfQVVUSF9NRVRIT0QsIHByb3Bz
dHIpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoH0gZWxzZSBpZiAoZ19zdHJfZXF1YWwo
bHRlLSZndDtwcm9wX2NoYW5nZWQsIExURV9VU0VSTkFNRSkpIHs8YnI+CiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgZ19zdHJsY3B5KGx0ZS0mZ3Q7aW5mby51c2VybmFtZSwgbHRlLSZndDtwZW5k
aW5nX2luZm8udXNlcm5hbWUsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoE9GT05PX0dQUlNfTUFYX1VTRVJOQU1FX0xFTkdUSCArIDEpOzxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqBwcm9wc3RyID0gbHRlLSZndDtpbmZvLnVzZXJuYW1lOzxicj4KJmd0OyAr
PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChsdGUtJmd0O3NldHRpbmdzKSB7PGJy
PgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCEq
bHRlLSZndDtpbmZvLnVzZXJuYW1lKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBDbGVhciBlbnRyeSBvbiBlbXB0eSBVc2VybmFtZS4gKi88
YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ19r
ZXlfZmlsZV9yZW1vdmVfa2V5KGx0ZS0mZ3Q7c2V0dGluZ3MsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFNFVFRJTkdTX0dS
T1VQLCBMVEVfVVNFUk5BTUUsIE5VTEwpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBlbHNlPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdfa2V5X2ZpbGVfc2V0X3N0cmluZyhsdGUtJmd0O3NldHRpbmdzLDxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBTRVRUSU5HU19HUk9VUCw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTFRFX1VTRVJOQU1FLCBsdGUtJmd0O2luZm8u
dXNlcm5hbWUpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPgomZ3Q7ICs8YnI+
Cjxicj4KWW91IGhhdmUgYm9pbGVyLXBsYXRlIGNvZGUgZm9yIG5lYXJseSBhbGwgb2YgdGhlc2Ug
c2V0dGluZ3MuwqAgV2h5IGRvbiYjMzk7dCA8YnI+CnlvdSBhY3R1YWxseSB1c2UgYSBmdW5jdGlv
biBmb3IgdGhpcz88YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WWVzLjwvZGl2
PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KPGJyPgomZ3Q7ICvCoCDCoCDCoH0gZWxzZSBpZiAoZ19zdHJfZXF1YWwobHRlLSZndDtwcm9w
X2NoYW5nZWQsIExURV9QQVNTV09SRCkpIHs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
Z19zdHJsY3B5KGx0ZS0mZ3Q7aW5mby5wYXNzd29yZCwgbHRlLSZndDtwZW5kaW5nX2luZm8ucGFz
c3dvcmQsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX0dQ
UlNfTUFYX1BBU1NXT1JEX0xFTkdUSCArIDEpOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqBwcm9wc3RyID0gbHRlLSZndDtpbmZvLnBhc3N3b3JkOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChsdGUtJmd0O3NldHRpbmdzKSB7PGJyPgomZ3Q7ICs8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cmxlbihsdGUtJmd0
O2luZm8ucGFzc3dvcmQpID09IDApPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC8qIENsZWFyIGVudHJ5IG9uIGVtcHR5IFBhc3N3b3JkLiAqLzxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2tl
eV9maWxlX3JlbW92ZV9rZXkobHRlLSZndDtzZXR0aW5ncyw8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU0VUVElOR1NfR1JP
VVAsIExURV9QQVNTV09SRCwgTlVMTCk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVsc2U8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ19rZXlfZmlsZV9zZXRfc3RyaW5nKGx0ZS0mZ3Q7c2V0dGluZ3MsPGJyPgom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFNFVFRJTkdTX0dST1VQLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMVEVfUEFTU1dPUkQsIGx0ZS0mZ3Q7aW5mby5w
YXNzd29yZCk7PGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+CiZndDsgKzxicj4K
Jmd0OyArwqAgwqAgwqB9IGVsc2Ugezxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm47PGJyPgo8YnI+CllvdSBoYXZlIGEgZGJ1cyBtZXNzYWdlIHBlbmRpbmcsIHlvdSBjYW4mIzM5
O3QgZG8gdGhhdC4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGxvb2tl
ZCBhdCB0aGlzIGxpbmUgZm9yIGEgbG9uZyB0aW1lLCBhbmQgbG9va2VkIGJhZCwgYnV0IGNvdWxk
biYjMzk7dCBwdXQgbXkgZmluZ2VyIG9uIGl0LjwvZGl2PjxkaXY+VGhhbmsgeW91IGZvciBoaWdo
bGlnaHRpbmcgdGhlIGlzc3VlLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7wqAgwqAgwqAgwqB9PGJyPgomZ3Q7
wqAgwqA8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGx0ZS0mZ3Q7c2V0dGluZ3MpPGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoHN0b3JhZ2Vfc3luYyhsdGUtJmd0O2ltc2ksIFNFVFRJTkdTX1NU
T1JFLCBsdGUtJmd0O3NldHRpbmdzKTs8YnI+CiZndDsgKzxicj4KJmd0O8KgIMKgIMKgIMKgcmVw
bHkgPSBkYnVzX21lc3NhZ2VfbmV3X21ldGhvZF9yZXR1cm4obHRlLSZndDtwZW5kaW5nKTs8YnI+
CiZndDvCoCDCoCDCoCDCoF9fb2Zvbm9fZGJ1c19wZW5kaW5nX3JlcGx5KCZhbXA7bHRlLSZndDtw
ZW5kaW5nLCByZXBseSk7PGJyPgomZ3Q7IC08YnI+CiZndDvCoCDCoCDCoCDCoG9mb25vX2RidXNf
c2lnbmFsX3Byb3BlcnR5X2NoYW5nZWQoY29ubiwgcGF0aCw8YnI+CiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX0NPTk5F
Q1RJT05fQ09OVEVYVF9JTlRFUkZBQ0UsPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERFRkFVTFRfQVBOX0tFWSw8YnI+CiZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgREJVU19UWVBFX1NUUklORywgJmFtcDthcG4pOzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsdGUtJmd0O3Byb3BfY2hh
bmdlZCw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgREJVU19UWVBFX1NUUklORywgJmFtcDtwcm9wc3RyKTs8YnI+CiZndDvC
oCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0OyAtc3RhdGljIERCdXNNZXNzYWdlICpsdGVfc2V0
X2RlZmF1bHRfYXBuKHN0cnVjdCBvZm9ub19sdGUgKmx0ZSw8YnI+CiZndDsgK3N0YXRpYyBEQnVz
TWVzc2FnZSAqbHRlX3NldF9wcm90byhzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUsPGJyPgomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQnVzQ29ubmVjdGlv
biAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZyw8YnI+CiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqYXBuKTxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbnVtIG9mb25vX2dwcnNfcHJv
dG8gcHJvdG8pPGJyPgomZ3Q7wqAgwqB7PGJyPgomZ3Q7IC3CoCDCoCDCoGlmIChsdGUtJmd0O2Ry
aXZlci0mZ3Q7c2V0X2RlZmF1bHRfYXR0YWNoX2luZm8gPT0gTlVMTCk8YnI+CiZndDsgLcKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxlbWVudGVkKG1zZyk7
PGJyPgomZ3Q7IC08YnI+CiZndDsgLcKgIMKgIMKgaWYgKGx0ZS0mZ3Q7cGVuZGluZyk8YnI+CiZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfYnVzeShtc2cpOzxi
cj4KJmd0OyArwqAgwqAgwqB2b2lkICpkYXRhID0gbHRlOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7
IC3CoCDCoCDCoGlmIChnX3N0cl9lcXVhbChhcG4sIGx0ZS0mZ3Q7aW5mby5hcG4pKTxicj4KJmd0
OyArwqAgwqAgwqBpZiAocHJvdG8gPT0gbHRlLSZndDtpbmZvLnByb3RvKTxicj4KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybiht
c2cpOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7ICvCoCDCoCDCoGx0ZS0mZ3Q7cGVuZGluZyA9IGRi
dXNfbWVzc2FnZV9yZWYobXNnKTs8YnI+CiZndDsgK8KgIMKgIMKgbHRlLSZndDtwZW5kaW5nX2lu
Zm8ucHJvdG8gPSBwcm90bzs8YnI+CiZndDsgK8KgIMKgIMKgbHRlX3NldF9kZWZhdWx0X2F0dGFj
aF9pbmZvX2NiKE5VTEwsIGRhdGEpOzxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4gZGJ1c19tZXNz
YWdlX3JlZihtc2cpOzs8YnI+Cjxicj4KSSBoYXZlIG5vIGlkZWEgd2hhdCBpcyBoYXBwZW5pbmcg
aGVyZS7CoCBXaGF0ZXZlciBpdCBpcywgaXQgaXMgd3JvbmcuPGJyPjwvYmxvY2txdW90ZT48ZGl2
Pjxicj48L2Rpdj48ZGl2Pkl0IHdvcmtzLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK3N0YXRpYyBEQnVzTWVzc2FnZSAqbHRlX3NldF9kZWZhdWx0X2FwbihzdHJ1Y3Qg
b2Zvbm9fbHRlICpsdGUsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoERCdXNDb25uZWN0aW9uICpjb25uLCBEQnVzTWVzc2FnZSAqbXNnLDxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBj
aGFyICphcG4pPGJyPgomZ3Q7ICt7PGJyPgomZ3Q7wqAgwqAgwqAgwqAvKiBXZSBkbyBjYXJlIGFi
b3V0IGVtcHR5IHZhbHVlOiBpdCBjYW4gYmUgdXNlZCBmb3IgcmVzZXQuICovPGJyPgomZ3Q7wqAg
wqAgwqAgwqBpZiAoaXNfdmFsaWRfYXBuKGFwbikgPT0gRkFMU0UgJmFtcDsmYW1wOyBhcG5bMF0g
IT0gJiMzOTtcMCYjMzk7KTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9f
b2Zvbm9fZXJyb3JfaW52YWxpZF9mb3JtYXQobXNnKTs8YnI+CiZndDvCoCDCoDxicj4KJmd0O8Kg
IMKgIMKgIMKgbHRlLSZndDtwZW5kaW5nID0gZGJ1c19tZXNzYWdlX3JlZihtc2cpOzxicj4KJmd0
OyArwqAgwqAgwqBnX3N0cmxjcHkobHRlLSZndDtpbmZvLmFwbiwgYXBuLCBPRk9OT19HUFJTX01B
WF9BUE5fTEVOR1RIICsgMSk7PGJyPgomZ3Q7ICvCoCDCoCDCoGx0ZS0mZ3Q7ZHJpdmVyLSZndDtz
ZXRfZGVmYXVsdF9hdHRhY2hfaW5mbyhsdGUsICZhbXA7bHRlLSZndDtpbmZvLDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBs
dGVfc2V0X2RlZmF1bHRfYXR0YWNoX2luZm9fY2IsIGx0ZSk7PGJyPgomZ3Q7ICvCoCDCoCDCoHJl
dHVybiBkYnVzX21lc3NhZ2VfcmVmKG1zZyk7PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7wqAgwqA8YnI+
CiZndDsgLcKgIMKgIMKgZ19zdHJsY3B5KGx0ZS0mZ3Q7cGVuZGluZ19pbmZvLmFwbiwgYXBuLCBP
Rk9OT19HUFJTX01BWF9BUE5fTEVOR1RIICsgMSk7PGJyPgomZ3Q7ICtzdGF0aWMgREJ1c01lc3Nh
Z2UgKmx0ZV9zZXRfYXV0aF9tZXRob2Qoc3RydWN0IG9mb25vX2x0ZSAqbHRlLDxicj4KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQnVzQ29ubmVjdGlv
biAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZyw8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW51bSBvZm9ub19ncHJzX2F1dGhfbWV0aG9kIGF1dGhf
bWV0aG9kKTxicj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqB2b2lkICpkYXRhID0gbHRlOzxi
cj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC3CoCDCoCDCoGx0ZS0mZ3Q7ZHJpdmVyLSZndDtzZXRfZGVm
YXVsdF9hdHRhY2hfaW5mbyhsdGUsICZhbXA7bHRlLSZndDtwZW5kaW5nX2luZm8sPGJyPgomZ3Q7
IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGx0ZV9zZXRfZGVmYXVsdF9hdHRhY2hfaW5mb19jYiwgbHRlKTs8YnI+CiZndDsgK8KgIMKgIMKg
aWYgKGF1dGhfbWV0aG9kID09IGx0ZS0mZ3Q7aW5mby5hdXRoX21ldGhvZCk8YnI+CiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybiht
c2cpOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7IC3CoCDCoCDCoHJldHVybiBOVUxMOzxicj4KJmd0
OyArwqAgwqAgwqBsdGUtJmd0O3BlbmRpbmcgPSBkYnVzX21lc3NhZ2VfcmVmKG1zZyk7PGJyPgom
Z3Q7ICvCoCDCoCDCoGx0ZS0mZ3Q7cGVuZGluZ19pbmZvLmF1dGhfbWV0aG9kID0gYXV0aF9tZXRo
b2Q7PGJyPgomZ3Q7ICvCoCDCoCDCoGx0ZV9zZXRfZGVmYXVsdF9hdHRhY2hfaW5mb19jYihOVUxM
LCBkYXRhKTs8YnI+CiZndDsgK8KgIMKgIMKgcmV0dXJuIGRidXNfbWVzc2FnZV9yZWYobXNnKTs7
PGJyPgomZ3Q7ICt9PGJyPgomZ3Q7ICs8YnI+CiZndDsgK3N0YXRpYyBEQnVzTWVzc2FnZSAqbHRl
X3NldF91c2VybmFtZShzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUsPGJyPgomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERCdXNDb25uZWN0aW9uICpjb25uLCBE
QnVzTWVzc2FnZSAqbXNnLDxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjb25zdCBjaGFyICp1c2VybmFtZSk8YnI+CiZndDsgK3s8YnI+CiZndDsg
K8KgIMKgIMKgdm9pZCAqZGF0YSA9IGx0ZTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBp
ZiAoZ19zdHJfZXF1YWwodXNlcm5hbWUsIGx0ZS0mZ3Q7aW5mby51c2VybmFtZSkpPGJyPgomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBkYnVzX21lc3NhZ2VfbmV3X21ldGhvZF9yZXR1
cm4obXNnKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqBsdGUtJmd0O3BlbmRpbmcgPSBk
YnVzX21lc3NhZ2VfcmVmKG1zZyk7PGJyPgomZ3Q7ICvCoCDCoCDCoGdfc3RybGNweShsdGUtJmd0
O3BlbmRpbmdfaW5mby51c2VybmFtZSwgdXNlcm5hbWUsPGJyPgomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX0dQUlNfTUFY
X1VTRVJOQU1FX0xFTkdUSCArIDEpOzxicj4KJmd0OyArwqAgwqAgwqBsdGVfc2V0X2RlZmF1bHRf
YXR0YWNoX2luZm9fY2IoTlVMTCwgZGF0YSk7PGJyPgomZ3Q7ICvCoCDCoCDCoHJldHVybiBkYnVz
X21lc3NhZ2VfcmVmKG1zZyk7Ozxicj4KJmd0OyArfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdGF0
aWMgREJ1c01lc3NhZ2UgKmx0ZV9zZXRfcGFzc3dvcmQoc3RydWN0IG9mb25vX2x0ZSAqbHRlLDxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQnVz
Q29ubmVjdGlvbiAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZyw8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqcGFzc3dvcmQpPGJy
PgomZ3Q7ICt7PGJyPgomZ3Q7ICvCoCDCoCDCoHZvaWQgKmRhdGEgPSBsdGU7PGJyPgomZ3Q7ICs8
YnI+CiZndDsgK8KgIMKgIMKgaWYgKGdfc3RyX2VxdWFsKHBhc3N3b3JkLCBsdGUtJmd0O2luZm8u
cGFzc3dvcmQpKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZGJ1c19tZXNz
YWdlX25ld19tZXRob2RfcmV0dXJuKG1zZyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKg
bHRlLSZndDtwZW5kaW5nID0gZGJ1c19tZXNzYWdlX3JlZihtc2cpOzxicj4KJmd0OyArwqAgwqAg
wqBnX3N0cmxjcHkobHRlLSZndDtwZW5kaW5nX2luZm8ucGFzc3dvcmQsIHBhc3N3b3JkLDxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBPRk9OT19HUFJTX01BWF9QQVNTV09SRF9MRU5HVEggKyAxKTs8YnI+CiZndDsgK8KgIMKg
IMKgbHRlX3NldF9kZWZhdWx0X2F0dGFjaF9pbmZvX2NiKE5VTEwsIGRhdGEpOzxicj4KJmd0OyAr
PGJyPgo8YnI+CllvdSBkbyByZWFsaXplIHlvdSYjMzk7cmUgbmV2ZXIgYWN0dWFsbHkgY2FsbGlu
ZyBpbnRvIHRoZSBkcml2ZXIgbWV0aG9kLCA8YnI+CnJpZ2h0P8KgIFNvIG5vbmUgb2YgdGhlc2Ug
Y2hhbmdlcyBhY3R1YWxseSBnbyBvdXQgdG8gdGhlIG1vZGVtLsKgIEhhdmUgeW91IDxicj4KYWN0
dWFsbHkgdGVzdGVkIGFueSBvZiB0aGlzPzxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PGRpdj5ZZXMsIGl0IHdvcmtzLiBBY3R1YWxseSB0aGUgb25seSBjYWxsIGlzIHdoZW4gdGhlIEFQ
TiBpcyBzZXQsIGFzIG1lbnRpb25lZCBpbiB0aGUgbHRlLWFwaS50eHQuPC9kaXY+PGRpdj5BbmQg
YXQgdGhhdCBwb2ludCBhbGwgcGFyYW1ldGVycyBhcmUgYWxzbyBzZXQgaW4gdGhlIG1vZHVsZS48
L2Rpdj48ZGl2Pkl0IGlzIG5vdCBwb3NzaWJsZSB0byBzZXQgc2VwYXJhdGVseSBwcm90b2NvbCBh
bmQgYXBuLCBhbmQgYXV0aF9tZXRob2QsIHVzZXJuYW1lLCBhbmQgcGFzc3dvcmQuPC9kaXY+PGRp
dj5Gb3IgdWJsb3ggbW9kdWxlcywgdGhlIGF1dGhfbWV0aG9kIGlzIGFsc28gcGFydCBvZiB0aGUg
QVBOIG5hbWUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TbyB3ZSBrZXB0IHRoZSBjYWxsIGlu
dG8gdGhlIG1vZHVsZSB3aGVuIHRoZSBBUE4gaXMgc2V0LCBhbmQgcHJldmlvdXNseSB0byBpdCBh
bGwgb3RoZXIgcGFyYW1ldGVycyBhcmUgc2V0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+WW91
IGhhdmUgYWxzbyBtZW50aW9uZWQgdGhhdCBzb21ld2hlcmUgd2Ugc2hvdWxkIGFsc28gdmVyaWZ5
IHRoYXQgd2l0aCBBVVRIX05PTkUgdGhlcmUgYXJlIG5vIHVzZXIvcHdkLjwvZGl2PjxkaXY+VGhp
cyBhbHNvIGNhbiBvbmx5IGJlIHZlcmlmaWVkIGF0IHRoZSBlbmQuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5Bbnkgc3VnZ2VzdGlvbnMgdG8gaW1wcm92ZSB0aGlzLCBnaXZlbiB0aGVzZSBsaW1p
dGF0aW9ucz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4mZ3Q7ICvCoCDCoCDCoHJldHVybiBkYnVz
X21lc3NhZ2VfcmVmKG1zZyk7Ozxicj4KJmd0O8KgIMKgfTxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7
wqAgwqBzdGF0aWMgREJ1c01lc3NhZ2UgKmx0ZV9zZXRfcHJvcGVydHkoREJ1c0Nvbm5lY3Rpb24g
KmNvbm4sPGJyPgomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoERCdXNNZXNzYWdlICptc2csIHZvaWQgKmRhdGEpPGJyPgomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoERCdXNNZXNzYWdlICptc2csIHZvaWQgKmRhdGEpPGJyPgomZ3Q7wqAgwqB7PGJy
PgomZ3Q7wqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbHRlICpsdGUgPSBkYXRhOzxicj4KJmd0O8Kg
IMKgIMKgIMKgREJ1c01lc3NhZ2VJdGVyIGl0ZXI7PGJyPgomZ3Q7wqAgwqAgwqAgwqBEQnVzTWVz
c2FnZUl0ZXIgdmFyOzxicj4KJmd0O8KgIMKgIMKgIMKgY29uc3QgY2hhciAqcHJvcGVydHk7PGJy
PgomZ3Q7wqAgwqAgwqAgwqBjb25zdCBjaGFyICpzdHI7PGJyPgomZ3Q7ICvCoCDCoCDCoGVudW0g
b2Zvbm9fZ3Byc19hdXRoX21ldGhvZCBhdXRoX21ldGhvZDs8YnI+CiZndDsgK8KgIMKgIMKgZW51
bSBvZm9ub19ncHJzX3Byb3RvIHByb3RvOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoGlm
IChsdGUtJmd0O2RyaXZlci0mZ3Q7c2V0X2RlZmF1bHRfYXR0YWNoX2luZm8gPT0gTlVMTCk8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2ltcGxl
bWVudGVkKG1zZyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKGx0ZS0mZ3Q7cGVu
ZGluZyk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jf
YnVzeShtc2cpOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqBpZiAoIWRidXNfbWVz
c2FnZV9pdGVyX2luaXQobXNnLCAmYW1wO2l0ZXIpKTxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfaW52YWxpZF9hcmdzKG1zZyk7PGJyPgomZ3Q7IEBA
IC0xOTIsMTMgKzQyOCw1OCBAQCBzdGF0aWMgREJ1c01lc3NhZ2UgKmx0ZV9zZXRfcHJvcGVydHko
REJ1c0Nvbm5lY3Rpb24gKmNvbm4sPGJyPgomZ3Q7wqAgwqA8YnI+CiZndDvCoCDCoCDCoCDCoGRi
dXNfbWVzc2FnZV9pdGVyX3JlY3Vyc2UoJmFtcDtpdGVyLCAmYW1wO3Zhcik7PGJyPgomZ3Q7wqAg
wqA8YnI+CiZndDsgLcKgIMKgIMKgaWYgKCFzdHJjbXAocHJvcGVydHksIERFRkFVTFRfQVBOX0tF
WSkpIHs8YnI+CiZndDsgK8KgIMKgIMKgbHRlLSZndDtwcm9wX2NoYW5nZWQ9cHJvcGVydHk7PGJy
PgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgaWYgKCFzdHJjbXAocHJvcGVydHksIExURV9QUk9U
TykpIHs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZhbXA7dmFyKSAhPSBEQlVTX1RZUEVfU1RSSU5HKTxi
cj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19l
cnJvcl9pbnZhbGlkX2FyZ3MobXNnKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFzaWMoJmFtcDt2YXIsICZhbXA7c3RyKTs8
YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZ3Byc19wcm90b19m
cm9tX3N0cmluZyhzdHIsICZhbXA7cHJvdG8pKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gbHRlX3NldF9wcm90byhsdGUsIGNvbm4sIG1zZywgcHJvdG8p
Ozxicj4KPGJyPgpUaGUgcmV0dXJuIGZyb20gdGhpcyBjYWxsYmFjayBpcyBhbHdheXMgc3VwcG9z
ZWQgdG8gYmUgYSBtZXRob2RfcmV0dXJuIDxicj4Kb3IgTlVMTCBpZiB0aGUgbWV0aG9kX3JldHVy
biB3aWxsIGJlIGRvbmUgYXN5bmNocm9ub3VzbHkgKGluIHlvdXIgY2FzZSA8YnI+CmFsd2F5cynC
oCBZb3UmIzM5O3JlIHNvbWVob3cgcmV0dXJuaW5nIHRoZSBtZXRob2RfY2FsbCBpdHNlbGYuLi48
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSBub3Qgc3VyZSBJIGZvbGxv
dyB5b3UsIGJ1dCB5b3Ugc3VnZ2VzdGVkIHRvIHJlc3RydWN0dXJlIHRoZSBjb2RlLCBzbyBJIHdp
bGwgY29tZSBiYWNrIG9uIHRoaXMgbGF0ZXIuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgZWxzZTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gX19vZm9ub19lcnJvcl9pbnZhbGlkX2Zvcm1hdChtc2cpOzxicj4KJmd0OyArPGJyPgom
Z3Q7ICvCoCDCoCDCoH0gZWxzZSBpZiAoIXN0cmNtcChwcm9wZXJ0eSwgTFRFX0FQTikpIHs8YnI+
CiZndDsgKzxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRidXNfbWVzc2FnZV9p
dGVyX2dldF9hcmdfdHlwZSgmYW1wO3ZhcikgIT0gREJVU19UWVBFX1NUUklORyk8YnI+CiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBfX29mb25vX2Vycm9yX2lu
dmFsaWRfYXJncyhtc2cpOzxicj4KJmd0O8KgIMKgPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFzaWMoJmFtcDt2YXIsICZhbXA7c3RyKTs8YnI+
CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGx0ZV9zZXRf
ZGVmYXVsdF9hcG4obHRlLCBjb25uLCBtc2csIHN0cik7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8Kg
IMKgIMKgfSBlbHNlIGlmICghc3RyY21wKHByb3BlcnR5LCBMVEVfQVVUSF9NRVRIT0QpKSB7PGJy
PgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRidXNfbWVzc2FnZV9p
dGVyX2dldF9hcmdfdHlwZSgmYW1wO3ZhcikgIT0gREJVU19UWVBFX1NUUklORyk8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfaW52
YWxpZF9hcmdzKG1zZyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
ZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2Jhc2ljKCZhbXA7dmFyLCAmYW1wO3N0cik7PGJyPgomZ3Q7
ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGdwcnNfYXV0aF9tZXRob2RfZnJv
bV9zdHJpbmcoc3RyLCAmYW1wO2F1dGhfbWV0aG9kKSk8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGx0ZV9zZXRfYXV0aF9tZXRob2QobHRlLCBjb25uLCBt
c2csIGF1dGhfbWV0aG9kKTs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTxicj4K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19lcnJv
cl9pbnZhbGlkX2Zvcm1hdChtc2cpOzxicj4KJmd0OyArPGJyPgomZ3Q7ICvCoCDCoCDCoH0gZWxz
ZcKgIGlmICghc3RyY21wKHByb3BlcnR5LCBMVEVfVVNFUk5BTUUpKSB7PGJyPgomZ3Q7ICs8YnI+
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRidXNfbWVzc2FnZV9pdGVyX2dldF9hcmdf
dHlwZSgmYW1wO3ZhcikgIT0gREJVU19UWVBFX1NUUklORyk8YnI+CiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfaW52YWxpZF9hcmdzKG1z
Zyk7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgZGJ1c19tZXNzYWdl
X2l0ZXJfZ2V0X2Jhc2ljKCZhbXA7dmFyLCAmYW1wO3N0cik7PGJyPgomZ3Q7ICs8YnI+CiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGx0ZV9zZXRfdXNlcm5hbWUobHRlLCBjb25uLCBt
c2csIHN0cik7PGJyPgomZ3Q7ICs8YnI+CiZndDsgK8KgIMKgIMKgfSBlbHNlwqAgaWYgKCFzdHJj
bXAocHJvcGVydHksIExURV9QQVNTV09SRCkpIHs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoZGJ1c19tZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZhbXA7dmFy
KSAhPSBEQlVTX1RZUEVfU1RSSU5HKTxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gX19vZm9ub19lcnJvcl9pbnZhbGlkX2FyZ3MobXNnKTs8YnI+CiZndDsg
Kzxicj4KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYmFz
aWMoJmFtcDt2YXIsICZhbXA7c3RyKTs8YnI+CiZndDsgKzxicj4KJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gbHRlX3NldF9wYXNzd29yZChsdGUsIGNvbm4sIG1zZywgc3RyKTs8YnI+
CiZndDvCoCDCoCDCoCDCoH08YnI+CiZndDvCoCDCoDxicj4KJmd0O8KgIMKgIMKgIMKgcmV0dXJu
IF9fb2Zvbm9fZXJyb3JfaW52YWxpZF9hcmdzKG1zZyk7PGJyPgomZ3Q7IEBAIC0zNzMsMyArNjU0
LDggQEAgdm9pZCAqb2Zvbm9fbHRlX2dldF9kYXRhKGNvbnN0IHN0cnVjdCBvZm9ub19sdGUgKmx0
ZSk8YnI+CiZndDvCoCDCoHs8YnI+CiZndDvCoCDCoCDCoCDCoHJldHVybiBsdGUtJmd0O2RyaXZl
cl9kYXRhOzxicj4KJmd0O8KgIMKgfTxicj4KJmd0OyArPGJyPgomZ3Q7ICtzdHJ1Y3Qgb2Zvbm9f
bW9kZW0gKm9mb25vX2x0ZV9nZXRfbW9kZW0oY29uc3Qgc3RydWN0IG9mb25vX2x0ZSAqbHRlKTxi
cj4KJmd0OyArezxicj4KJmd0OyArwqAgwqAgwqByZXR1cm4gX19vZm9ub19hdG9tX2dldF9tb2Rl
bShsdGUtJmd0O2F0b20pOzxicj4KJmd0OyArfTxicj4KJmd0OyBcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGU8YnI+Cjxicj4KRml4IHRoaXMuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2Pj88L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+Cjxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvc3JjL21haW4uYyBiL3NyYy9t
YWluLmM8YnI+CiZndDsgaW5kZXggMmQzNTlkZC4uZDhhMDZiYSAxMDA2NDQ8YnI+CiZndDsgLS0t
IGEvc3JjL21haW4uYzxicj4KJmd0OyArKysgYi9zcmMvbWFpbi5jPGJyPgomZ3Q7IEBAIC0yMTEs
MTEgKzIxMSw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndik8YnI+CiZndDvCoCDC
oCDCoCDCoHN0cnVjdCBlbGxfZXZlbnRfc291cmNlICpzb3VyY2U7PGJyPgomZ3Q7wqAgwqAjZW5k
aWY8YnI+CiZndDvCoCDCoDxicj4KJmd0OyAtI2lmZGVmIE5FRURfVEhSRUFEUzxicj4KJmd0OyAt
wqAgwqAgwqBpZiAoZ190aHJlYWRfc3VwcG9ydGVkKCkgPT0gRkFMU0UpPGJyPgomZ3Q7IC3CoCDC
oCDCoCDCoCDCoCDCoCDCoGdfdGhyZWFkX2luaXQoTlVMTCk7PGJyPgomZ3Q7IC0jZW5kaWY8YnI+
CiZndDsgLTxicj4KPGJyPgpXaHk/IFRoaXMgaXMgY29tcGxldGVseSB1bnJlbGF0ZWQgYW5kIGNh
biBiZSB0dXJuZWQgb2ZmIHZpYSBjb25maWd1cmUuPGJyPgo8YnI+CiZndDvCoCDCoCDCoCDCoGNv
bnRleHQgPSBnX29wdGlvbl9jb250ZXh0X25ldyhOVUxMKTs8YnI+CiZndDvCoCDCoCDCoCDCoGdf
b3B0aW9uX2NvbnRleHRfYWRkX21haW5fZW50cmllcyhjb250ZXh0LCBvcHRpb25zLCBOVUxMKTs8
YnI+CiZndDvCoCDCoDxicj4KJmd0OyA8YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGFncmVlIGl0IGlzIHVucmVsYXRlZCwgSSB3aWxsIHBvc3QgYSBzZXBhcmF0ZSBw
b3N0LCBidXQgSSB0dXJuIG9uIE5FRURfVEhSRUFEUywgYW5kIHRoZSBidWlsZCBmYWlscy4gTG9v
a2luZyBhdCB0aGUgZ190aHJlYWQgZG9jdW1lbnRhdGlvbnMsIG5vd2FkYXlzIGl0IGhhcyB0byBj
b21lIG91dCBvZiB0aGUgY29kZTo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxwIHN0eWxlPSJt
YXJnaW46MHB4O3BhZGRpbmc6MHB4O2JvcmRlcjowcHg7Zm9udC1zaXplOjE0cHg7dmVydGljYWwt
YWxpZ246YmFzZWxpbmU7YmFja2dyb3VuZDp0cmFuc3BhcmVudDtjb2xvcjpyZ2IoODUsODUsODUp
O2ZvbnQtZmFtaWx5OkNhbnRhcmVsbCwmcXVvdDtEcm9pZCBTYW5zJnF1b3Q7LFVidW50dSwmcXVv
dDtEZWphVnUgU2FucyZxdW90OyxBcmlhbCxzYW5zLXNlcmlmIj48Y29kZSBjbGFzcz0iZ21haWwt
bGl0ZXJhbCIgc3R5bGU9Im1hcmdpbjowcHg7cGFkZGluZzoxcHg7Ym9yZGVyOjBweDt2ZXJ0aWNh
bC1hbGlnbjpiYXNlbGluZTtiYWNrZ3JvdW5kOnJnYmEoMCwwLDAsMC4xKSI+Z190aHJlYWRfaW5p
dDwvY29kZT7CoGhhcyBiZWVuIGRlcHJlY2F0ZWQgc2luY2UgdmVyc2lvbiAyLjMyIGFuZCBzaG91
bGQgbm90IGJlIHVzZWQgaW4gbmV3bHktd3JpdHRlbiBjb2RlLjwvcD48cCBzdHlsZT0ibWFyZ2lu
OjBweDtwYWRkaW5nOjBweDtib3JkZXI6MHB4O2ZvbnQtc2l6ZToxNHB4O3ZlcnRpY2FsLWFsaWdu
OmJhc2VsaW5lO2JhY2tncm91bmQ6dHJhbnNwYXJlbnQ7Y29sb3I6cmdiKDg1LDg1LDg1KTtmb250
LWZhbWlseTpDYW50YXJlbGwsJnF1b3Q7RHJvaWQgU2FucyZxdW90OyxVYnVudHUsJnF1b3Q7RGVq
YVZ1IFNhbnMmcXVvdDssQXJpYWwsc2Fucy1zZXJpZiI+VGhpcyBmdW5jdGlvbiBpcyBubyBsb25n
ZXIgbmVjZXNzYXJ5LiBUaGUgR0xpYiB0aHJlYWRpbmcgc3lzdGVtIGlzIGF1dG9tYXRpY2FsbHkg
aW5pdGlhbGl6ZWQgYXQgdGhlIHN0YXJ0IG9mIHlvdXIgcHJvZ3JhbS48L3A+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2PjwvZGl2Pgo=

--===============6581181898024812746==--

