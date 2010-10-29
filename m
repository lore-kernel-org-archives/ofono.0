Content-Type: multipart/mixed; boundary="===============3819249627513396343=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 2/3] voicecall: emergency call handling added
Date: Fri, 29 Oct 2010 12:29:46 +0300
Message-ID: <4CCA940A.1050409@nokia.com>
In-Reply-To: <4CC8F28F.6030500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3819249627513396343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thank you for your comments, here is my response.

On 10/28/2010 06:48 AM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 10/25/2010 03:03 AM, Andras Domokos wrote:
>    =

>> From: Andras Domokos<andras.domokos@nokia.com>
>>
>>
>> Signed-off-by: Andras Domokos<andras.domokos@nokia.com>
>> ---
>>   include/voicecall.h |   12 +++
>>   src/voicecall.c     |  221 +++++++++++++++++++++++++++++++++++++++++++=
+++----
>>   2 files changed, 215 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/voicecall.h b/include/voicecall.h
>> index 2356fcf..d530148 100644
>> --- a/include/voicecall.h
>> +++ b/include/voicecall.h
>> @@ -38,6 +38,9 @@ typedef void (*ofono_call_list_cb_t)(const struct ofon=
o_error *error,
>>                                        const struct ofono_call *call_lis=
t,
>>                                        void *data);
>>
>> +typedef void (*ofono_voicecall_emergency_notify_cb_t)(ofono_bool_t stat=
e,
>> +                                                     void *data);
>> +
>>   /* Voice call related functionality, including ATD, ATA, +CHLD, CTFR, =
CLCC
>>    * and VTS.
>>    *
>> @@ -116,6 +119,15 @@ void ofono_voicecall_set_data(struct ofono_voicecal=
l *vc, void *data);
>>   void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
>>   int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
>>
>> +unsigned int __ofono_voicecall_add_emergency_watch(struct ofono_voiceca=
ll *vc,
>> +                             ofono_voicecall_emergency_notify_cb_t noti=
fy,
>> +                             void *data, ofono_destroy_func destroy);
>> +void __ofono_voicecall_remove_emergency_watch(struct ofono_voicecall *v=
c,
>> +                                             unsigned int id);
>> +ofono_bool_t ofono_voicecall_get_emergency_state(struct ofono_voicecall=
 *vc);
>> +void __ofono_voicecall_set_emergency_state(struct ofono_voicecall *vc,
>> +                                             int state);
>> +
>>      =

> Just some general comments, but this patch seems to be backwards from
> the earlier proposal.  Namely EmergencyMode is a property on the Modem
> interface, not on the VoiceCallManager.  See doc/modem-api.txt,
> Emergency property.
>    =

I thought it was more logical to have the EmergencyMode property
linked to voicecall since it is about a special call case, but I am fine
with moving that property up to modem level.

> In general I think that the emergency_watch is unnecessary.  Having a
> reference counted emergency tracking inside the modem object and a modem
> online state watch should be sufficient.
>
>    =

The idea with the emergency watch is that any subsystem can get the
notification  when the emergency mode is entered and react on it.
To give you a more complex example, it might well be that the gprs
connection needs to be torn down when making an emergency call in
2G mode, there are such networks out there that prevents you from
making an emergency call if your device is attached to a PDP context.
In this given situation it comes to the question how to bring down the
gprs connection. It can be done such that the gprs atom will tear down
the connection after receiving the EmergencyMode notification, or
another option is to have gprs connection handling functions made
available by gprs and to deal with the gprs connection within voicecall
(or somewhere else). The online/offline mode change handling in fact is
bringing up the some issue, how the mode change handling should be
implemented when making the emergency call. My idea was let every
subsystem deal with the specifics of its own subsystem.

>>   #ifdef __cplusplus
>>   }
>>   #endif
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 7b5fe3b..a619b30 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -25,6 +25,7 @@
>>
>>   #include<string.h>
>>   #include<stdio.h>
>> +#include<stdlib.h>
>>   #include<time.h>
>>   #include<errno.h>
>>   #include<stdint.h>
>> @@ -56,6 +57,9 @@ struct ofono_voicecall {
>>        void *driver_data;
>>        struct ofono_atom *atom;
>>        struct dial_request *dial_req;
>> +     struct ofono_watchlist *emergency_watches;
>> +     unsigned int emergency_state;
>> +     unsigned int modem_state_watch;
>>   };
>>
>>   struct voicecall {
>> @@ -85,6 +89,8 @@ static const char *default_en_list_no_sim[] =3D { "119=
", "118", "999", "110",
>>
>>   static void generic_callback(const struct ofono_error *error, void *da=
ta);
>>   static void multirelease_callback(const struct ofono_error *err, void =
*data);
>> +static const char *voicecall_build_path(struct ofono_voicecall *vc,
>> +                                     const struct ofono_call *call);
>>
>>      =

> It is generally against the coding style to forward-declare static
> functions.  If this function is needed, please simply move it higher.
>    =

OK, I'll conform to the agreed coding policy.
>    =

>>   static gint call_compare_by_id(gconstpointer a, gconstpointer b)
>>   {
>> @@ -121,6 +127,145 @@ static void add_to_en_list(GSList **l, const char =
**list)
>>                *l =3D g_slist_prepend(*l, g_strdup(list[i++]));
>>   }
>>
>> +static gint number_compare(gconstpointer a, gconstpointer b)
>> +{
>> +     const char *s1 =3D a, *s2 =3D b;
>> +     return strcmp(s1, s2);
>> +}
>> +
>> +static ofono_bool_t emergency_number(struct ofono_voicecall *vc,
>> +                                     const char *number)
>> +{
>> +     if (!number)
>> +             return FALSE;
>> +
>> +     return g_slist_find_custom(vc->en_list,
>> +                             number, number_compare) ? TRUE : FALSE;
>> +}
>> +
>>      =

> Please add this as a separate patch handling the 'Extend the voicecall
> interface with a property indicating whether this call is an emergency
> call' task
>    =

>    =

>> +static void notify_emergency_watches(struct ofono_voicecall *vc,
>> +                                     ofono_bool_t state)
>> +{
>> +     struct ofono_watchlist_item *item;
>> +     GSList *l;
>> +     ofono_voicecall_emergency_notify_cb_t notify;
>> +
>> +     if (vc->emergency_watches =3D=3D NULL)
>> +             return;
>> +
>> +     for (l =3D vc->emergency_watches->items; l; l =3D l->next) {
>> +             item =3D l->data;
>> +             notify =3D item->notify;
>> +             notify(state, item->notify_data);
>> +     }
>> +}
>> +
>> +unsigned int __ofono_voicecall_add_emergency_watch(struct ofono_voiceca=
ll *vc,
>> +                             ofono_voicecall_emergency_notify_cb_t noti=
fy,
>> +                             void *data, ofono_destroy_func destroy)
>> +{
>> +     struct ofono_watchlist_item *item;
>> +
>> +     if (vc =3D=3D NULL || notify =3D=3D NULL)
>> +             return 0;
>> +
>> +     item =3D g_new0(struct ofono_watchlist_item, 1);
>> +
>> +     item->notify =3D notify;
>> +     item->destroy =3D destroy;
>> +     item->notify_data =3D data;
>> +
>> +     return __ofono_watchlist_add_item(vc->emergency_watches, item);
>> +}
>> +
>> +void __ofono_voicecall_remove_emergency_watch(struct ofono_voicecall *v=
c,
>> +                                             unsigned int id)
>> +{
>> +     __ofono_watchlist_remove_item(vc->emergency_watches, id);
>> +}
>> +
>> +ofono_bool_t ofono_voicecall_get_emergency_state(struct ofono_voicecall=
 *vc)
>> +{
>> +     return vc->emergency_state ? 1 : 0;
>> +}
>> +
>> +void __ofono_voicecall_inc_emergency_state(struct ofono_voicecall *vc)
>> +{
>> +     DBusConnection *conn =3D ofono_dbus_get_connection();
>> +     const char *path =3D __ofono_atom_get_path(vc->atom);
>> +     gboolean state =3D TRUE;
>> +
>> +     if (!vc->emergency_state++) {
>>      =

> Please avoid such coding style.  Parsing such a statement takes
> considerable effort.
>    =

> vc->emergency_state++;
>
> if (vc->emergency_state>  1)
>          return;
>
> ofono_dbus_signal...
>
> would be much more readable.
>
>    =

>> +             ofono_dbus_signal_property_changed(conn, path,
>> +                                             OFONO_VOICECALL_INTERFACE,
>> +                                             "EmergencyMode",
>> +                                             DBUS_TYPE_BOOLEAN,
>> +&state);
>> +             notify_emergency_watches(vc, state);
>> +     }
>> +}
>> +
>> +void __ofono_voicecall_dec_emergency_state(struct ofono_voicecall *vc)
>> +{
>> +     DBusConnection *conn =3D ofono_dbus_get_connection();
>> +     const char *path =3D __ofono_atom_get_path(vc->atom);
>> +     gboolean state =3D FALSE;
>> +
>> +     if (!--vc->emergency_state) {
>> +             ofono_dbus_signal_property_changed(conn, path,
>> +                                             OFONO_VOICECALL_INTERFACE,
>> +                                             "EmergencyMode",
>> +                                             DBUS_TYPE_BOOLEAN,
>> +&state);
>> +             notify_emergency_watches(vc, state);
>> +     }
>> +}
>> +
>> +static ofono_bool_t clir_string_to_clir(const char *clirstr,
>> +                                     enum ofono_clir_option *clir);
>> +static void manager_dial_callback(const struct ofono_error *error, void=
 *data);
>>      =

> Again, please avoid forward declarations
>
>    =

>> +static void modem_state_watch(enum ofono_modem_state state, void *data)
>> +{
>> +     struct ofono_voicecall *vc =3D data;
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +     DBusMessage *reply;
>> +     const char *number;
>> +     struct ofono_phone_number ph;
>> +     const char *clirstr;
>> +     enum ofono_clir_option clir;
>> +
>> +     if (!vc->pending)
>> +             return;
>> +
>> +     if (strcmp(dbus_message_get_member(vc->pending), "Dial"))
>> +             return;
>> +
>> +     if (dbus_message_get_args(vc->pending, NULL, DBUS_TYPE_STRING,&num=
ber,
>> +                                     DBUS_TYPE_STRING,&clirstr,
>> +                                     DBUS_TYPE_INVALID) =3D=3D FALSE) {
>> +             reply =3D __ofono_error_invalid_args(vc->pending);
>> +             __ofono_dbus_pending_reply(&vc->pending, reply);
>> +             return;
>> +     }
>> +
>> +     /* don't care here about non-emergency calls */
>> +     if (!emergency_number(vc, number))
>> +             return;
>> +
>> +     if (!ofono_modem_get_online(modem)) {
>> +             reply =3D __ofono_error_failed(vc->pending);
>> +             __ofono_dbus_pending_reply(&vc->pending, reply);
>> +             __ofono_voicecall_dec_emergency_state(vc);
>> +             return;
>> +     }
>> +
>> +     clir_string_to_clir(clirstr,&clir);
>> +     string_to_phone_number(number,&ph);
>> +
>> +     vc->driver->dial(vc,&ph, clir, OFONO_CUG_OPTION_DEFAULT,
>> +                             manager_dial_callback, vc);
>> +}
>> +
>>   static const char *disconnect_reason_to_string(enum ofono_disconnect_r=
eason r)
>>   {
>>        switch (r) {
>> @@ -718,7 +863,8 @@ static gboolean voicecalls_can_dtmf(struct ofono_voi=
cecall *vc)
>>        return FALSE;
>>   }
>>
>> -static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc,=
 int status)
