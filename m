Content-Type: multipart/mixed; boundary="===============2621078136421167444=="
MIME-Version: 1.0
From: Sebastian Mancke <asteban@gmx.de>
Subject: Re: DBus APIs
Date: Thu, 14 May 2009 08:50:53 +0200
Message-ID: <4A0BBF4D.10901@gmx.de>
In-Reply-To: <200905131151.01568.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2621078136421167444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

thanks for the direct answer. I don't wanted to be unfair at all ;-)

I Will take a deeper look into the differences of both DBus APIs to get
a better understanding of your reasons.

Regards,
  Sebastian



Denis Kenzior schrieb:
> Hi Sebastian,
> =

> On Wednesday 13 May 2009 10:17:50 Sebastian Mancke wrote:
>> Hi,
>>
>> I just saw the new project and was wondering why there is a completely
>> new project for this purpose.
>>
>> For me, ofone looks very similar to the freesmartphone.org initiative.
>> Did you take a deep look into other existing projects? What are your
>> opinions not to join those efforts?
> =

> We had a very deep look actually, and not only freesmartphone, but also =

> Qtopia.  These projects are very similar to oFono on the surface, but the=
ir =

> APIs just do not fill our needs.  E.g. to have a telephony stack that is =
GCF-
> certification ready and can be used by UI developers with minimal effort =
on =

> their part.
> =

> In the case of Qtopia it carries too much legacy baggage. In the case of =
FSO: =

> any API that exposes such low-level details as SMS DCS will never be good =

> enough.  UI developers simply should never have to care.
> =

>> In the case of freesmartphone.org I appreciate the goal of focusing on
>> the design of the DBus APIs, instead of 'just' an implementation. It
>> would be really cool to get alternative Implementations (e.g. written in
>> C) for those APIs. On the other hand it would be too bad not to regard
>> the experiences they made.
> =

> You're assuming that oFono developers do not have previous telephony =

> experience themselves.  Not a fair assumption at all ;)  We have our own =
ideas =

> and as pointed out above, we did learn from the FSO project.
> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
> =



-- =

tarent Gesellschaft f=C3=BCr Softwareentwicklung und IT-Beratung mbH

Heilsbachstr. 24, 53123 Bonn    | Poststr. 4-5, 10178 Berlin
fon: +49(228) / 52675-0         | fon: +49(30) / 27594853
fax: +49(228) / 52675-25        | fax: +49(30) / 78709617
durchwahl: +49(228) / 52675-17  | mobil: +49(171) / 7673249

Gesch=C3=A4ftsf=C3=BChrer:
Boris Esser, Elmar Geese
HRB AG Bonn 5168
Ust-ID: DE122264941

--===============2621078136421167444==--

