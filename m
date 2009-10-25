Content-Type: multipart/mixed; boundary="===============8550424546057268523=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sun, 25 Oct 2009 02:02:56 +0200
Message-ID: <fb249edb0910241702p2467ef4fgd09b9e42216dcfa7@mail.gmail.com>
In-Reply-To: <200910241030.21466.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8550424546057268523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/10/24 Denis Kenzior <denkenz@gmail.com>:
>> > in set_registration_status:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0attached =3D (status !=3D NETWORK_REGISTRAT=
ION_STATUS_REGISTERED &&
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gprs->attached !=3D (int) attached &&
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0!(gprs->flags & GPRS_FLAG_ATTACHING)) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprs->attached =
=3D (int) attached;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_dbus_sign=
al_property_changed(conn, path,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DATA_CONNECTION_MANAGER_INTERFACE,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Attached", DBUS_TYPE_BOOLEAN,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&attached);
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gprs_netreg_upd=
ate(gprs);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> So the issue here is that I can actually understand what gprs_netreg_upda=
te
> does. =C2=A0This function I'm having trouble with.
>
> Lets suppose status=3Dregistered arrives and we're already attached. =C2=
=A0Here
> attached will be set to FALSE, Attached property will be set to false and
> emitted. =C2=A0gprs_netreg_update will presumably reset Attached back to =
True.

Now I see it and you're absolutely right to be alerted, I set
"attached" to the reverse of what it should be set to.  We're attached
when we're either in REGISTERED or ROAMING state.  If I had done it
right then the logic would look simple (I suppose):

If either we already knew that we were in that state then there's
nothing to do.  Otherwise we set the D-Bus property to reflect current
state and call gprs_netreg_update to figure out if this is the state
we really wanted to be in.

If the notification indicates we were detached we will also need to
reset all current contexts to inactive here, originally I did this in
the driver.

>>
>> > gprs_netreg_update:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Prevent furt=
her attempts to attach */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!attach && =
gprs->powered) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0gprs->powered =3D 0;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0path =3D __ofono_atom_get_path(gprs->atom);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ofono_dbus_signal_property_changed(conn, path,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DATA_C=
ONNECTION_MANAGER_INTERFACE,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Power=
ed", DBUS_TYPE_BOOLEAN,
>> > &value); }
>> >
>> > This is just too evil. =C2=A0Can't we set another flag that attached
>> > conditions have changed while we were attaching/detaching and that we
>> > should recheck those conditions when we return from attach/detach?
>>
>> Is it evil because we change a property that is writable?
>
> Yes, and also because this is a hack :)
>
>>
>> This is only for the case of RoamingAllowed =3D 0. =C2=A0In my understan=
ding
>> "Powered" being set means that we're attached or attempting to attach,
>
> No, Powered means GPRS is on assuming all conditions are fulfilled (e.g.
> registration, roaming, network resources) =C2=A0This is a user setting th=
at will be
> persisted (in IMSI based storage.) =C2=A0It should not be spuriously chan=
ged by the
> daemon.

This is a policy question, what do we do when the user disallowed
roaming but the modem wants to roam?  If we decide that we will not
retry to attach until the user pokes us again then "Powered" really
should be reset to false because even if the conditions you listed are
met we still won't attach.  Maybe instead we should do the retries
with increasing timeouts like you mentioned in another message, and
then "Powered" should stay set.

An unrelated thing: you keep the allowed cid range in the core and
only remember the min and max cid.  However I think (but don't know
where to check for it) that +CGDCONT=3D? is free to return (1,2) instead
of (1-2), or even (1-2,5-6,13).  Other AT commands do return ranges
with this syntax.

Regards

--===============8550424546057268523==--