>> +static gboolean voicecalls_have_with_status(struct ofono_voicecall *vc,
>> +                                             int status)
>>      =

> Why is this here? This chunk does not seem related to this patch
>
>    =

>>   {
>>        GSList *l;
>>        struct voicecall *v;
>> @@ -918,6 +1064,7 @@ static DBusMessage *manager_get_properties(DBusConn=
ection *conn,
>>        int i;
>>        GSList *l;
>>        char **list;
>> +     ofono_bool_t emergency_state;
>>
>>        reply =3D dbus_message_new_method_return(msg);
>>
>> @@ -930,6 +1077,10 @@ static DBusMessage *manager_get_properties(DBusCon=
nection *conn,
>>                                        OFONO_PROPERTIES_ARRAY_SIGNATURE,
>>                                        &dict);
>>
>> +     emergency_state =3D ofono_voicecall_get_emergency_state(vc);
>> +     ofono_dbus_dict_append(&dict, "EmergencyMode",
>> +                             DBUS_TYPE_BOOLEAN,&emergency_state);
>> +
>>      =

> As mentioned before, Emergency was agreed to be on the Modem interface
>
>    =

>>        /* property EmergencyNumbers */
>>        list =3D g_new0(char *, g_slist_length(vc->en_list) + 1);
>>
>> @@ -1066,8 +1217,11 @@ static void manager_dial_callback(const struct of=
ono_error *error, void *data)
>>
>>                dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH,&pa=
th,
>>                                                DBUS_TYPE_INVALID);
>> -     } else
>> +     } else {
>> +             if (emergency_number(vc, number))
>> +                     __ofono_voicecall_dec_emergency_state(vc);
>>                reply =3D __ofono_error_failed(vc->pending);
>> +     }
>>
>>        __ofono_dbus_pending_reply(&vc->pending, reply);
>>
>> @@ -1118,6 +1272,14 @@ static DBusMessage *manager_dial(DBusConnection *=
conn,
>>
>>        string_to_phone_number(number,&ph);
>>
>> +     if (emergency_number(vc, number)) {
>> +             struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->a=
tom);
>> +             ofono_bool_t online =3D ofono_modem_get_online(modem);
>> +             __ofono_voicecall_inc_emergency_state(vc);
>> +             if (!online)
>> +                     return NULL;
>> +     }
>> +
>>        vc->driver->dial(vc,&ph, clir, OFONO_CUG_OPTION_DEFAULT,
>>                                manager_dial_callback, vc);
>>
>> @@ -1667,7 +1829,7 @@ void ofono_voicecall_disconnected(struct ofono_voi=
cecall *vc, int id,
>>   {
>>        struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>>        GSList *l;
>> -     struct voicecall *call;
>> +     struct voicecall *v;
>>      =

> Why?  Please refrain from doing this.  If you feel the variable naming
> could be improved, then send a separate patch.  As it is, it has no
> bearing on emergency call handling...
>
>    =

>>        time_t ts;
>>        enum call_status prev_status;
>>
>> @@ -1684,48 +1846,52 @@ void ofono_voicecall_disconnected(struct ofono_v=
oicecall *vc, int id,
>>                return;
>>        }
>>
>> -     call =3D l->data;
>> +     v =3D l->data;
>>
>>        ts =3D time(NULL);
>> -     prev_status =3D call->call->status;
>> +     prev_status =3D v->call->status;
>>
>>        l =3D g_slist_find_custom(vc->multiparty_list, GUINT_TO_POINTER(i=
d),
>>                                call_compare_by_id);
>>
>>        if (l) {
>>                vc->multiparty_list =3D
>> -                     g_slist_remove(vc->multiparty_list, call);
>> +                     g_slist_remove(vc->multiparty_list, v);
>>
>>                if (vc->multiparty_list->next =3D=3D NULL) { /* Size =3D=
=3D 1 */
>> -                     struct voicecall *v =3D vc->multiparty_list->data;
>> +                     struct voicecall *v2 =3D vc->multiparty_list->data;
>>
>> -                     voicecall_emit_multiparty(v, FALSE);
>> +                     voicecall_emit_multiparty(v2, FALSE);
>>                        g_slist_free(vc->multiparty_list);
>>                        vc->multiparty_list =3D 0;
>>                }
>>        }
>>
>> -     vc->release_list =3D g_slist_remove(vc->release_list, call);
>> +     vc->release_list =3D g_slist_remove(vc->release_list, v);
>>
>>        if (reason !=3D OFONO_DISCONNECT_REASON_UNKNOWN)
>> -             voicecall_emit_disconnect_reason(call, reason);
>> +             voicecall_emit_disconnect_reason(v, reason);
>>
>> -     voicecall_set_call_status(call, CALL_STATUS_DISCONNECTED);
>> +     voicecall_set_call_status(v, CALL_STATUS_DISCONNECTED);
>>
>> -     if (!call->untracked) {
>> +     if (!v->untracked) {
>>                if (prev_status =3D=3D CALL_STATUS_INCOMING ||
>>                                prev_status =3D=3D CALL_STATUS_WAITING)
>> -                     __ofono_history_call_missed(modem, call->call, ts);
>> +                     __ofono_history_call_missed(modem, v->call, ts);
>>                else
>> -                     __ofono_history_call_ended(modem, call->call,
>> -                                                     call->detect_time,=
 ts);
>> +                     __ofono_history_call_ended(modem, v->call,
>> +                                                     v->detect_time, ts=
);
>>        }
>>
>> -     voicecalls_emit_call_removed(vc, call);
>> +     voicecalls_emit_call_removed(vc, v);
>> +
>> +     if (emergency_number(vc,
>> +                     phone_number_to_string(&v->call->phone_number)))
>> +             __ofono_voicecall_dec_emergency_state(vc);
>>
>> -     voicecall_dbus_unregister(vc, call);
>> +     voicecall_dbus_unregister(vc, v);
>>
>> -     vc->call_list =3D g_slist_remove(vc->call_list, call);
>> +     vc->call_list =3D g_slist_remove(vc->call_list, v);
>>   }
>>
>>   void ofono_voicecall_notify(struct ofono_voicecall *vc,
>> @@ -1969,6 +2135,9 @@ static void voicecall_unregister(struct ofono_atom=
 *atom)
>>                vc->sim_watch =3D 0;
>>        }
>>
>> +     __ofono_watchlist_free(vc->emergency_watches);
>> +     vc->emergency_watches =3D NULL;
>> +
>>        if (vc->dial_req)
>>                dial_request_finish(vc);
>>
>> @@ -1985,6 +2154,7 @@ static void voicecall_unregister(struct ofono_atom=
 *atom)
>>   static void voicecall_remove(struct ofono_atom *atom)
>>   {
>>        struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
>>
>>        DBG("atom: %p", atom);
>>
>> @@ -2012,6 +2182,11 @@ static void voicecall_remove(struct ofono_atom *a=
tom)
>>                vc->sim =3D NULL;
>>        }
>>
>> +     if (vc->modem_state_watch) {
>> +             __ofono_modem_remove_state_watch(modem, vc->modem_state_wa=
tch);
>> +             vc->modem_state_watch =3D 0;
>> +     }
>> +
>>        g_free(vc);
>>   }
>>
>> @@ -2122,6 +2297,10 @@ void ofono_voicecall_register(struct ofono_voicec=
all *vc)
>>        }
>>
>>        ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFAC=
E);
>> +     vc->emergency_watches =3D __ofono_watchlist_new(g_free);
>> +     vc->modem_state_watch =3D __ofono_modem_add_state_watch(modem,
>> +                                                     modem_state_watch,
>> +                                                     vc, NULL);
>>
>>        /*
>>         * Start out with the 22.101 mandated numbers, if we have a SIM a=
nd
>> @@ -2208,6 +2387,9 @@ static void dial_request_cb(const struct ofono_err=
or *error, void *data)
>>
>>        if (v =3D=3D NULL) {
>>                dial_request_finish(vc);
>> +             if (emergency_number(vc,
>> +                             phone_number_to_string(&vc->dial_req->ph)))
>> +                     __ofono_voicecall_inc_emergency_state(vc);
>>                return;
>>        }
>>
>> @@ -2233,6 +2415,9 @@ static void dial_request_cb(const struct ofono_err=
or *error, void *data)
>>
>>   static void dial_request(struct ofono_voicecall *vc)
>>   {
>> +     if (emergency_number(vc, phone_number_to_string(&vc->dial_req->ph)=
))
>> +             __ofono_voicecall_inc_emergency_state(vc);
>> +
>>        vc->driver->dial(vc,&vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
>>                                OFONO_CUG_OPTION_DEFAULT, dial_request_cb=
, vc);
>>   }
>>      =

> Regards,
> -Denis
>    =

Regards,
Andras

--===============3819249627513396343==--

