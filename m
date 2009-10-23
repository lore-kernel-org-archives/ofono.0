Content-Type: multipart/mixed; boundary="===============8960412207782055887=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] GPRS context setup and teardown
 (doc/dataconnectionmanager-api.txt)
Date: Fri, 23 Oct 2009 17:22:29 -0500
Message-ID: <200910231722.29794.denkenz@gmail.com>
In-Reply-To: <1255383359-31470-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8960412207782055887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi,
> here's a one-big-patch that adds the DataConnectionManager interface
> according to doc/dataconnectionmanager-api.txt without any glue for
> the multiplexer or PPP setup.  Only AT backend is implemented.

Ok, so I took the patch and hacked on it for a while.  I disagreed with how =

you split up responsibilities, so much of the logic got moved into the core =

and the driver was simplified.  Some parts might have been lost along the w=
ay.

I also decided to split up GPRS into two atoms to ease integration of hardw=
are =

that supports dedicated network interfaces.  This way the attach / GPRS =

network registration parameters can be reused from the generic 'atmodem' =

driver, while specific context handling can be customized.

I'm happy to report that this actually sort of works with my MBM card.  I c=
an =

even define a GPRS context and activate it.  Of course the card crashes as =
soon =

as I do :)

>
> One issue with the AT implementation of the api is that "Powered" (a
> read-write property) can be set independently of "Attached" (read-only
> property) and remain set when "Attached" is clear.  The semantics would
> be that the network doesn't have resources to let the modem attach,
> but the modem waits for the resources to become available and then
> attaches.  On AT the modem is in this state only when executing +CGATT,
> so currently the code will rerun +CGATT as soon as the previous one
> returns with error, probably starving other commands.  A possible
> workaround would be for "Powered" to flip back to False after the modem
> fails to attach once, or give up on having separate properties.
> Alternatively we could re-try to attach periodically but on one modem
> I've tried +CGATT fails after about 1 minute (that's the Calypso) and
> on another only about 0.5s (Nokia phones with AT emulation).

We should probably do both with some intelligence.  Right now we lose GPRS =

registration when we run an operator scan (the modem turns off GPRS =

automagically), so running CGATT afterwards is OK.  But then we should do i=
t =

in increasing timeouts.  E.g. 5 seconds, 10 seconds, etc and turn off entir=
ely =

once we have given up.

I don't think this is necessary, all voice dial strings are suffixed by ';'=
, so =

dialing *99***1#; should result in an error.

Some parts I still don't understand:

in set_registration_status:
        attached =3D (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
                        status !=3D NETWORK_REGISTRATION_STATUS_ROAMING);
        if (gprs->attached !=3D (int) attached &&
                        !(gprs->flags & GPRS_FLAG_ATTACHING)) {
                gprs->attached =3D (int) attached;

                ofono_dbus_signal_property_changed(conn, path,
                                DATA_CONNECTION_MANAGER_INTERFACE,
                                "Attached", DBUS_TYPE_BOOLEAN,
                                &attached);

                gprs_netreg_update(gprs);
        }

I do not understand this logic at all.  Can't we always call =

gprs_netreg_update here?  In my opinion Attached should only be emitted onc=
e =

it really has changed (e.g. in the callback)

gprs_netreg_update:
                /* Prevent further attempts to attach */
                if (!attach && gprs->powered) {
                        gprs->powered =3D 0;

                        path =3D __ofono_atom_get_path(gprs->atom);
                        ofono_dbus_signal_property_changed(conn, path,
                                        DATA_CONNECTION_MANAGER_INTERFACE,
                                        "Powered", DBUS_TYPE_BOOLEAN, &valu=
e);
                }

This is just too evil.  Can't we set another flag that attached conditions =
have =

changed while we were attaching/detaching and that we should recheck those =

conditions when we return from attach/detach?

In gprs_set_property:

You should really ignore set property requests that set the value to the =

already set value.  Simply return success and don't do anything else.

Regards,
-Denis

--===============8960412207782055887==--

