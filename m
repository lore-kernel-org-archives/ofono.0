Content-Type: multipart/mixed; boundary="===============6407423153141189974=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Sat, 24 Oct 2009 10:30:20 -0500
Message-ID: <200910241030.21466.denkenz@gmail.com>
In-Reply-To: <fb249edb0910240104x3d994b16u39d8277a0c9a997e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6407423153141189974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
> > in set_registration_status:
> >        attached =3D (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED=
 &&
> >                        status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
> >        if (gprs->attached !=3D (int) attached &&
> >                        !(gprs->flags & GPRS_FLAG_ATTACHING)) {
> >                gprs->attached =3D (int) attached;
> >
> >                ofono_dbus_signal_property_changed(conn, path,
> >                                DATA_CONNECTION_MANAGER_INTERFACE,
> >                                "Attached", DBUS_TYPE_BOOLEAN,
> >                                &attached);
> >
> >                gprs_netreg_update(gprs);
> >        }
> >
> > I do not understand this logic at all.  Can't we always call
> > gprs_netreg_update here?
>
> Sure, but it won't do anything, if either "attached" state hasn't
> changed at all or it's already busy executing +CGATT.

So the issue here is that I can actually understand what gprs_netreg_update =

does.  This function I'm having trouble with.

Lets suppose status=3Dregistered arrives and we're already attached.  Here =

attached will be set to FALSE, Attached property will be set to false and =

emitted.  gprs_netreg_update will presumably reset Attached back to True.  =
Why =

do this for a potentially spurious indication?  Remember your status might =
be =

indicated when just the network access technology has changed.

Another case.  We're detached (Powered=3DTrue, RoamingAllowed=3DFalse) and =
are =

currently Roaming.  Then status=3Dsearching arrives.  We report Attached as =

True.

Am I properly outlining the logic or am I missing something?  Again, explai=
n =

the intention here.  Either way, the current logic is way too complicated a=
nd =

needs to be simplified.

>
> > In my opinion Attached should only be emitted once
> > it really has changed (e.g. in the callback)
>
> Often there's no other notification telling us that we were detached,
> so we must take any sign of it into account (it might be broken modems
> but I've seen such situations on both modems that I've tested it with)

For situations where we are forcefully detached and/or go into a non-
registered state, the core should take care of this.  If it is a modem not =

reporting this properly, then I'd argue this is something the driver needs =
to =

take care of.  If the core starts trying to guess / outwit every single bro=
ken =

hardware out there it will be unmaintainable.  Lets at least try to keep th=
e =

core clean and only responsible for the things mandated by the relevant =

standards.

>
> > gprs_netreg_update:
> >                /* Prevent further attempts to attach */
> >                if (!attach && gprs->powered) {
> >                        gprs->powered =3D 0;
> >
> >                        path =3D __ofono_atom_get_path(gprs->atom);
> >                        ofono_dbus_signal_property_changed(conn, path,
> >                                        DATA_CONNECTION_MANAGER_INTERFAC=
E,
> >                                        "Powered", DBUS_TYPE_BOOLEAN,
> > &value); }
> >
> > This is just too evil.  Can't we set another flag that attached
> > conditions have changed while we were attaching/detaching and that we
> > should recheck those conditions when we return from attach/detach?
>
> Is it evil because we change a property that is writable?

Yes, and also because this is a hack :)

>
> This is only for the case of RoamingAllowed =3D 0.  In my understanding
> "Powered" being set means that we're attached or attempting to attach,

No, Powered means GPRS is on assuming all conditions are fulfilled (e.g. =

registration, roaming, network resources)  This is a user setting that will=
 be =

persisted (in IMSI based storage.)  It should not be spuriously changed by =
the =

daemon.

> which is not the case after we detached because of roaming, so the
> D-Bus client would be misled.

No, 'Attached' is what is used for this purpose.

Both patches have been applied.  Thanks!

Regards,
-Denis

--===============6407423153141189974==--

