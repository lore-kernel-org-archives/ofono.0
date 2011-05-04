Content-Type: multipart/mixed; boundary="===============7074967184886442310=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] Introduce new gprs APIs to setup STK PDP context
Date: Wed, 04 May 2011 19:26:38 +0200
Message-ID: <1304530002-13336-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7074967184886442310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

New APIs are introduced in the gprs atom in order to setup a PDP context di=
rectly from the stk atom.
In order to privatize the PDP context created from STK, a new PDP context t=
ype ('stk') is introduced.
By registering a callback, the STK atom is notified when the dedicated PDP =
context is activated and =

the interface setup is extended to add also a host route for STK PDP contex=
t type. =


Philippe Nunes (4):
  gprs: Add 'stk' gprs context type
  gprs: Add new external APIs to create, activate and remove a PDP
    context
  stk: Use gprs APIs to create, activate and remove a dedicated PDP
    context
  gprs: Add a host route for STK context type.

 include/gprs-context.h |    1 +
 include/gprs.h         |   16 +++
 src/gprs.c             |  292 +++++++++++++++++++++++++++++++++++++++++++-=
----
 src/stk.c              |  132 +++++++++++++++++++---
 4 files changed, 398 insertions(+), 43 deletions(-)


--===============7074967184886442310==--

