Content-Type: multipart/mixed; boundary="===============0494715629188287775=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Mon, 22 Nov 2010 23:16:00 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70104DAF2A3@irsmsx504.ger.corp.intel.com>
In-Reply-To: <B737AE8337D70F47B693AC85FA440B08328D6CF9C4@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0494715629188287775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of Marko.Ovaska(a)nokia.com
>Sent: Monday, November 22, 2010 10:01 AM
>To: ofono(a)ofono.org; simon.lethbridge(a)stericsson.com
>Cc: sjur.brandeland(a)stericsson.com
>Subject: RE: [PATCH] doc: Add Location Services API
>
> I'm proposing that either we have =

> a) fully opaque 'raw' 3GPP defined frames between modem and Linux
> b) or well defined D-BUS API for LCS commands, but keeping the assistance=
 payload in 'raw' format

> Both a) and b) approaches break the 27.007 defined positioning commands. =
Rationale is that 27.007 positioning
> related re-formatting creates additional effort to any positioning engine=
, whether it resides in modem, dedicated
>  chip or in Linux.

For the option b, I would tend to not support you. I just recheck the 23.03=
2 (Universal GeoGraphical Area Description), and the number of ways to expr=
ess a position with velocity and uncertainty may not make the API simple.
Just have a look for instance the +CMOLR's XML DTD location_parameters. :)
Moreover, GPS vendors and other positioning professionals would find more l=
ogical to propose to use the WGS 84 datum for instance which is widely used=
 and leave the burden to map the position to 3GPP style... =


BR,

Fred

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============0494715629188287775==--

