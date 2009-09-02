Content-Type: multipart/mixed; boundary="===============7096059858028651527=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 18:32:24 +0300
Message-ID: <a32762a20909020832j4084cb9dud84f7304dfc9c440@mail.gmail.com>
In-Reply-To: <200909021000.23069.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7096059858028651527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2009/9/2 Denis Kenzior <denkenz@gmail.com>:
> So the general rule is that if a feature isn't explicitly allowed in 27.0=
07,
> we do not support it. =C2=A0There are exceptions to this of course. =C2=
=A027.007 only
> supports two states for context: activated and deactivated.

Ahem. Just like access selection mode is not in 27.007, yet Nokia has
it, and most AT modems have proprietary commands to query and set it
[1]. Maybe you call that the necessary exception to the rule, but I
think we might as well change the rule to:

"If a feature is explicitly requested by users of oFono, and can be
reasonably provided by modems that have it without braking those that
don't have it, it will be supported. And 27.007 can go fsck itself."
;-)

>> spec 27.007. However, the problem is that Maemo 5 already has UI
>> support for indicating that the connection is suspended, and that
>> makes it harder to drop the feature. Could the "suspended" status enum
>> still be left there, and just have the modems that don't support the
>> feature to never go to "suspended" mode?
>
> I'd rather not.
>
> If this feature is really required, then some sort of heuristic can be
> applied. =C2=A0(e.g. Powered on, Attached on, but context is deactivated =
most
> likely means temporary unavailability of resources)

You want the UI to implement this heuristic, when the modem plugin has
explicit knowledge of that state, but isn't telling? Please explain
how that makes the UI simpler?

Cheers,
Aki

[1] http://blogs.gnome.org/dcbw/2009/03/20/thats-when-i-reach-for-my-revolv=
er/

--===============7096059858028651527==--

