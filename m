Content-Type: multipart/mixed; boundary="===============7106627051722955429=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: Re: [PATCH 1/3] gprs: Add DBus method to reset contexts
Date: Mon, 18 May 2015 08:53:24 +0200
Message-ID: <CACM4vuDtBm0T9fwftYino6RYz=+MAXEQSQJqg+JYnaNpoi5y=g@mail.gmail.com>
In-Reply-To: <555559BE.8090805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7106627051722955429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, May 15, 2015 at 4:28 AM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Alfonso,
>
> On 05/14/2015 11:39 AM, Alfonso Sanchez-Beato wrote:
>
>> Add DBus method that removes the current contexts and re-provisions
>> using the APN database.
>> ---
>>   src/gprs.c | 144
>> ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 120 insertions(+), 24 deletions(-)
>>
>>
> Looks okay to me, just a couple of small nitpicks:
>
>  diff --git a/src/gprs.c b/src/gprs.c
>> index 05ab499..de57b14 100644
>> --- a/src/gprs.c
>> +++ b/src/gprs.c
>> @@ -149,6 +149,8 @@ struct pri_context {
>>
>>   static void gprs_netreg_update(struct ofono_gprs *gprs);
>>   static void gprs_deactivate_next(struct ofono_gprs *gprs);
>> +static void provision_contexts(struct ofono_gprs *gprs, const char *mcc,
>> +                               const char *mnc, const char *spn);
>>
>
> Our preference is not to have forward declarations of static functions
> unless absolutely necessary (e.g. circular dependencies).  Can we move
> provision_contexts up to avoid this?  Feel free to do this in a separate
> commit if this makes things clearer.
>
>
>>   static GSList *g_drivers =3D NULL;
>>   static GSList *g_context_drivers =3D NULL;
>> @@ -1885,6 +1887,38 @@ static struct pri_context *add_context(struct
>> ofono_gprs *gprs,
>>         return context;
>>   }
>>
>> +static void send_context_added_signal(struct ofono_gprs *gprs,
>> +                                       struct pri_context *context,
>> +                                       DBusConnection *conn)
>> +{
>> +       const char *path;
>> +       DBusMessage *signal;
>> +
>> +       path =3D __ofono_atom_get_path(gprs->atom);
>> +       signal =3D dbus_message_new_signal(path,
>> +
>>  OFONO_CONNECTION_MANAGER_INTERFACE,
>> +                                       "ContextAdded");
>> +
>> +       if (signal) {
>>
>
> Please avoid unnecessary nesting.  It is much easier to read this code if
> it was changed to:
>
> if (!signal)
>         return;
>
>
>  +               DBusMessageIter iter;
>> +               DBusMessageIter dict;
>> +
>> +               dbus_message_iter_init_append(signal, &iter);
>> +
>> +               path =3D context->path;
>> +               dbus_message_iter_append_basic(&iter,
>> DBUS_TYPE_OBJECT_PATH,
>> +                                               &path);
>> +
>> +               dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> +                                       OFONO_PROPERTIES_ARRAY_SIGNATURE,
>> +                                       &dict);
>> +               append_context_properties(context, &dict);
>> +               dbus_message_iter_close_container(&iter, &dict);
>> +
>> +               g_dbus_send_message(conn, signal);
>> +       }
>> +}
>> +
>>   static DBusMessage *gprs_add_context(DBusConnection *conn,
>>                                         DBusMessage *msg, void *data)
>>   {
>> @@ -1894,7 +1928,6 @@ static DBusMessage *gprs_add_context(DBusConnection
>> *conn,
>>         const char *name;
>>         const char *path;
>>         enum ofono_gprs_context_type type;
>> -       DBusMessage *signal;
>>
>>         if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &typestr,
>>                                         DBUS_TYPE_INVALID))
>> @@ -1916,29 +1949,7 @@ static DBusMessage
>> *gprs_add_context(DBusConnection *conn,
>>         g_dbus_send_reply(conn, msg, DBUS_TYPE_OBJECT_PATH, &path,
>>                                         DBUS_TYPE_INVALID);
>>
>> -       path =3D __ofono_atom_get_path(gprs->atom);
>> -       signal =3D dbus_message_new_signal(path,
>> -
>>  OFONO_CONNECTION_MANAGER_INTERFACE,
>> -                                       "ContextAdded");
>> -
>> -       if (signal) {
>> -               DBusMessageIter iter;
>> -               DBusMessageIter dict;
>> -
>> -               dbus_message_iter_init_append(signal, &iter);
>> -
>> -               path =3D context->path;
>> -               dbus_message_iter_append_basic(&iter,
>> DBUS_TYPE_OBJECT_PATH,
>> -                                               &path);
>> -
>> -               dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> -                                       OFONO_PROPERTIES_ARRAY_SIGNATURE,
>> -                                       &dict);
>> -               append_context_properties(context, &dict);
>> -               dbus_message_iter_close_container(&iter, &dict);
>> -
>> -               g_dbus_send_message(conn, signal);
>> -       }
>> +       send_context_added_signal(gprs, context, conn);
>>
>>         return NULL;
>>   }
>> @@ -2173,6 +2184,89 @@ static DBusMessage
>> *gprs_get_contexts(DBusConnection *conn,
>>         return reply;
>>   }
>>
>> +static void remove_non_active_context(struct ofono_gprs *gprs,
>> +                               struct pri_context *ctx, DBusConnection
>> *conn)
>> +{
>> +       char *path;
>> +       const char *atompath;
>> +
>> +       if (gprs->settings) {
>> +               g_key_file_remove_group(gprs->settings, ctx->key, NULL);
>> +               storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
>> +       }
>> +
>> +       /* Make a backup copy of path for signal emission below */
>> +       path =3D g_strdup(ctx->path);
>> +
>> +       context_dbus_unregister(ctx);
>> +       gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
>> +
>> +       atompath =3D __ofono_atom_get_path(gprs->atom);
>> +       g_dbus_emit_signal(conn, atompath,
>> OFONO_CONNECTION_MANAGER_INTERFACE,
>> +                               "ContextRemoved", DBUS_TYPE_OBJECT_PATH,
>> &path,
>> +                               DBUS_TYPE_INVALID);
>> +       g_free(path);
>> +}
>> +
>> +static DBusMessage *gprs_reset_contexts(DBusConnection *conn,
>> +                                       DBusMessage *msg, void *data)
>> +{
>> +       struct ofono_gprs *gprs =3D data;
>> +       struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>> +       struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM,
>> modem);
>> +       DBusMessage *reply;
>> +       GSList *l;
>> +
>> +       if (gprs->pending)
>> +               return __ofono_error_busy(msg);
>> +
>> +       for (l =3D gprs->contexts; l; l =3D l->next) {
>> +               struct pri_context *ctx =3D l->data;
>> +
>> +               if (ctx->pending)
>> +                       return __ofono_error_busy(msg);
>> +       }
>> +
>> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
>> +               return __ofono_error_invalid_args(msg);
>> +
>> +       if (gprs->powered)
>> +               return __ofono_error_not_allowed(msg);
>> +
>> +       for (l =3D gprs->contexts; l; l =3D l->next) {
>> +               struct pri_context *ctx =3D l->data;
>> +
>> +               if (ctx->active)
>> +                       return __ofono_error_not_allowed(msg);
>>
>
> Is there a particular reason you're running through the list of contexts
> again here?  Why not check for ctx->active at the same time as ctx->pendi=
ng?


I wanted to make sure that __ofono_error_busy was returned before
__ofono_error_not_allowed if one context was busy and another one was
active, for instance. Not that I feel is really important and I can change
this if the other way is preferred.


>
>
>  +       }
>> +
>> +       reply =3D dbus_message_new_method_return(msg);
>> +       if (reply =3D=3D NULL)
>> +               return NULL;
>> +
>> +       /* Remove first the current contexts, re-provision after */
>> +
>> +       while (gprs->contexts !=3D NULL) {
>> +               struct pri_context *ctx =3D gprs->contexts->data;
>> +               remove_non_active_context(gprs, ctx, conn);
>> +       }
>> +
>> +       gprs->last_context_id =3D 0;
>> +
>> +       provision_contexts(gprs, ofono_sim_get_mcc(sim),
>> +                               ofono_sim_get_mnc(sim),
>> ofono_sim_get_spn(sim));
>> +
>> +       if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed=
 */
