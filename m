Content-Type: multipart/mixed; boundary="===============0624612732999923442=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] [RFC] Do the PIN check in SIMManager
Date: Wed, 23 Sep 2009 15:02:50 -0500
Message-ID: <200909231502.51564.denkenz@gmail.com>
In-Reply-To: <fb249edb0909231347ha981387ge221b34f1e2e4839@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0624612732999923442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Should we have a read-only property so clients know what the current
> state is?  Unfortunately this would be some 6 properties and 6 more

Actually more like 7.  However, right now we only really care about pin loc=
k.  =

We can theoretically optimize the query somewhat by looking at whether the =

CPIN is being asked for at startup.  If it is, the PIN is locked, and unloc=
ked =

otherwise.  Then the LockPin / UnlockPin callbacks can update the state =

appropriately.

So the thought right now is to add LockedPins property, which will be a lis=
t =

of pins that are currently locked.  If nothing is locked, an empty list is =

returned.

For now I'm planning to implement LockedPins support for pin only, but the =

others will have to be queried eventually as well.

> commands on startup, for little gain.  I attached a diff to add plugin
> interface for this without dbus interface.  The other two changes are
> just clean-up.

Patches have been applied, thanks.

Regards,
-Denis

--===============0624612732999923442==--

