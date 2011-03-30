Content-Type: multipart/mixed; boundary="===============2721557626787823670=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] core: notify watches of already registered atoms
Date: Wed, 30 Mar 2011 13:42:03 -0500
Message-ID: <4D93797B.6080506@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D9E23@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2721557626787823670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> I do have an actual bug, which this patch fixes. I've been investigating =
why, with isiusb, the gprs atom sometimes fails to receive the network regi=
stration status and therefore fails to attach to the GPRS service. It turns=
 out that the problem comes from the client side code pattern for registeri=
ng atom watches. The code assumes that there will only be a single atom of =
the same type (registered or not).
> =

> Basically, gprs atom and the alternative netreg atoms are probing in para=
llel and may register themselves in a random order. If gprs finishes first,=
 it will correctly get a call to its watch handler when one of the netreg a=
toms completes its registration. However, if the order is reversed and gprs=
 finishes after the netreg atom, the following snippet of code tries to fin=
d the already registered netreg atom:
> =

>         netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NE=
TREG);
> =

>         if (netreg_atom && __ofono_atom_get_registered(netreg_atom))
>                 netreg_watch(netreg_atom,
>                                 OFONO_ATOM_WATCH_CONDITION_REGISTERED, gp=
rs);
> =

> The trouble here is that __ofono_modem_find_atom() just returns the first=
 neterg atom it finds, regardless of whether it is registered or not. In th=
is case it happens to be the wrong netreg (wgmodem2.5 version, which fails =
to probe), even though the other netreg atom is already present and registe=
red. Because of this, the watch funtion is never called.
> =


I changed the behavior of __ofono_modem_find_atom to only return ones
that are registered.  This is really what we want anyway, the only
exception was the devinfo atom which was never being registered.
However, I fixed that as well.

> I realize that there are other ways to fix this. The client side pattern =
could be changed to use __ofono_modem_foreach_atom() to look for already re=
gistered atoms, instead of doing the same within the __ofono_modem_add_atom=
_watch() as in my patch. This would introduce quite a bit of more code. Alt=
ernatively, an __ofono_modem_find_registered_atom() function could be intro=
duced to look for a registerd atom of a certain type (might be a good idea =
to do this in any case). Or isiusb (and any other similar cases) could be r=
evectored to not probe multiple atoms of the same type in parallel. However=
, we already create multiple GPRS context atoms as a matter of course, so t=
he assumption that there will only be a single instance is no longer valid =
for all atom types anyway. IMO, it would be good to get rid of the assumpti=
on altogether.
> =


The current code was really not setup to have multiple netreg atoms.
That is just not something we wanted to allow.  This might be OK in this
particular case where a single driver is involved.  However, if some
modem driver ends up creating every single atom twice to figure out what
modem is on the other side, then it is a serious performance issue.
Ideally I'd like the modem driver to be fixed.

> So, I like my patch because it removes a lot of copy-paste code and does =
not assume anything about how many atoms of a certain type there can be.
> =


In the end I agree and I applied all three of your patches and caught
some other occurrences you missed.

Regards,
-Denis

--===============2721557626787823670==--

