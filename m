Content-Type: multipart/mixed; boundary="===============8179230801240948253=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT commands not being parsed correctly from Samsung Wave HFP
Date: Fri, 07 Oct 2011 08:33:22 -0500
Message-ID: <4E8EFFA2.6010009@gmail.com>
In-Reply-To: <4E8EDB0D.9020304@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8179230801240948253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> =

> Right, the permissive one works perfectly. The phone has passed all our
> tests.
> =

> Now the next question is whether it would make sense to switch the HFP
> plugin to this parser, or this would rather be done selectively.
> =


It should be fine to switch to the permissive syntax parser permanently.
 The reason we used gsmv1 are largely historical (permissive did not
exist at the time) and we also wanted to gauge just how broken some HFP
implementations were.

> Which would be the drawbacks of using the permissive parser for all phone=
s?
> =


Permissive has rather limited support for command echo (e.g. ATE1), but
that should not cause any problems with HFP since the spec mandates echo
to be disabled by default.  However, if manufacturers can't get <CR><LF>
terminators right, maybe they also get this part wrong ;)

Regards,
-Denis

--===============8179230801240948253==--

