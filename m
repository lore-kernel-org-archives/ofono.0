Content-Type: multipart/mixed; boundary="===============4914715613981125591=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 0/4] Query retry counters
Date: Tue, 04 Jan 2011 11:06:15 -0200
Message-ID: <1294146379-30854-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4914715613981125591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is the second implementation for the retry counter task. The difference
from the previous approach is that now a dict with all the available retry
counters is returned. This way is possible to query the retry counter even =
when
PinRequired =3D=3D None, what allows us to properly handle calls to EnterPi=
n(),
LockPin(), UnlockPin() and so on.

The dict has the form { pin =3D 3, puk =3D 10, ... }. The driver implementa=
tion for
huawei modem is done using its proprietary command, which returns 4 counter=
s:

{SimManager} [/huawei0] Retries =3D { pin2 =3D 3, puk2 =3D 10, pin =3D 3, p=
uk =3D 10 }

Lucas De Marchi (4):
  include: add method to query pin Retries
  sim: query remaining pin retries
  doc: detail Retries property
  atmodem: implement query for remaining pin retries

 doc/sim-api.txt       |   12 ++++++
 drivers/atmodem/sim.c |   99 +++++++++++++++++++++++++++++++++++++++++++++=
++
 include/sim.h         |   11 +++++
 src/sim.c             |  102 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 224 insertions(+), 0 deletions(-)

-- =

1.7.3.4


--===============4914715613981125591==--

