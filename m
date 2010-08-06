Content-Type: multipart/mixed; boundary="===============1183045343791921843=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2] STE-driver: Terminating voice call in state
 DIALING/ALERTING.
Date: Fri, 06 Aug 2010 23:30:04 +0200
Message-ID: <AANLkTikmnTjmDBZO3ui3n=MQmnjEumg2kjHYzFX_aTTQ@mail.gmail.com>
In-Reply-To: <4C5C5C0C.5090909@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1183045343791921843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.
...
>> +static void at_hangup_active(struct ofono_voicecall *vc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_voicecall_cb_t cb, void *data)
>> +{
>> + =C2=A0 =C2=A0 /* Hangup =C2=A0currently active call */
>
> It might be safer to only implement hangup_active in the generic driver.
> =C2=A0However, since this driver is only for testing anyway, the change i=
s fine.

Ok, I might change that then.

...
>> +/* HACK: for temporary backwards compatibility */
>> +#define hangup_all hangup
>> + =C2=A0 =C2=A0 void (*hangup_all)(struct ofono_voicecall *vc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ofono_voicecall_cb_t cb, void *data);
>> + =C2=A0 =C2=A0 void (*hangup_active)(struct ofono_voicecall *vc,
>
> We'll need to figure out how to migrate to the new driver API a bit more
> sanely.

Should we s/hangup/hangup_active in all drivers and skip this hack then?
Or did you have something else in mind?
....
> =C2=A0static void voicecalls_release_queue(struct ofono_voicecall *vc, GS=
List *calls)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 GSList *l;
>> + =C2=A0 =C2=A0 struct voicecall *call;
>>
>> =C2=A0 =C2=A0 =C2=A0 g_slist_free(vc->release_list);
>> =C2=A0 =C2=A0 =C2=A0 vc->release_list =3D NULL;
>>
>> - =C2=A0 =C2=A0 for (l =3D calls; l; l =3D l->next)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->release_list =3D g_slist=
_prepend(vc->release_list, l->data);
>> + =C2=A0 =C2=A0 for (l =3D calls; l; l =3D l->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 call =3D l->data;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (call->call->status !=3D =
CALL_STATUS_WAITING)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
vc->release_list =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_slist_prepend(vc->release_list, call);
>> + =C2=A0 =C2=A0 }
>
> Actually I prefer this to be done in manager_hangup_all. =C2=A0This funct=
ion
> is used by the multiparty release path which can never include waiting
> calls.

OK, I'll look into that.
...

>> @@ -1131,9 +1165,17 @@ static DBusMessage *manager_hangup_all(DBusConnec=
tion *conn,
>>
>> =C2=A0 =C2=A0 =C2=A0 vc->pending =3D dbus_message_ref(msg);
>>
>> - =C2=A0 =C2=A0 voicecalls_release_queue(vc, vc->call_list);
>> - =C2=A0 =C2=A0 voicecalls_release_next(vc);
>> + =C2=A0 =C2=A0 if (vc->driver->hangup_all !=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->driver->hangup_all(vc, g=
eneric_callback, vc);
>>
>> + =C2=A0 =C2=A0 /* In case of INCOMING call, assume we only have this on=
e call */
>> + =C2=A0 =C2=A0 else if (voicecalls_have_incoming(vc) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
vc->driver->hangup_active !=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->driver->hangup_active(vc=
, generic_callback, vc);
>
> Now that I think about it, the else if clause is not needed. =C2=A0You ta=
ke
> care of incoming calls with hangup_active in voicecalls_release_next.
> Right?

Yes, agree.

...
>> @@ -1370,8 +1412,12 @@ static DBusMessage *multiparty_hangup(DBusConnect=
ion *conn,
>>
>> =C2=A0 =C2=A0 =C2=A0 /* Fall back to the old-fashioned way */
>> =C2=A0 =C2=A0 =C2=A0 vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
>> - =C2=A0 =C2=A0 voicecalls_release_queue(vc, vc->multiparty_list);
>> - =C2=A0 =C2=A0 voicecalls_release_next(vc);
>> + =C2=A0 =C2=A0 if (vc->driver->hangup_all !=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc->driver->hangup_all(vc, g=
eneric_callback, vc);
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voicecalls_release_queue(vc,=
 vc->call_list);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 voicecalls_release_next(vc);
>> + =C2=A0 =C2=A0 }
>
> This doesn't look right. =C2=A0If we get to this part then we either have
> waiting + active, waiting + held, waiting + active + held or active +
> held. =C2=A0Calling hangup_all would be all right for the first two cases,
> but not the other two.
>
> For multiparty we need to fall back to release_specific. =C2=A0The origin=
al
> code was fine.

OK, I'll revert this.


How do we proceede with this change. I am very happy if you carry on from h=
ere,
or would you like me to to submit a patch-set with these changes,
including s/hangup/hangup_active in drivers/*/voicecall.c?

Regards
Sjur

--===============1183045343791921843==--

