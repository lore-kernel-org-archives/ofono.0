Content-Type: multipart/mixed; boundary="===============4797560327383012070=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 00/10] Re-factoring of gril and rilmodem
Date: Thu, 15 Oct 2015 18:46:53 +0200
Message-ID: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4797560327383012070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The attached patches include:

* Moving parcel processing code to the rilmodem driver
* Unit tests for parcel processing
* Removing of assertions

The unit tests illustrate one of the reasons for creating separate
modules for building/parsing parcels.

Alfonso Sanchez-Beato (10):
  gril: Move parcel processing to rilmodem
  gril: Adapt to movement of parcel processing
  rilmodem: Adapt to movement of parcel processing
  ril: Adapt to movement of parcel processing
  gril: Remove asserts
  rilmodem: Remove asserts
  ril: Remove asserts
  unit: Add unit tests for ril parcel processing
  build: Add rilmodem unit tests
  gitignore: Ignore rilmodem unit tests

 .gitignore                                         |    3 +
 Makefile.am                                        |   43 +-
 drivers/rilmodem/call-barring.c                    |    4 +-
 drivers/rilmodem/call-forwarding.c                 |    6 +-
 drivers/rilmodem/call-settings.c                   |    4 +-
 drivers/rilmodem/call-volume.c                     |    4 +-
 drivers/rilmodem/devinfo.c                         |    2 +-
 drivers/rilmodem/gprs-context.c                    |    9 +-
 drivers/rilmodem/gprs.c                            |    6 +-
 drivers/rilmodem/network-registration.c            |    6 +-
 drivers/rilmodem/radio-settings.c                  |    4 +-
 {gril =3D> drivers/rilmodem}/ril_constants.h         |    0
 gril/grilreply.c =3D> drivers/rilmodem/rilreply.c    |    5 +-
 gril/grilreply.h =3D> drivers/rilmodem/rilreply.h    |    1 +
 .../grilrequest.c =3D> drivers/rilmodem/rilrequest.c |    3 +-
 .../grilrequest.h =3D> drivers/rilmodem/rilrequest.h |    1 +
 gril/grilunsol.c =3D> drivers/rilmodem/rilunsol.c    |    3 +-
 gril/grilunsol.h =3D> drivers/rilmodem/rilunsol.h    |    1 +
 drivers/rilmodem/rilutil.c                         |  623 ++++++
 drivers/rilmodem/rilutil.h                         |   14 +
 drivers/rilmodem/sim.c                             |    6 +-
 drivers/rilmodem/sms.c                             |    6 +-
 drivers/rilmodem/ussd.c                            |    4 +-
 drivers/rilmodem/voicecall.c                       |    6 +-
 gril/gril.c                                        |   47 +-
 gril/gril.h                                        |    1 -
 gril/grilio.c                                      |    3 +-
 gril/grilio.h                                      |    2 +
 gril/grilutil.c                                    |  628 ------
 gril/grilutil.h                                    |   15 -
 plugins/ril.c                                      |   16 +-
 unit/test-rilreply.c                               | 2141 ++++++++++++++++=
++++
 unit/test-rilrequest.c                             | 1737 ++++++++++++++++
 unit/test-rilunsol.c                               |  698 +++++++
 34 files changed, 5331 insertions(+), 721 deletions(-)
 rename {gril =3D> drivers/rilmodem}/ril_constants.h (100%)
 rename gril/grilreply.c =3D> drivers/rilmodem/rilreply.c (99%)
 rename gril/grilreply.h =3D> drivers/rilmodem/rilreply.h (99%)
 rename gril/grilrequest.c =3D> drivers/rilmodem/rilrequest.c (99%)
 rename gril/grilrequest.h =3D> drivers/rilmodem/rilrequest.h (99%)
 rename gril/grilunsol.c =3D> drivers/rilmodem/rilunsol.c (99%)
 rename gril/grilunsol.h =3D> drivers/rilmodem/rilunsol.h (98%)
 create mode 100644 unit/test-rilreply.c
 create mode 100644 unit/test-rilrequest.c
 create mode 100644 unit/test-rilunsol.c

-- =

2.1.4


--===============4797560327383012070==--

