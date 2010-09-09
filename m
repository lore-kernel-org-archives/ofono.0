Content-Type: multipart/mixed; boundary="===============2967319909906802547=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/2] Add Suspended property to GPRS
Date: Thu, 09 Sep 2010 09:27:04 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7BA83F63@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1283957890.6640.50.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2967319909906802547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


> We have something similar with MMS where the hardware or network only
> supports one PDP context. In that case it is even worse actually since
> we take the proper IP connection away and it won't come back =

> as it was.

AFAIK, there is no reliable way to detect the case where an operator
only supports a single context per mobile. The second context activation
fails but there is no standard error code that would indicate why.
I suppose the number of contexts could be configurable somehow but
determining the correct setting for a particular operator is probably
a problem for the higher layers.

> In the end similar enough since if you wait long enough your TCP
> connections will time out.

TCP can take several minutes to time out, though. Mobile applications
will probably try to be a bit smarter if they have the means to =

do so.

> > The cause code could also be exposed in the DBus interface.
> =

> I wouldn't go there as exposing it over D-Bus. However =

> telling the core
> a bit more details about this would be a good idea. Then it can decide
> to either delay the notification or send it right away.
> =

> I prefer to start simple first. Making it too complicated in the
> beginning is a bad idea. And giving application too much =

> information is
> a bad idea anyway. They should only get what they really =

> need. And right
> now I don't see a need to tell them any more details, than the GPRS
> connection is suspended. And that means we don't know when we get it
> back. So deal with this situation.

Agreed.

> Corner cases where a phone call gets hung up right away is nasty, but
> that happens, but then again, the user was making a phone call in the
> first place. So a user initiated choice we are trying to cope with.

Well, the user has no control over incoming calls, aside from rejecting
them or going to offline mode. Not much can be done about that, though.

> However "suspend" with flag "available" sounds like a bad =

> API. Either we
> call this gprs_state or something similar or we have suspend/resume
> pairs. Just to be a bit more symmetric here.

A suspend/resume pair sounds good to me. I'll do the patches.

	MikaL

--===============2967319909906802547==--

