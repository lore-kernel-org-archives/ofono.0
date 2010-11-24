Content-Type: multipart/mixed; boundary="===============2384054770727675819=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [RFC PATCH 4/4] voicecall: add emergency call handling
Date: Wed, 24 Nov 2010 18:09:09 +0200
Message-ID: <4CED38A5.9090205@nokia.com>
In-Reply-To: <4CEB829A.7000408@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2384054770727675819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 11/23/2010 11:00 AM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 11/15/2010 10:58 AM, Andras Domokos wrote:
>    =

>> ---
>>   src/voicecall.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>   1 files changed, 110 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 3af614b..066cdb9 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -52,6 +52,7 @@ struct ofono_voicecall {
>>        struct ofono_sim *sim;
>>        unsigned int sim_watch;
>>        unsigned int sim_state_watch;
>> +     unsigned int modem_online_watch;
>>        const struct ofono_voicecall_driver *driver;
>>        void *driver_data;
>>        struct ofono_atom *atom;
>> @@ -133,6 +134,22 @@ static void add_to_en_list(GSList **l, const char *=
*list)
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
>>      =

> Just nit picking here, but in general we really prefer this to be
> written like this:
>
> if (number =3D=3D NULL)
>
> This is much easier to read when you don't know if number is a string or
> an integer.  Yes I know we're not always consistent about doing this,
> particularly in voicecall.c.
>
>    =

>> +             return FALSE;
>> +
>> +     return g_slist_find_custom(vc->en_list,
>> +                             number, number_compare) ? TRUE : FALSE;
>> +}
>> +
>>   static const char *disconnect_reason_to_string(enum ofono_disconnect_r=
eason r)
>>   {
>>        switch (r) {
>> @@ -1125,6 +1142,7 @@ static struct voicecall *dial_handle_result(struct=
 ofono_voicecall *vc,
>>   static void manager_dial_callback(const struct ofono_error *error, voi=
d *data)
>>   {
>>        struct ofono_voicecall *vc =3D data;
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>>        DBusMessage *reply;
>>        const char *number;
>>        gboolean need_to_emit;
>> @@ -1143,8 +1161,12 @@ static void manager_dial_callback(const struct of=
ono_error *error, void *data)
>>
>>                dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH,&pa=
th,
>>                                                DBUS_TYPE_INVALID);
>> -     } else
>> +     } else {
>> +             if (emergency_number(vc, number))
>> +                     ofono_modem_dec_emergency_mode(modem);
>> +
>>                reply =3D __ofono_error_failed(vc->pending);
>> +     }
>>
>>        __ofono_dbus_pending_reply(&vc->pending, reply);
>>
>> @@ -1156,6 +1178,7 @@ static DBusMessage *manager_dial(DBusConnection *c=
onn,
>>                                        DBusMessage *msg, void *data)
>>   {
>>        struct ofono_voicecall *vc =3D data;
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>>        const char *number;
>>        struct ofono_phone_number ph;
>>        const char *clirstr;
>> @@ -1195,6 +1218,15 @@ static DBusMessage *manager_dial(DBusConnection *=
conn,
>>
>>        string_to_phone_number(number,&ph);
>>
>> +     if (emergency_number(vc, number)) {
>> +             ofono_bool_t online =3D ofono_modem_get_online(modem);
>> +
>> +             ofono_modem_inc_emergency_mode(modem);
>> +
>> +             if (!online)
>>      =

> Do me a favor and change this to:
> if (online =3D=3D FALSE)
>
>    =

>> +                     return NULL;
>> +     }
>> +
>>        vc->driver->dial(vc,&ph, clir, OFONO_CUG_OPTION_DEFAULT,
>>                                manager_dial_callback, vc);
>>
>> @@ -1748,6 +1780,7 @@ void ofono_voicecall_disconnected(struct ofono_voi=
cecall *vc, int id,
>>                                const struct ofono_error *error)
>>   {
>>        struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +     const char *number;
>>        GSList *l;
>>        struct voicecall *call;
>>        time_t ts;
>> @@ -1767,6 +1800,7 @@ void ofono_voicecall_disconnected(struct ofono_voi=
cecall *vc, int id,
>>        }
>>
>>        call =3D l->data;
>> +     number =3D phone_number_to_string(&call->call->phone_number);
>>
>>        ts =3D time(NULL);
>>        prev_status =3D call->call->status;
>> @@ -1805,6 +1839,9 @@ void ofono_voicecall_disconnected(struct ofono_voi=
cecall *vc, int id,
>>
>>        voicecalls_emit_call_removed(vc, call);
>>
>> +     if (emergency_number(vc, number))
>> +             ofono_modem_dec_emergency_mode(modem);
>> +
>>        voicecall_dbus_unregister(vc, call);
>>
>>        vc->call_list =3D g_slist_remove(vc->call_list, call);
>> @@ -2067,6 +2104,7 @@ static void voicecall_unregister(struct ofono_atom=
 *atom)
>>   static void voicecall_remove(struct ofono_atom *atom)
>>   {
>>        struct ofono_voicecall *vc =3D __ofono_atom_get_data(atom);
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
>>
>>        DBG("atom: %p", atom);
>>
>> @@ -2108,6 +2146,12 @@ static void voicecall_remove(struct ofono_atom *a=
tom)
>>                g_queue_free(vc->toneq);
>>        }
>>
>> +     if (vc->modem_online_watch) {
>> +             __ofono_modem_remove_online_watch(modem,
>> +                                             vc->modem_online_watch);
>> +             vc->modem_online_watch =3D 0;
>> +     }
>> +
>>        g_free(vc);
>>   }
>>
>> @@ -2205,6 +2249,7 @@ static void sim_watch(struct ofono_atom *atom,
>>   static void dial_request_cb(const struct ofono_error *error, void *dat=
a)
>>   {
>>        struct ofono_voicecall *vc =3D data;
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>>        gboolean need_to_emit;
>>        struct voicecall *v;
>>
>> @@ -2214,6 +2259,9 @@ static void dial_request_cb(const struct ofono_err=
or *error, void *data)
>>
>>        if (v =3D=3D NULL) {
>>                dial_request_finish(vc);
>>      =

> Please add an empty line here based on item M1.
>
>    =

>> +             if (emergency_number(vc,
>> +                             phone_number_to_string(&vc->dial_req->ph)))
>> +                     ofono_modem_dec_emergency_mode(modem);
>>                return;
>>        }
>>
>> @@ -2237,6 +2285,53 @@ static void dial_request_cb(const struct ofono_er=
ror *error, void *data)
>>                voicecalls_emit_call_added(vc, v);
>>   }
>>
>> +static void modem_online_watch(ofono_bool_t online, void *data)
>> +{
>> +     struct ofono_voicecall *vc =3D data;
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +     DBusMessage *reply;
>> +     const char *number;
>> +     struct ofono_phone_number ph;
>> +     const char *clirstr;
>> +     enum ofono_clir_option clir;
>> +
>> +     if (ofono_modem_get_emergency_mode(modem) !=3D TRUE)
>> +             return;
>> +
>> +     if (vc->dial_req)
>> +             vc->driver->dial(vc,&vc->dial_req->ph,
>> +                                     OFONO_CLIR_OPTION_DEFAULT,
>> +                                     OFONO_CUG_OPTION_DEFAULT,
>> +                                     dial_request_cb, vc);
>> +
>> +     if (!vc->pending)
>>      =

> if (vc->pending =3D=3D NULL) here please
>
>    =

>> +             return;
>> +
>> +     if (strcmp(dbus_message_get_member(vc->pending), "Dial"))
>> +             return;
>> +
>> +     if (dbus_message_get_args(vc->pending, NULL, DBUS_TYPE_STRING,&num=
ber,
>> +                                     DBUS_TYPE_STRING,&clirstr,
>> +                                     DBUS_TYPE_INVALID) =3D=3D FALSE)
>> +             return;
>> +
>> +     if (!emergency_number(vc, number))
>>      =

> Please do emergency_number() =3D=3D FALSE here
>
>    =

>> +             return;
>> +
>> +     if (!online) {
>>      =

> And online =3D=3D FALSE here
>
>    =

>> +             reply =3D __ofono_error_failed(vc->pending);
>> +             __ofono_dbus_pending_reply(&vc->pending, reply);
>> +             ofono_modem_dec_emergency_mode(modem);
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
>>   void ofono_voicecall_register(struct ofono_voicecall *vc)
>>   {
>>        DBusConnection *conn =3D ofono_dbus_get_connection();
>> @@ -2255,6 +2350,9 @@ void ofono_voicecall_register(struct ofono_voiceca=
ll *vc)
>>        }
>>
>>        ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFAC=
E);
>> +     vc->modem_online_watch =3D __ofono_modem_add_online_watch(modem,
>> +                                                     modem_online_watch,
>> +                                                     vc, NULL);
>>
>>        /*
>>         * Start out with the 22.101 mandated numbers, if we have a SIM a=
nd
>> @@ -2331,6 +2429,17 @@ ofono_bool_t __ofono_voicecall_is_busy(struct ofo=
no_voicecall *vc,
>>
>>   static void dial_request(struct ofono_voicecall *vc)
>>   {
>> +     struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +
>> +     if (emergency_number(vc, phone_number_to_string(&vc->dial_req->ph)=
)) {
>> +             ofono_bool_t online =3D ofono_modem_get_online(modem);
>> +
>> +             ofono_modem_inc_emergency_mode(modem);
>> +
>> +             if (!online)
>>      =

> And online =3D=3D FALSE here
>
>    =

>> +                     return;
>> +     }
>> +
>>        vc->driver->dial(vc,&vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
>>                                OFONO_CUG_OPTION_DEFAULT, dial_request_cb=
, vc);
>>   }
>>      =

> Otherwise, looks good to me.
>    =

Thanks for the comments, I am going to resend the patch with
the changes I made based on your comments.
> Have you figured out how to support the E911 call-back requirements?
>    =

This is something that still needs to be figured out and can
be added in a separate patch.

> Regards,
> -Denis
>    =

Regards,
Andras

--===============2384054770727675819==--

