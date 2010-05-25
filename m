Content-Type: multipart/mixed; boundary="===============1436847866161355031=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 5/9] Move bluetooth utils from hfp.c to bluetooth.c
Date: Tue, 25 May 2010 18:17:00 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E923668@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1274771888-2565-6-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1436847866161355031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
> --- plugins/bluetooth.c |  482
> +++++++++++++++++++++++++++++++++++++++++++++++++++
> plugins/hfp.c       |  458
> ++++--------------------------------------------
> 2 files changed, 518 insertions(+), 422 deletions(-)
>
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index b4fe676..fc89579 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> +
> int bluetooth_register_uuid(const char *uuid, struct
> bluetooth_profile *profile) {
> +     int err;
> +
>       if (uuid_hash)
>               goto done;
>
>       connection =3D ofono_dbus_get_connection();
>
> +     bluetooth_watch =3D g_dbus_add_service_watch(connection,
> BLUEZ_SERVICE, +                                      NULL,
> bluetooth_disconnect, NULL, NULL);
> +
> +     adapter_added_watch =3D
> g_dbus_add_signal_watch(connection, NULL, NULL,
> +                                             BLUEZ_MANAGER_INTERFACE,
> +                                             "AdapterAdded",
> +                                             adapter_added,
> NULL, NULL);
> +
> +     adapter_removed_watch =3D
> g_dbus_add_signal_watch(connection, NULL, NULL,
> +                                             BLUEZ_MANAGER_INTERFACE,
> +                                             "AdapterRemoved",
> +
> adapter_removed, NULL, NULL);
> +
> +     property_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
> +                                             BLUEZ_DEVICE_INTERFACE,
> +                                             "PropertyChanged",
> +
> property_changed, NULL, NULL);
> +
> +     if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
> +                     adapter_removed_watch =3D=3D 0 ||
> property_watch =3D=3D 0) {
> +             err =3D -EIO;
> +             goto remove;
> +     }

I may introduce API to register service like bluetooth_register_service() l=
ater. So I wonder if we could put above the initialization code into blueto=
oth_init(). I'd like to introduce a hash table similar with uuid_hash so uu=
id_hash is NULL in my case.

>       uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> g_free, NULL);
>
> @@ -56,7 +521,19 @@ int bluetooth_register_uuid(const char
> *uuid, struct bluetooth_profile *profile)
> done:
>       g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
>
> +     send_method_call_with_reply(BLUEZ_SERVICE, "/",
> +                             BLUEZ_MANAGER_INTERFACE,
> "GetProperties",
> +                             manager_properties_cb, NULL, NULL, -1,
> +                             DBUS_TYPE_INVALID);
> +
>       return 0;
> +
> +remove:
> +     g_dbus_remove_watch(connection, bluetooth_watch);
> +     g_dbus_remove_watch(connection, adapter_added_watch);
> +     g_dbus_remove_watch(connection, adapter_removed_watch);
> +     g_dbus_remove_watch(connection, property_watch);
> +     return err;
> }
>
> void bluetooth_unregister_uuid(const char *uuid)
> @@ -66,6 +543,11 @@ void bluetooth_unregister_uuid(const char *uuid)
>       if (g_hash_table_size(uuid_hash))
>               return;
>
> +     g_dbus_remove_watch(connection, bluetooth_watch);
> +     g_dbus_remove_watch(connection, adapter_added_watch);
> +     g_dbus_remove_watch(connection, adapter_removed_watch);
> +     g_dbus_remove_watch(connection, property_watch);
> +
>       g_hash_table_destroy(uuid_hash);
>       g_hash_table_destroy(adapter_address_hash);
>       uuid_hash =3D NULL;

Can we move g_dbus_remove_watch() to bluetooth_exit() as well?

> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index aca6b4e..12e7daf 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -62,8 +62,7 @@ static const char *cmer_prefix[] =3D { "+CMER:", NULL
> }; static const char *chld_prefix[] =3D { "+CHLD:", NULL };
>
> static DBusConnection *connection;
> -static GHashTable *uuid_hash =3D NULL;
> -static GHashTable *adapter_address_hash;
> +static GHashTable *modem_hash =3D NULL;
>
> static void hfp_debug(const char *str, void *user_data) {
> @@ -259,101 +258,6 @@ fail:
>       return err;
> }
>
> -typedef void (*PropertyHandler)(DBusMessageIter *iter,
> gpointer user_data);
> -
> -struct property_handler {
> -     const char *property;
> -     PropertyHandler callback;
> -     gpointer user_data;
> -};
> -
> -static gint property_handler_compare(gconstpointer a, gconstpointer
> b) -{
> -     const struct property_handler *handler =3D a;
> -     const char *property =3D b;
> -
> -     return strcmp(handler->property, property);
> -}
> -
> -static void parse_properties_reply(DBusMessage *reply,
> -                                     const char *property, ...)
> -{
> -     va_list args;
> -     GSList *prop_handlers =3D NULL;
> -     DBusMessageIter array, dict;
> -
> -     va_start(args, property);
> -
> -     while (property !=3D NULL) {
> -             struct property_handler *handler =3D
> -                                     g_new0(struct
> property_handler, 1);
> -
> -             handler->property =3D property;
> -             handler->callback =3D va_arg(args, PropertyHandler);
> -             handler->user_data =3D va_arg(args, gpointer);
> -
> -             property =3D va_arg(args, const char *);
> -
> -             prop_handlers =3D g_slist_prepend(prop_handlers, handler);
> -     }
> -
> -     va_end(args);
> -
> -     if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
> -             goto done;
> -
> -     if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
> -             goto done;
> -
> -     dbus_message_iter_recurse(&array, &dict);
> -
> -     while (dbus_message_iter_get_arg_type(&dict) =3D=3D
> DBUS_TYPE_DICT_ENTRY) {
> -             DBusMessageIter entry, value;
> -             const char *key;
> -             GSList *l;
> -
> -             dbus_message_iter_recurse(&dict, &entry);
> -
> -             if (dbus_message_iter_get_arg_type(&entry) !=3D
> DBUS_TYPE_STRING)
> -                     goto done;
> -
> -             dbus_message_iter_get_basic(&entry, &key);
> -
> -             dbus_message_iter_next(&entry);
> -
> -             if (dbus_message_iter_get_arg_type(&entry) !=3D
> DBUS_TYPE_VARIANT)
> -                     goto done;
> -
> -             dbus_message_iter_recurse(&entry, &value);
> -
> -             l =3D g_slist_find_custom(prop_handlers, key,
> -                                     property_handler_compare);
> -
> -             if (l) {
> -                     struct property_handler *handler =3D l->data;
> -
> -                     handler->callback(&value, handler->user_data);
> -             }
> -
> -             dbus_message_iter_next(&dict);
> -     }
> -
> -done:
> -     g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
> -     g_slist_free(prop_handlers);
> -}
> -
> -static void parse_string(DBusMessageIter *iter, gpointer user_data)
> -{
> -     char **str =3D user_data;
> -     int arg_type =3D dbus_message_iter_get_arg_type(iter); -
> -     if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D
> DBUS_TYPE_STRING)
> -             return;
> -
> -     dbus_message_iter_get_basic(iter, str);
> -}
> -
> static void cind_status_cb(gboolean ok, GAtResult *result,
> gpointer user_data) {
> @@ -594,6 +498,10 @@ static int hfp_create_modem(const char
> *device, const char *dev_addr,
>       struct hfp_data *data;
>       char buf[256];
>
> +     /* We already have this device in our hash, ignore */
> +     if (g_hash_table_lookup(modem_hash, device) !=3D NULL) +          r=
eturn
> -EALREADY; +
>       ofono_info("Using device: %s, devaddr: %s, adapter: %s",
>                       device, dev_addr, adapter_addr);
>
> @@ -622,7 +530,7 @@ static int hfp_create_modem(const char
> *device, const char *dev_addr,
>       ofono_modem_set_name(modem, alias);
>       ofono_modem_register(modem);
>
> -     g_hash_table_insert(uuid_hash, g_strdup(device), modem);
> +     g_hash_table_insert(modem_hash, g_strdup(device), modem);
>
>       return 0;
>
> @@ -633,286 +541,35 @@ free:
>       return -ENOMEM;
> }
>
> -static void has_hfp_uuid(DBusMessageIter *array, gpointer user_data)
> -{
> -     gboolean *hfp =3D user_data;
> -     DBusMessageIter value;
> -
> -     if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> -             return;
> -
> -     dbus_message_iter_recurse(array, &value);
> -
> -     while (dbus_message_iter_get_arg_type(&value) =3D=3D
> DBUS_TYPE_STRING) {
> -             const char *uuid;
> -
> -             dbus_message_iter_get_basic(&value, &uuid);
> -
> -             if (!strcasecmp(uuid, HFP_AG_UUID)) {
> -                     *hfp =3D TRUE;
> -                     return;
> -             }
> -
> -             dbus_message_iter_next(&value);
> -     }
> -}
> -
> -static void device_properties_cb(DBusPendingCall *call,
> gpointer user_data)
> -{
> -     DBusMessage *reply;
> -     char *path =3D user_data;
> -     gboolean have_hfp =3D FALSE;
> -     const char *adapter =3D NULL;
> -     const char *adapter_addr =3D NULL;
> -     const char *device_addr =3D NULL;
> -     const char *alias =3D NULL;
> -
> -     reply =3D dbus_pending_call_steal_reply(call);
> -
> -     if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> -             DBG("Bluetooth daemon is apparently not available.");
> -             goto done;
> -     }
> -
> -     if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
> -             if (!dbus_message_is_error(reply,
> DBUS_ERROR_UNKNOWN_METHOD))
> -                     ofono_info("Error from GetProperties reply: %s", -
> dbus_message_get_error_name(reply));
> -
> -             goto done;
> -     }
> -
> -     parse_properties_reply(reply, "UUIDs", has_hfp_uuid, &have_hfp,
> -                             "Adapter", parse_string, &adapter,
> -                             "Address", parse_string, &device_addr,
> -                             "Alias", parse_string, &alias, NULL);
> -
> -     if (adapter)
> -             adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
> -                                                     adapter);
> -
> -     if (have_hfp && device_addr && adapter_addr)
> -             hfp_create_modem(path, device_addr,
> adapter_addr, alias);
> -
> -done:
> -     dbus_message_unref(reply);
> -}
> -
> -static void parse_devices(DBusMessageIter *array, gpointer
> user_data) -{
> -     DBusMessageIter value;
> -     GSList **device_list =3D user_data;
> -
> -     DBG("");
> -
> -     if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
> -             return;
> -
> -     dbus_message_iter_recurse(array, &value);
> -
> -     while (dbus_message_iter_get_arg_type(&value)
> -                     =3D=3D DBUS_TYPE_OBJECT_PATH) {
> -             const char *path;
> -
> -             dbus_message_iter_get_basic(&value, &path);
> -
> -             *device_list =3D g_slist_prepend(*device_list,
> (gpointer) path);
> -
> -             dbus_message_iter_next(&value);
> -     }
> -}
> -
> -static void adapter_properties_cb(DBusPendingCall *call,
> gpointer user_data)
> -{
> -     const char *path =3D user_data;
> -     DBusMessage *reply;
> -     GSList *device_list =3D NULL;
> -     GSList *l;
> -     const char *addr;
> -
> -     reply =3D dbus_pending_call_steal_reply(call);
> -
> -     if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> -             DBG("Bluetooth daemon is apparently not available.");
> -             goto done;
> -     }
> -
> -     parse_properties_reply(reply, "Devices", parse_devices,
> &device_list,
> -                             "Address", parse_string, &addr, NULL);
> -
> -     DBG("Adapter Address: %s, Path: %s", addr, path);
> -     g_hash_table_insert(adapter_address_hash,
> -                             g_strdup(path), g_strdup(addr));
> -
> -     for (l =3D device_list; l; l =3D l->next) {
> -             const char *device =3D l->data;
> -
> -             send_method_call_with_reply(BLUEZ_SERVICE, device,
> -                             BLUEZ_DEVICE_INTERFACE, "GetProperties",
> -                             device_properties_cb,
> g_strdup(device), g_free,
> -                             -1, DBUS_TYPE_INVALID);
> -     }
> -
> -done:
> -     g_slist_free(device_list);
> -     dbus_message_unref(reply);
> -}
> -
> -static gboolean adapter_added(DBusConnection *connection,
> DBusMessage *message,
> -                             void *user_data)
> -{
> -     const char *path;
> -     int ret;
> -
> -     dbus_message_get_args(message, NULL,
> DBUS_TYPE_OBJECT_PATH, &path,
> -                             DBUS_TYPE_INVALID);
> -
> -     ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
> -                     BLUEZ_ADAPTER_INTERFACE, "GetProperties",
> -                     adapter_properties_cb, g_strdup(path), g_free,
> -                     -1, DBUS_TYPE_INVALID);
> -
> -     return TRUE;
> -}
> -
> -static gboolean adapter_removed(DBusConnection *connection,
> -                             DBusMessage *message, void *user_data)
> -{
> -     const char *path;
> -
> -     if (dbus_message_get_args(message, NULL,
> DBUS_TYPE_OBJECT_PATH, &path,
> -                             DBUS_TYPE_INVALID) =3D=3D TRUE)
> -             g_hash_table_remove(adapter_address_hash, path); -
> -     return TRUE;
> -}
> -
> -static gboolean property_changed(DBusConnection *connection,
> DBusMessage *msg,
> -                             void *user_data)
> +static gboolean hfp_remove_each_modem(gpointer key, gpointer
> value, gpointer user_data)
> {
> -     const char *property;
> -     DBusMessageIter iter;
> -
> -     dbus_message_iter_init(msg, &iter);
> -
> -     if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> -             return FALSE;
> -
> -     dbus_message_iter_get_basic(&iter, &property);
> -     if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
> -             gboolean have_hfp =3D FALSE;
> -             const char *path =3D dbus_message_get_path(msg);
> -             DBusMessageIter variant;
> -
> -             /* We already have this device in our hash, ignore */
> -             if (g_hash_table_lookup(uuid_hash, path) !=3D NULL)
> -                     return TRUE;
> -
> -             if (!dbus_message_iter_next(&iter))
> -                     return FALSE;
> -
> -             if (dbus_message_iter_get_arg_type(&iter) !=3D
> DBUS_TYPE_VARIANT)
> -                     return FALSE;
> -
> -             dbus_message_iter_recurse(&iter, &variant);
> -
> -             has_hfp_uuid(&variant, &have_hfp);
> -
> -             /* We need the full set of properties to be
> able to create
> -              * the modem properly, including Adapter and Alias, so
> -              * refetch everything again
> -              */
> -             if (have_hfp)
> -                     send_method_call_with_reply(BLUEZ_SERVICE, path,
> -                             BLUEZ_DEVICE_INTERFACE, "GetProperties",
> -                             device_properties_cb,
> g_strdup(path), g_free,
> -                             -1, DBUS_TYPE_INVALID);
> -     } else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
> -             const char *path =3D dbus_message_get_path(msg);
> -             struct ofono_modem *modem =3D
> -                     g_hash_table_lookup(uuid_hash, path);
> -             const char *alias =3D NULL;
> -             DBusMessageIter variant;
> -
> -             if (modem =3D=3D NULL)
> -                     return TRUE;
> -
> -             if (!dbus_message_iter_next(&iter))
> -                     return FALSE;
> -
> -             if (dbus_message_iter_get_arg_type(&iter) !=3D
> DBUS_TYPE_VARIANT)
> -                     return FALSE;
> -
> -             dbus_message_iter_recurse(&iter, &variant);
> -
> -             parse_string(&variant, &alias);
> +     struct ofono_modem *modem =3D value;
>
> -             ofono_modem_set_name(modem, alias);
> -     }
> +     ofono_modem_remove(modem);
>
>       return TRUE;
> }
>
> -static void parse_adapters(DBusMessageIter *array, gpointer
> user_data) +static void hfp_remove_all_modem()
> {
> -     DBusMessageIter value;
> -
> -     DBG("");
> -
> -     if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY) + if
>               (modem_hash =3D=3D NULL) return;
>
> -     dbus_message_iter_recurse(array, &value);
> -
> -     while (dbus_message_iter_get_arg_type(&value)
> -                     =3D=3D DBUS_TYPE_OBJECT_PATH) {
> -             const char *path;
> -
> -             dbus_message_iter_get_basic(&value, &path);
> -
> -             DBG("Calling GetProperties on %s", path);
> -
> -             send_method_call_with_reply(BLUEZ_SERVICE, path,
> -                             BLUEZ_ADAPTER_INTERFACE,
> "GetProperties",
> -                             adapter_properties_cb,
> g_strdup(path), g_free,
> -                             -1, DBUS_TYPE_INVALID);
> -
> -             dbus_message_iter_next(&value);
> -     }
> -}
> -
> -static void manager_properties_cb(DBusPendingCall *call,
> gpointer user_data)
> -{
> -     DBusMessage *reply;
> -
> -     reply =3D dbus_pending_call_steal_reply(call);
> -
> -     if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
> -             DBG("Bluetooth daemon is apparently not available.");
> -             goto done;
> -     }
> -
> -     parse_properties_reply(reply, "Adapters",
> parse_adapters, NULL, NULL);
> -
> -done:
> -     dbus_message_unref(reply);
> +     g_hash_table_foreach_remove(modem_hash,
> hfp_remove_each_modem, NULL);
> }
>
> -static gboolean hfp_remove_each_modem(gpointer key, gpointer
> value, gpointer user_data)
> +static void hfp_set_alias(const char *device, const char *alias) {
> -     struct ofono_modem *modem =3D value;
> -
> -     ofono_modem_remove(modem);
> +     struct ofono_modem *modem;
>
> -     return TRUE;
> -}
> +     if (!device || !alias)
> +             return;
>
> -static void bluetooth_disconnect(DBusConnection *connection,
> void *user_data)
> -{
> -     if (uuid_hash =3D=3D NULL)
> +     modem =3D g_hash_table_lookup(modem_hash, device);
> +     if (!modem)
>               return;
>
> -     g_hash_table_foreach_remove(uuid_hash,
> hfp_remove_each_modem, NULL);
> +     ofono_modem_set_name(modem, alias);
> }
>
> static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
> @@ -963,7 +620,7 @@ static void hfp_remove(struct ofono_modem *modem)
>               HFP_AGENT_INTERFACE)) hfp_unregister_ofono_handsfree(modem);
>
> -     g_hash_table_remove(uuid_hash, data->handsfree_path);
> +     g_hash_table_remove(modem_hash, data->handsfree_path);
>
>       g_free(data->handsfree_path);
>       g_free(data);
> @@ -1098,10 +755,12 @@ static struct ofono_modem_driver hfp_driver =3D
> {     .post_sim       =3D hfp_post_sim, };
>
> -static guint bluetooth_exit_watch;
> -static guint adapter_added_watch;
> -static guint adapter_removed_watch;
> -static guint uuid_watch;
> +static struct bluetooth_profile hfp_profile =3D {
> +     .name           =3D "hfp",
> +     .create         =3D hfp_create_modem,
> +     .remove_all     =3D hfp_remove_all_modem,
> +     .set_alias      =3D hfp_set_alias,
> +};
>
> static int hfp_init()
> {
> @@ -1112,73 +771,28 @@ static int hfp_init()
>
>       connection =3D ofono_dbus_get_connection();
>
> -     bluetooth_exit_watch =3D
> g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
> -                     NULL, bluetooth_disconnect, NULL, NULL);
> -
> -     adapter_added_watch =3D
> g_dbus_add_signal_watch(connection, NULL, NULL,
> -                                             BLUEZ_MANAGER_INTERFACE,
> -                                             "AdapterAdded",
> -                                             adapter_added,
> NULL, NULL);
> -
> -     adapter_removed_watch =3D
> g_dbus_add_signal_watch(connection, NULL, NULL,
> -                                             BLUEZ_MANAGER_INTERFACE,
> -                                             "AdapterRemoved",
> -
> adapter_removed, NULL, NULL);
> -
> -     uuid_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
> -                                             BLUEZ_DEVICE_INTERFACE,
> -                                             "PropertyChanged",
> -
> property_changed, NULL, NULL);
> +     err =3D ofono_modem_driver_register(&hfp_driver);
> +     if (err < 0)
> +             return err;
>
> -     if (bluetooth_exit_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
> -                     adapter_removed_watch =3D=3D 0|| uuid_watch =3D=3D =
0) {
> -             err =3D -EIO;
> -             goto remove;
> +     err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_profile); +     i=
f (err
> < 0) { +              ofono_modem_driver_unregister(&hfp_driver);
> +             return err;
>       }
>
> -     uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +     modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> g_free, NULL);
>
> -     adapter_address_hash =3D
> g_hash_table_new_full(g_str_hash, g_str_equal,
> -                                                     g_free, g_free);
> -
> -     err =3D ofono_modem_driver_register(&hfp_driver);
> -     if (err < 0)
> -             goto remove;
> -
> -     send_method_call_with_reply(BLUEZ_SERVICE, "/",
> -                             BLUEZ_MANAGER_INTERFACE,
> "GetProperties",
> -                             manager_properties_cb, NULL, NULL, -1,
> -                             DBUS_TYPE_INVALID);
> -
>       return 0;
> -
> -remove:
> -     g_dbus_remove_watch(connection, bluetooth_exit_watch);
> -     g_dbus_remove_watch(connection, adapter_added_watch);
> -     g_dbus_remove_watch(connection, adapter_removed_watch);
> -     g_dbus_remove_watch(connection, uuid_watch);
> -
> -     if (uuid_hash)
> -             g_hash_table_destroy(uuid_hash);
> -
> -     if (adapter_address_hash)
> -             g_hash_table_destroy(adapter_address_hash);
> -
> -     return err;
> }
>
> static void hfp_exit()
> {
> -     g_dbus_remove_watch(connection, bluetooth_exit_watch);
> -     g_dbus_remove_watch(connection, adapter_added_watch);
> -     g_dbus_remove_watch(connection, adapter_removed_watch);
> -     g_dbus_remove_watch(connection, uuid_watch);
> -
> +     bluetooth_unregister_uuid(HFP_AG_UUID);
>       ofono_modem_driver_unregister(&hfp_driver);
>
> -     g_hash_table_destroy(uuid_hash);
> -     g_hash_table_destroy(adapter_address_hash);
> +     g_hash_table_destroy(modem_hash);
> }
>
> OFONO_PLUGIN_DEFINE(hfp, "Hands-Free Profile Plugins", VERSION, --
> 1.7.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============1436847866161355031==--

