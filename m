Content-Type: multipart/mixed; boundary="===============7804851370788455329=="
MIME-Version: 1.0
From: Alex Kanavin <ak@sensi.org>
Subject: Re: ofono-qt - anything to add/improve?
Date: Tue, 05 Jul 2011 15:38:16 +0300
Message-ID: <CANNYZj-GN6fRRw9mQ4ip74277daQyLpQyFrk-tBPYm3jHem-NA@mail.gmail.com>
In-Reply-To: <4E11D106.1060809@techworks.ie>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7804851370788455329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/7/4 Christian Gagneraud <chris@techworks.ie>:

> So, to make it clear and simple, is there any official repository for
> ofono-qt?

If you mean a directory with official tarballs, there is no such
thing. I had assumed that anyone can roll their own tarball easily by
cloning the git repository and then using 'git archive'. Build systems
ought to be able to talk directly to git nowadays anyway :)

> 2. "slotification" of various member functions:
>
> member functions like OfonoModem.setPowered(bool powered) could be declar=
ed
> slots, so that it can be connected to signals of same signature like
> QCheckBox.toggled(bool)

Yes - this will be fixed. Although you should be careful in connecting
property setting directly to dual state ui widgets like chechboxes -
there can be significant lag. Better to have a third state that
indicates that a property is being set or disable the checkbox until
the setting completes or fails.

> 3. More convenient function members (I'm getting picky, I know)
> example for OfonoModem:
> =C2=A0- existing: setPowered(bool powered), setOnline(bool online)
> =C2=A0- proposed addition: powerOn(), powerOff(), goOnline(), goOffline()
>
> This with the proposed slotification, would make libofono-qt even easier =
to
> use.

It's an explicit design goal that ofono-qt provides a direct,
one-to-one mapping of ofono's d-bus interface. This means no
convinience functions on top or other bells and whistles (the only
exception is modem selection).

> 4. Use enumeration instead of strings:
> for example in OfonoConnmanContext:
> enum ContextType {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ContextTypeInternet,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ContextTypeMms,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ContextTypeWap,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ContextTypeIms,
> };
> void setType(ContextType type);
> instead of:
> void setType(const QString& type)
>
> I know, that it is less flexible (especially if the oFono DBUS API change=
),
> but it can help to reduce size of binaries and be slightly more efficient.
> [On an ARM9(a)200MHz, every little helps! ;)]

This adds significant maintenance overhead with a gazillion of enums
that need to be kept up to date. Ofono API changes often, and I don't
think it's worth it.

> 3. bug with path()?
> Each time my code call OfonoXyz.path(), I get a message in the console:
> QDBusArgument: read from a write-only object
>
> I don't know where does it come from, perhaps it's not even related to
> ofono-qt...

I have no idea where it comes from either, because path() returns a
class member, and never even touches d-bus. Can you provide a
testcase?

> 4. partial interface implementation
> There some classes that are missing properties/ function members.
> On top of my head:
> GSM band, UMTS band and fast dormancy in RadioSettings

Yep - I think these were added to ofono after the class had been
implemented. There is no easy way to keep those in sync (test cases
are not going to help here), but at some point I will go through the
ofono/doc/* and make a list of things to update. Or just send me
patches.

> 5. More documentation (doxygen)
> =C2=A0I know that by reading the ofono DBUS API, it's easy to figure out =
how to
> use ofono-qt. But as ofono-qt offers an abstraction of the ofono DBUS API,
> it might be nice to have a full ofono-qt API documentation.
> I guess it would be mainly copy/paste from ofono/doc/*-api.txt.

Again, significant maintenance overhead with too little benefit. It
would be truly a mind-numbing task to first doxygenize the textfiles
and then keep them in sync.

> 6. Enhance ofono-qt with a concept of PIN agent?
> It's easy to use SimManager.pinRequiredChanged() signals, but perhaps a
> simple PIN agent class might be a nice thing to have.
> At the SimManager level, or even better at the Modem level
> OfonoModem.registerSimPinAgent(myAgent);

It's that way, because ofono works that way. :) For those interfaces
where ofono is using d-bus agents (e.g. SIM toolkit), there will be
agents in ofono-qt as well.

-- =

Alexander

--===============7804851370788455329==--

