Content-Type: multipart/mixed; boundary="===============7553980254049003794=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS Attach/Detach
Date: Wed, 14 Feb 2018 10:54:43 -0600
Message-ID: <a1122a66-e232-be39-529a-76540df4494c@gmail.com>
In-Reply-To: <CAKsXZz2n2Wgy94aNuJa0x643Gc-YQ6OVPJoamMzht0DBM-CmTA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7553980254049003794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nikolas,

> I had to remove the `else if (have_active_contexts(gprs) =3D=3D TRUE) { .=
.. =

> }` block because when attached was TRUE i still had active context and i =

> didn't want it to be deactivated.

This particular logic was added in commit:
154f4aca65b3b419239be75d0def276bd7f4dc8e

> =

> As the comments say it's to mitigate some PPP issues. Should that be the =

> case for all type of connections? What if my connection is RNDIS and not =

> PPP?
> =


Doesn't seem to have anything to do with PPP actually.  Anyway, there =

should be no active contexts if we're detached.  Otherwise this will =

confuse ConnMan, NetworkManager, etc.  The core tries to work around =

some of the more common issues, but ultimately the driver needs to make =

sure the transitions are well behaved.

Regards,
-Denis

--===============7553980254049003794==--