>> +               add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET=
);
>> +
>> +       for (l =3D gprs->contexts; l; l =3D l->next) {
>> +               struct pri_context *ctx =3D l->data;
>> +               send_context_added_signal(gprs, ctx, conn);
>> +       }
>> +
>> +       return reply;
>> +}
>> +
>>   static const GDBusMethodTable manager_methods[] =3D {
>>         { GDBUS_METHOD("GetProperties",
>>                         NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
>> @@ -2192,6 +2286,8 @@ static const GDBusMethodTable manager_methods[] =
=3D {
>>         { GDBUS_METHOD("GetContexts", NULL,
>>                         GDBUS_ARGS({ "contexts_with_properties",
>> "a(oa{sv})" }),
>>                         gprs_get_contexts) },
>> +       { GDBUS_ASYNC_METHOD("ResetContexts", NULL, NULL,
>> +                       gprs_reset_contexts) },
>>         { }
>>   };
>>
>>
>>
> Regards,
> -Denis
>

Thanks for the comments, I have re-submitted the patches addressing the
issues pointed out above.

Br,
Alfonso


> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============7106627051722955429==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXMsPGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgTWF5IDE1LCAyMDE1IGF0IDQ6MjggQU0s
IERlbmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2Vu
ekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9z
cGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1j
b2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPkhpIEFsZm9uc28sPHNwYW4gY2xhc3M9IiI+PGJyPgo8YnI+Ck9uIDA1LzE0LzIwMTUg
MTE6MzkgQU0sIEFsZm9uc28gU2FuY2hlei1CZWF0byB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXIt
bGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KQWRkIERCdXMgbWV0aG9kIHRoYXQg
cmVtb3ZlcyB0aGUgY3VycmVudCBjb250ZXh0cyBhbmQgcmUtcHJvdmlzaW9uczxicj4KdXNpbmcg
dGhlIEFQTiBkYXRhYmFzZS48YnI+Ci0tLTxicj4KwqAgc3JjL2dwcnMuYyB8IDE0NCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tPGJy
PgrCoCAxIGZpbGUgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKTxi
cj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+Ckxvb2tzIG9rYXkgdG8gbWUsIGp1c3Qg
YSBjb3VwbGUgb2Ygc21hbGwgbml0cGlja3M6PHNwYW4gY2xhc3M9IiI+PGJyPgo8YnI+CjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0
KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KZGlmZiAtLWdpdCBh
L3NyYy9ncHJzLmMgYi9zcmMvZ3Bycy5jPGJyPgppbmRleCAwNWFiNDk5Li5kZTU3YjE0IDEwMDY0
NDxicj4KLS0tIGEvc3JjL2dwcnMuYzxicj4KKysrIGIvc3JjL2dwcnMuYzxicj4KQEAgLTE0OSw2
ICsxNDksOCBAQCBzdHJ1Y3QgcHJpX2NvbnRleHQgezxicj4KPGJyPgrCoCBzdGF0aWMgdm9pZCBn
cHJzX25ldHJlZ191cGRhdGUoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpOzxicj4KwqAgc3RhdGlj
IHZvaWQgZ3Byc19kZWFjdGl2YXRlX25leHQoc3RydWN0IG9mb25vX2dwcnMgKmdwcnMpOzxicj4K
K3N0YXRpYyB2b2lkIHByb3Zpc2lvbl9jb250ZXh0cyhzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycywg
Y29uc3QgY2hhciAqbWNjLDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY29uc3QgY2hhciAqbW5jLCBjb25zdCBjaGFyICpzcG4pOzxicj4KPC9ibG9j
a3F1b3RlPgo8YnI+PC9zcGFuPgpPdXIgcHJlZmVyZW5jZSBpcyBub3QgdG8gaGF2ZSBmb3J3YXJk
IGRlY2xhcmF0aW9ucyBvZiBzdGF0aWMgZnVuY3Rpb25zIHVubGVzcyBhYnNvbHV0ZWx5IG5lY2Vz
c2FyeSAoZS5nLiBjaXJjdWxhciBkZXBlbmRlbmNpZXMpLsKgIENhbiB3ZSBtb3ZlIHByb3Zpc2lv
bl9jb250ZXh0cyB1cCB0byBhdm9pZCB0aGlzP8KgIEZlZWwgZnJlZSB0byBkbyB0aGlzIGluIGEg
c2VwYXJhdGUgY29tbWl0IGlmIHRoaXMgbWFrZXMgdGhpbmdzIGNsZWFyZXIuPHNwYW4gY2xhc3M9
IiI+PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29s
b3I6cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4KPGJyPgrCoCBzdGF0aWMgR1NMaXN0ICpnX2RyaXZlcnMgPSBOVUxMOzxicj4KwqAgc3Rh
dGljIEdTTGlzdCAqZ19jb250ZXh0X2RyaXZlcnMgPSBOVUxMOzxicj4KQEAgLTE4ODUsNiArMTg4
NywzOCBAQCBzdGF0aWMgc3RydWN0IHByaV9jb250ZXh0ICphZGRfY29udGV4dChzdHJ1Y3Qgb2Zv
bm9fZ3BycyAqZ3Bycyw8YnI+CsKgIMKgIMKgIMKgIHJldHVybiBjb250ZXh0Ozxicj4KwqAgfTxi
cj4KPGJyPgorc3RhdGljIHZvaWQgc2VuZF9jb250ZXh0X2FkZGVkX3NpZ25hbChzdHJ1Y3Qgb2Zv
bm9fZ3BycyAqZ3Bycyw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBwcmlfY29udGV4dCAqY29udGV4dCw8YnI+CivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oERCdXNDb25uZWN0aW9uICpjb25uKTxicj4KK3s8YnI+CivCoCDCoCDCoCDCoGNvbnN0IGNoYXIg
KnBhdGg7PGJyPgorwqAgwqAgwqAgwqBEQnVzTWVzc2FnZSAqc2lnbmFsOzxicj4KKzxicj4KK8Kg
IMKgIMKgIMKgcGF0aCA9IF9fb2Zvbm9fYXRvbV9nZXRfcGF0aChncHJzLSZndDthdG9tKTs8YnI+
CivCoCDCoCDCoCDCoHNpZ25hbCA9IGRidXNfbWVzc2FnZV9uZXdfc2lnbmFsKHBhdGgsPGJyPgor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBPRk9OT19DT05ORUNUSU9OX01BTkFHRVJfSU5URVJGQUNFLDxicj4KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7Q29udGV4
dEFkZGVkJnF1b3Q7KTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmIChzaWduYWwpIHs8YnI+Cjwv
YmxvY2txdW90ZT4KPGJyPjwvc3Bhbj4KUGxlYXNlIGF2b2lkIHVubmVjZXNzYXJ5IG5lc3Rpbmcu
wqAgSXQgaXMgbXVjaCBlYXNpZXIgdG8gcmVhZCB0aGlzIGNvZGUgaWYgaXQgd2FzIGNoYW5nZWQg
dG86PGJyPgo8YnI+CmlmICghc2lnbmFsKTxicj4KwqAgwqAgwqAgwqAgcmV0dXJuOzxkaXY+PGRp
diBjbGFzcz0iaDUiPjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRl
ci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERCdXNNZXNzYWdlSXRlciBp
dGVyOzxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREJ1c01lc3NhZ2VJdGVyIGRpY3Q7PGJy
PgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9pbml0X2Fw
cGVuZChzaWduYWwsICZhbXA7aXRlcik7PGJyPgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBwYXRoID0gY29udGV4dC0mZ3Q7cGF0aDs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRi
dXNfbWVzc2FnZV9pdGVyX2FwcGVuZF9iYXNpYygmYW1wO2l0ZXIsIERCVVNfVFlQRV9PQkpFQ1Rf
UEFUSCw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7cGF0aCk7PGJyPgorPGJyPgorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBkYnVzX21lc3NhZ2VfaXRlcl9vcGVuX2NvbnRhaW5lcigmYW1wO2l0ZXIs
IERCVVNfVFlQRV9BUlJBWSw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX1BST1BFUlRJRVNfQVJSQVlfU0lHTkFUVVJF
LDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgJmFtcDtkaWN0KTs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFwcGVuZF9j
b250ZXh0X3Byb3BlcnRpZXMoY29udGV4dCwgJmFtcDtkaWN0KTs8YnI+CivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRidXNfbWVzc2FnZV9pdGVyX2Nsb3NlX2NvbnRhaW5lcigmYW1wO2l0ZXIsICZh
bXA7ZGljdCk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2RidXNfc2VuZF9t
ZXNzYWdlKGNvbm4sIHNpZ25hbCk7PGJyPgorwqAgwqAgwqAgwqB9PGJyPgorfTxicj4KKzxicj4K
wqAgc3RhdGljIERCdXNNZXNzYWdlICpncHJzX2FkZF9jb250ZXh0KERCdXNDb25uZWN0aW9uICpj
b25uLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSk8YnI+CsKgIHs8YnI+CkBA
IC0xODk0LDcgKzE5MjgsNiBAQCBzdGF0aWMgREJ1c01lc3NhZ2UgKmdwcnNfYWRkX2NvbnRleHQo
REJ1c0Nvbm5lY3Rpb24gKmNvbm4sPGJyPgrCoCDCoCDCoCDCoCBjb25zdCBjaGFyICpuYW1lOzxi
cj4KwqAgwqAgwqAgwqAgY29uc3QgY2hhciAqcGF0aDs8YnI+CsKgIMKgIMKgIMKgIGVudW0gb2Zv
bm9fZ3Byc19jb250ZXh0X3R5cGUgdHlwZTs8YnI+Ci3CoCDCoCDCoCDCoERCdXNNZXNzYWdlICpz
aWduYWw7PGJyPgo8YnI+CsKgIMKgIMKgIMKgIGlmICghZGJ1c19tZXNzYWdlX2dldF9hcmdzKG1z
ZywgTlVMTCwgREJVU19UWVBFX1NUUklORywgJmFtcDt0eXBlc3RyLDxicj4KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgREJVU19UWVBF
X0lOVkFMSUQpKTxicj4KQEAgLTE5MTYsMjkgKzE5NDksNyBAQCBzdGF0aWMgREJ1c01lc3NhZ2Ug
KmdwcnNfYWRkX2NvbnRleHQoREJ1c0Nvbm5lY3Rpb24gKmNvbm4sPGJyPgrCoCDCoCDCoCDCoCBn
X2RidXNfc2VuZF9yZXBseShjb25uLCBtc2csIERCVVNfVFlQRV9PQkpFQ1RfUEFUSCwgJmFtcDtw
YXRoLDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgREJVU19UWVBFX0lOVkFMSUQpOzxicj4KPGJyPgotwqAgwqAgwqAgwqBwYXRo
ID0gX19vZm9ub19hdG9tX2dldF9wYXRoKGdwcnMtJmd0O2F0b20pOzxicj4KLcKgIMKgIMKgIMKg
c2lnbmFsID0gZGJ1c19tZXNzYWdlX25ld19zaWduYWwocGF0aCw8YnI+Ci3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE9GT05PX0NPTk5F
Q1RJT05fTUFOQUdFUl9JTlRFUkZBQ0UsPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtDb250ZXh0QWRkZWQmcXVvdDsp
Ozxicj4KLTxicj4KLcKgIMKgIMKgIMKgaWYgKHNpZ25hbCkgezxicj4KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgREJ1c01lc3NhZ2VJdGVyIGl0ZXI7PGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBEQnVzTWVzc2FnZUl0ZXIgZGljdDs8YnI+Ci08YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGRidXNfbWVzc2FnZV9pdGVyX2luaXRfYXBwZW5kKHNpZ25hbCwgJmFtcDtpdGVyKTs8YnI+Ci08
YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhdGggPSBjb250ZXh0LSZndDtwYXRoOzxicj4K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGJ1c19tZXNzYWdlX2l0ZXJfYXBwZW5kX2Jhc2ljKCZh
bXA7aXRlciwgREJVU19UWVBFX09CSkVDVF9QQVRILDxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtw
YXRoKTs8YnI+Ci08YnI+Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRidXNfbWVzc2FnZV9pdGVy
X29wZW5fY29udGFpbmVyKCZhbXA7aXRlciwgREJVU19UWVBFX0FSUkFZLDxicj4KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgT0ZPTk9f
UFJPUEVSVElFU19BUlJBWV9TSUdOQVRVUkUsPGJyPgotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2RpY3QpOzxicj4KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYXBwZW5kX2NvbnRleHRfcHJvcGVydGllcyhjb250ZXh0LCAmYW1w
O2RpY3QpOzxicj4KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGJ1c19tZXNzYWdlX2l0ZXJfY2xv
c2VfY29udGFpbmVyKCZhbXA7aXRlciwgJmFtcDtkaWN0KTs8YnI+Ci08YnI+Ci3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdfZGJ1c19zZW5kX21lc3NhZ2UoY29ubiwgc2lnbmFsKTs8YnI+Ci3CoCDC
oCDCoCDCoH08YnI+CivCoCDCoCDCoCDCoHNlbmRfY29udGV4dF9hZGRlZF9zaWduYWwoZ3Bycywg
Y29udGV4dCwgY29ubik7PGJyPgo8YnI+CsKgIMKgIMKgIMKgIHJldHVybiBOVUxMOzxicj4KwqAg
fTxicj4KQEAgLTIxNzMsNiArMjE4NCw4OSBAQCBzdGF0aWMgREJ1c01lc3NhZ2UgKmdwcnNfZ2V0
X2NvbnRleHRzKERCdXNDb25uZWN0aW9uICpjb25uLDxicj4KwqAgwqAgwqAgwqAgcmV0dXJuIHJl
cGx5Ozxicj4KwqAgfTxicj4KPGJyPgorc3RhdGljIHZvaWQgcmVtb3ZlX25vbl9hY3RpdmVfY29u
dGV4dChzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3Bycyw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBwcmlfY29udGV4dCAqY3R4LCBEQnVzQ29u
bmVjdGlvbiAqY29ubik8YnI+Cit7PGJyPgorwqAgwqAgwqAgwqBjaGFyICpwYXRoOzxicj4KK8Kg
IMKgIMKgIMKgY29uc3QgY2hhciAqYXRvbXBhdGg7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBpZiAo
Z3Bycy0mZ3Q7c2V0dGluZ3MpIHs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdfa2V5X2Zp
bGVfcmVtb3ZlX2dyb3VwKGdwcnMtJmd0O3NldHRpbmdzLCBjdHgtJmd0O2tleSwgTlVMTCk7PGJy
PgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdG9yYWdlX3N5bmMoZ3Bycy0mZ3Q7aW1zaSwgU0VU
VElOR1NfU1RPUkUsIGdwcnMtJmd0O3NldHRpbmdzKTs8YnI+CivCoCDCoCDCoCDCoH08YnI+Cis8
YnI+CivCoCDCoCDCoCDCoC8qIE1ha2UgYSBiYWNrdXAgY29weSBvZiBwYXRoIGZvciBzaWduYWwg
ZW1pc3Npb24gYmVsb3cgKi88YnI+CivCoCDCoCDCoCDCoHBhdGggPSBnX3N0cmR1cChjdHgtJmd0
O3BhdGgpOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgY29udGV4dF9kYnVzX3VucmVnaXN0ZXIoY3R4
KTs8YnI+CivCoCDCoCDCoCDCoGdwcnMtJmd0O2NvbnRleHRzID0gZ19zbGlzdF9yZW1vdmUoZ3By
cy0mZ3Q7Y29udGV4dHMsIGN0eCk7PGJyPgorPGJyPgorwqAgwqAgwqAgwqBhdG9tcGF0aCA9IF9f
b2Zvbm9fYXRvbV9nZXRfcGF0aChncHJzLSZndDthdG9tKTs8YnI+CivCoCDCoCDCoCDCoGdfZGJ1
c19lbWl0X3NpZ25hbChjb25uLCBhdG9tcGF0aCwgT0ZPTk9fQ09OTkVDVElPTl9NQU5BR0VSX0lO
VEVSRkFDRSw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCZxdW90O0NvbnRleHRSZW1vdmVkJnF1b3Q7LCBEQlVTX1RZUEVfT0JKRUNUX1BBVEgsICZh
bXA7cGF0aCw8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoERCVVNfVFlQRV9JTlZBTElEKTs8YnI+CivCoCDCoCDCoCDCoGdfZnJlZShwYXRoKTs8YnI+
Cit9PGJyPgorPGJyPgorc3RhdGljIERCdXNNZXNzYWdlICpncHJzX3Jlc2V0X2NvbnRleHRzKERC
dXNDb25uZWN0aW9uICpjb25uLDxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREJ1c01lc3NhZ2UgKm1zZywgdm9pZCAqZGF0YSk8
YnI+Cit7PGJyPgorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fZ3BycyAqZ3BycyA9IGRhdGE7PGJy
PgorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gX19vZm9ub19hdG9tX2dl
dF9tb2RlbShncHJzLSZndDthdG9tKTs8YnI+CivCoCDCoCDCoCDCoHN0cnVjdCBvZm9ub19zaW0g
KnNpbSA9IF9fb2Zvbm9fYXRvbV9maW5kKE9GT05PX0FUT01fVFlQRV9TSU0sIG1vZGVtKTs8YnI+
CivCoCDCoCDCoCDCoERCdXNNZXNzYWdlICpyZXBseTs8YnI+CivCoCDCoCDCoCDCoEdTTGlzdCAq
bDs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmIChncHJzLSZndDtwZW5kaW5nKTxicj4KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3JfYnVzeShtc2cpOzxicj4KKzxi
cj4KK8KgIMKgIMKgIMKgZm9yIChsID0gZ3Bycy0mZ3Q7Y29udGV4dHM7IGw7IGwgPSBsLSZndDtu
ZXh0KSB7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgcHJpX2NvbnRleHQgKmN0
eCA9IGwtJmd0O2RhdGE7PGJyPgorPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoY3R4
LSZndDtwZW5kaW5nKTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuIF9fb2Zvbm9fZXJyb3JfYnVzeShtc2cpOzxicj4KK8KgIMKgIMKgIMKgfTxicj4KKzxicj4K
K8KgIMKgIMKgIMKgaWYgKCFkYnVzX21lc3NhZ2VfZ2V0X2FyZ3MobXNnLCBOVUxMLCBEQlVTX1RZ
UEVfSU5WQUxJRCkpPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gX19vZm9ub19l
cnJvcl9pbnZhbGlkX2FyZ3MobXNnKTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmIChncHJzLSZn
dDtwb3dlcmVkKTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJy
b3Jfbm90X2FsbG93ZWQobXNnKTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGZvciAobCA9IGdwcnMt
Jmd0O2NvbnRleHRzOyBsOyBsID0gbC0mZ3Q7bmV4dCkgezxicj4KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3RydWN0IHByaV9jb250ZXh0ICpjdHggPSBsLSZndDtkYXRhOzxicj4KKzxicj4KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGN0eC0mZ3Q7YWN0aXZlKTxicj4KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIF9fb2Zvbm9fZXJyb3Jfbm90X2FsbG93ZWQo
bXNnKTs8YnI+CjwvYmxvY2txdW90ZT4KPGJyPjwvZGl2PjwvZGl2PgpJcyB0aGVyZSBhIHBhcnRp
Y3VsYXIgcmVhc29uIHlvdSYjMzk7cmUgcnVubmluZyB0aHJvdWdoIHRoZSBsaXN0IG9mIGNvbnRl
eHRzIGFnYWluIGhlcmU/wqAgV2h5IG5vdCBjaGVjayBmb3IgY3R4LSZndDthY3RpdmUgYXQgdGhl
IHNhbWUgdGltZSBhcyBjdHgtJmd0O3BlbmRpbmc/PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSB3YW50ZWQgdG8gbWFrZSBzdXJlIHRoYXTCoF9fb2Zvbm9fZXJyb3JfYnVzeSB3YXMg
cmV0dXJuZWQgYmVmb3JlIF9fb2Zvbm9fZXJyb3Jfbm90X2FsbG93ZWQgaWYgb25lIGNvbnRleHQg
d2FzIGJ1c3kgYW5kIGFub3RoZXIgb25lIHdhcyBhY3RpdmUsIGZvciBpbnN0YW5jZS4gTm90IHRo
YXQgSSBmZWVsIGlzIHJlYWxseSBpbXBvcnRhbnQgYW5kIEkgY2FuIGNoYW5nZSB0aGlzIGlmIHRo
ZSBvdGhlciB3YXkgaXMgcHJlZmVycmVkLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVy
LWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48ZGl2IGNsYXNzPSJoNSI+
PGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9yZGVyLWxlZnQtY29sb3I6
cmdiKDIwNCwyMDQsMjA0KTtib3JkZXItbGVmdC1zdHlsZTpzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij4KK8KgIMKgIMKgIMKgfTxicj4KKzxicj4KK8KgIMKgIMKgIMKgcmVwbHkgPSBkYnVzX21lc3Nh
Z2VfbmV3X21ldGhvZF9yZXR1cm4obXNnKTs8YnI+CivCoCDCoCDCoCDCoGlmIChyZXBseSA9PSBO
VUxMKTxicj4KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPgorPGJyPgor
wqAgwqAgwqAgwqAvKiBSZW1vdmUgZmlyc3QgdGhlIGN1cnJlbnQgY29udGV4dHMsIHJlLXByb3Zp
c2lvbiBhZnRlciAqLzxicj4KKzxicj4KK8KgIMKgIMKgIMKgd2hpbGUgKGdwcnMtJmd0O2NvbnRl
eHRzICE9IE5VTEwpIHs8YnI+CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBwcmlfY29u
dGV4dCAqY3R4ID0gZ3Bycy0mZ3Q7Y29udGV4dHMtJmd0O2RhdGE7PGJyPgorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZW1vdmVfbm9uX2FjdGl2ZV9jb250ZXh0KGdwcnMsIGN0eCwgY29ubik7PGJy
PgorwqAgwqAgwqAgwqB9PGJyPgorPGJyPgorwqAgwqAgwqAgwqBncHJzLSZndDtsYXN0X2NvbnRl
eHRfaWQgPSAwOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgcHJvdmlzaW9uX2NvbnRleHRzKGdwcnMs
IG9mb25vX3NpbV9nZXRfbWNjKHNpbSksPGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBvZm9ub19zaW1fZ2V0X21uYyhzaW0pLCBvZm9ub19zaW1fZ2V0
X3NwbihzaW0pKTs8YnI+Cis8YnI+CivCoCDCoCDCoCDCoGlmIChncHJzLSZndDtjb250ZXh0cyA9
PSBOVUxMKSAvKiBBdXRvbWF0aWMgcHJvdmlzaW9uaW5nIGZhaWxlZCAqLzxicj4KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYWRkX2NvbnRleHQoZ3BycywgTlVMTCwgT0ZPTk9fR1BSU19DT05URVhU
X1RZUEVfSU5URVJORVQpOzxicj4KKzxicj4KK8KgIMKgIMKgIMKgZm9yIChsID0gZ3Bycy0mZ3Q7
Y29udGV4dHM7IGw7IGwgPSBsLSZndDtuZXh0KSB7PGJyPgorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdHJ1Y3QgcHJpX2NvbnRleHQgKmN0eCA9IGwtJmd0O2RhdGE7PGJyPgorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBzZW5kX2NvbnRleHRfYWRkZWRfc2lnbmFsKGdwcnMsIGN0eCwgY29ubik7PGJy
PgorwqAgwqAgwqAgwqB9PGJyPgorPGJyPgorwqAgwqAgwqAgwqByZXR1cm4gcmVwbHk7PGJyPgor
fTxicj4KKzxicj4KwqAgc3RhdGljIGNvbnN0IEdEQnVzTWV0aG9kVGFibGUgbWFuYWdlcl9tZXRo
b2RzW10gPSB7PGJyPgrCoCDCoCDCoCDCoCB7IEdEQlVTX01FVEhPRCgmcXVvdDtHZXRQcm9wZXJ0
aWVzJnF1b3Q7LDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwg
R0RCVVNfQVJHUyh7ICZxdW90O3Byb3BlcnRpZXMmcXVvdDssICZxdW90O2F7c3Z9JnF1b3Q7IH0p
LDxicj4KQEAgLTIxOTIsNiArMjI4Niw4IEBAIHN0YXRpYyBjb25zdCBHREJ1c01ldGhvZFRhYmxl
IG1hbmFnZXJfbWV0aG9kc1tdID0gezxicj4KwqAgwqAgwqAgwqAgeyBHREJVU19NRVRIT0QoJnF1
b3Q7R2V0Q29udGV4dHMmcXVvdDssIE5VTEwsPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBHREJVU19BUkdTKHsgJnF1b3Q7Y29udGV4dHNfd2l0aF9wcm9wZXJ0aWVzJnF1
b3Q7LCAmcXVvdDthKG9he3N2fSkmcXVvdDsgfSksPGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBncHJzX2dldF9jb250ZXh0cykgfSw8YnI+CivCoCDCoCDCoCDCoHsgR0RC
VVNfQVNZTkNfTUVUSE9EKCZxdW90O1Jlc2V0Q29udGV4dHMmcXVvdDssIE5VTEwsIE5VTEwsPGJy
PgorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJzX3Jlc2V0X2NvbnRleHRz
KSB9LDxicj4KwqAgwqAgwqAgwqAgeyB9PGJyPgrCoCB9Ozxicj4KPGJyPgo8YnI+CjwvYmxvY2tx
dW90ZT4KPGJyPjwvZGl2PjwvZGl2PgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLCBJIGhhdmUgcmUt
c3VibWl0dGVkIHRoZSBwYXRjaGVzIGFkZHJlc3NpbmcgdGhlIGlzc3VlcyBwb2ludGVkIG91dCBh
Ym92ZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJyLDwvZGl2PjxkaXY+QWxmb25zbzwvZGl2
PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNv
bG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJy
PgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmci
IHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczov
L2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+
aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============7106627051722955429==--

