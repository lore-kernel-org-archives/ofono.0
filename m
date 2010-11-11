Content-Type: multipart/mixed; boundary="===============1563229708672824710=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 4/4] isigen: make number of PDP contexts configurable
Date: Thu, 11 Nov 2010 09:16:00 +0100
Message-ID: <C358A26273CF2948B8BCDBA661A581782BE95B62A6@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1289411557.9615.271.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1563229708672824710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> why to do you bother making this a configurable option? What isthe
> benefit here?

The maximum context count is a compile time option for the ISI modem. Havin=
g this option in oFono makes it possible to optimize the APE side resource =
usage instead of overallocating drivers and contexts. Not a huge benefit, I=
 guess, but the cost is not huge either.

Not a big deal, though. I'll try to see if the context limit could be probe=
d somehow.

> Personally I think that always enabling 4 context if the hardware
> supports it should be enough. If you do support more then just enable
> more all the time. There are no real resources used in context of ISI
> anyway. The AT command based modems have a different problem since for
> most of them we need an extra TTY/DLC and an extra GAtChat object, but
> ISI does not have that problem.

I don't see the difference. The AT modem resources should be allocated dyna=
mically as well, at context activation time. (Maybe that's the case already=
, I didn't really check.) In any case, I believe oFono has to allow things =
like external AT command processors and vendor specific modem tools to acce=
ss the TTY's directly bypassing oFono. This means the mux channels should n=
ot be preallocated.

	MikaL

--===============1563229708672824710==--

