Content-Type: multipart/mixed; boundary="===============6280513067859249331=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 4/4] isigen: make number of PDP contexts configurable
Date: Thu, 11 Nov 2010 18:25:26 +0900
Message-ID: <1289467526.3266.46.camel@aeonflux>
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782BE95B62A6@NOK-EUMSG-03.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6280513067859249331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> > why to do you bother making this a configurable option? What isthe
> > benefit here?
> =

> The maximum context count is a compile time option for the ISI modem. Hav=
ing this option in oFono makes it possible to optimize the APE side resourc=
e usage instead of overallocating drivers and contexts. Not a huge benefit,=
 I guess, but the cost is not huge either.
> =

> Not a big deal, though. I'll try to see if the context limit could be pro=
bed somehow.

if it can be probed from the ISI modem that would be perfect.

> > Personally I think that always enabling 4 context if the hardware
> > supports it should be enough. If you do support more then just enable
> > more all the time. There are no real resources used in context of ISI
> > anyway. The AT command based modems have a different problem since for
> > most of them we need an extra TTY/DLC and an extra GAtChat object, but
> > ISI does not have that problem.
> =

> I don't see the difference. The AT modem resources should be allocated dy=
namically as well, at context activation time. (Maybe that's the case alrea=
dy, I didn't really check.) In any case, I believe oFono has to allow thing=
s like external AT command processors and vendor specific modem tools to ac=
cess the TTY's directly bypassing oFono. This means the mux channels should=
 not be preallocated.

That is sort of a dream world. AT command based modems where you need a
TTY/DLC for every active GPRS context are not cheap. It is not a crazy
waste of resources, but it is some kind of waste.

Regards

Marcel



--===============6280513067859249331==--

