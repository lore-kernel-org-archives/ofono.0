Content-Type: multipart/mixed; boundary="===============3944900553776908601=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 05:46:31 -0700
Message-ID: <1251895591.1266.86.camel@localhost.localdomain>
In-Reply-To: <a32762a20909020534r5d169e36id3ddbb981ca9d187@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3944900553776908601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Powered =3D on and RoamingAllowed =3D yes and Roaming =3D true will lea=
d to
> > auto-attach.
> >
> > Powered =3D on and RoamingAllowed =3D no and Roaming =3D true will lead=
 to
> > detach.
> >
> > Powered =3D on and Roaming =3D false will lead to auto-attach.
> >
> > Powered =3D off will lead to detach.
> =

> Why is auto-attach dependent on roaming?

power consumption. No need to attach if you don't wanna allow data
roaming.

> > We are not going to expose Attach() or Detach() method. As explained
> > there are global anyway and so pointless to expose. This can be handled
> > in the background without bothering the higher level application with
> > these details.
> =

> AFAIK, attach status of GPRS has both regulatory aspects to consider
> (some operators require always attached vs. some prohibit it) as well
> as power consumption issues (auto-attach might draw more power than
> on-demand, although there's an inverse effect on latency). These are
> issues you need to take into account, and higher layers in the stack
> definitely *need* to be aware of as well. Also, I don' t think oFono
> is the correct place for these decisions -> better expose a necessary
> API and let upper layers deal with it.

I disagree. We can have a config option that always attaches or attached
on demand, but this should not be exposed to any higher level
applications.

> In general, I appreciate the attempt to hide ugly details from
> applications, but unfortunately some things can't well be hidden.
> Another unrelated, but similar issue is network scanning. It just
> isn't going to work without us exposing it in the D-Bus API
> explicitly.
> =

> The reason is simple, Nokia modems suspend GPRS when scanning (or
> registering), simply because the operation will take roughly three
> times as long with GPRS attached. You will find this feature in
> current phones, too.
> =

> Now, there is no way we can have GPRS suspend without warning just
> because the stack deems it necessary to scan for networks. Again the
> intention is good, but the end result not so good. I don't want to
> start patching oFono to support this type of basic stuff.

I mentioned this before. We might need to add a config option to allow
integrators choose different behavior.

> >> In my proposal the "Status" variable was a three-state variable,
> >> having the states "attached", "detached" and "suspended". "Suspended"
> >> was specified to mean that the GPRS was attached, but temporarily not
> >> available (for instance because of a 2G phone call or temporary loss
> >> of cellular connectivity). In the IRC discussion someone said that
> >> this property would not be part of Denis's API because the tri-state
> >> variables were bad and the "suspended" status was not supported by
> >> spec 27.007. However, the problem is that Maemo 5 already has UI
> >> support for indicating that the connection is suspended, and that
> >> makes it harder to drop the feature. Could the "suspended" status enum
> >> still be left there, and just have the modems that don't support the
> >> feature to never go to "suspended" mode?
> >
> > I am still not seeing the point in what suspended will do for us and the
> > UI. And that Maemo 5 exposed such a state in the UI is not an argument
> > to keep doing it. I asked this before, what are we suppose to be doing
> > when we get signaled suspended?
> =

> You will find that practically every Nokia phone behaves this way,
> i.e., you make a call in 2G, and the UI will inform you that GPRS is
> suspended while on call.

So what is the difference signaling a disconnect and re-connect to the
application?

> >> Still one difference to my proposal was the dropping of the TX and RX
> >> byte counts, and the explanation that those statistics would be
> >> handled by the upper layers by reading the values from the network
> >> interface. I mentioned the problem where the connection was terminated
> >> by the network and the network interface was brought down before the
> >> upper layer had a chance to read the values. After giving the matter
> >> some thought, I still feel that for this reason the modem driver would
> >> need to get the TX/RX data and send it to the upper levels, if at all
> >> possible. Since many operators charge by the amount of data
> >> transferred, not losing the TX/RX data is quite crucial. At least
> >> Nokia phones have a GPRS data counter feature, that is supposed to
> >> show the transferred data. This said, I know that not all modem
> >> drivers can get the data from a connection that has been terminated by
> >> the network, but that does not mean that the modem drivers that can
> >> get the data should just discard it.
> >
> > This is for ConnMan or similar to figure out. And we can always count
> > via netfilter or some other facility. Counting inside oFono makes no
> > sense. However we could send out a statistics signal before taking the
> > interface down if it would be really needed. Making it part of the
> > properties and having to poll for it is wrong.
> =

> I believe emitting a signal was Ismo's original proposal.

I will talk with Stephen and David about this and what it a proper way
to collect statistics even if the interface goes away. They might have
some ideas. Changing the kernel and adding proper support for statistics
collection is not out the question here.

> > While oFono is sort of low-level, it is not that low-level. If it would
> > we could expose the native AT commands. So in summary the PDP context
> > are stored persistently in oFono. Like BlueZ remember paired devices.
> >
> > And for data roaming, we make it as simple as allowed =3D yes/no. This =
is
> > all the upper layer need to configure.
> >
> > Not exposing method for attach/detach is a logical consequence as
> > explained above. It is a global per modem detail and thus there is not
> > point in exposing it. Also there is not point in having ConnMan and some
> > other potential application fighting for it. We do auto-attach if
> > available and tell the applications the status. If Attached =3D yes, th=
en
> > the application can connect/disconnect contexts. As simple as that.
> =

> Then expose an AutoAttach =3D true/false property. That would work.

I prefer these details as configuration option that integrators set when
building the actual device. No need to have higher application change
it.

> >> By looking at Denis's proposal it is easy to see that my proposal
> >> wasn't perfect either. ;-) At least the GPRS registration state and
> >> possibly other properties need to be added to the D-Bus interface, and
> >> the API also needs to be made more future-proof by thinking how the
> >> network-initiated connections and the secondary contexts would be
> >> made.
> >
> > I prefer start simple and add more details later. Removing details is
> > more complicated than adding them.
> =

> For some of these features, there is no question whether or not we
> need them. I think you should be listening closely for the
> requirements we post, because this isn't something we *think* might be
> needed some day -- this is stuff that we've implemented and will ship,
> and expect to ship in the future.

Then please give examples. I asked this on IRC. I have never used
Secondary PDP Context before. Same goes for network initiated contexts.
I would really like to know which networks use what. And I think we need
to start collecting these information somewhere. It is important to know
what is used in production.

Regards

Marcel



--===============3944900553776908601==--

