Content-Type: multipart/mixed; boundary="===============7916079659188464692=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/9] Rilmodem driver
Date: Tue, 13 Oct 2015 18:07:49 +0200
Message-ID: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7916079659188464692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series implements the rilmodem driver, which uses Android's
radio interface layer (RIL, part of the Android HAL) to interact with
the modem.

The driver is almost feature-complete with some exceptions, being CBS
and SAT the most prominent.

Besides the driver, the patches include the following plugins:
* ril.c: Plugin for Android modems
* infineon.c: Plugin for infineon modems, which are a variant of the ril
  modem
* rildev: plugin that creates ril-type modems using environment
  variables

Finally, the patches contain some minor modifications of the core code
to export a couple of enumerations used by the driver.

The driver is used by Ubuntu for Phones and Sailfish and is quite stable
at the moment.

Alfonso Sanchez-Beato (5):
  include: Add definitions for phone number types
  infineon: Definitions for infineon modem
  infineon: Plugin for infineon modems
  rildev: plugin that creates ril-type modems
  build: Add rilmodem to the build

Tony Espy (4):
  src: make bearer/operator enums public
  gril: Library to communicate with rild
  rilmodem: driver for Android modems
  ril: Plugin for Android modems

 Makefile.am                                |   44 +-
 configure.ac                               |    5 +
 drivers/infineonmodem/infineon_constants.h |   77 ++
 drivers/rilmodem/call-barring.c            |  245 +++++
 drivers/rilmodem/call-forwarding.c         |  327 +++++++
 drivers/rilmodem/call-settings.c           |  286 ++++++
 drivers/rilmodem/call-volume.c             |  182 ++++
 drivers/rilmodem/devinfo.c                 |  218 +++++
 drivers/rilmodem/gprs-context.c            |  585 +++++++++++
 drivers/rilmodem/gprs.c                    |  487 ++++++++++
 drivers/rilmodem/gprs.h                    |   46 +
 drivers/rilmodem/network-registration.c    |  566 +++++++++++
 drivers/rilmodem/phonebook.c               | 1055 ++++++++++++++++++++
 drivers/rilmodem/radio-settings.c          |  300 ++++++
 drivers/rilmodem/radio-settings.h          |   47 +
 drivers/rilmodem/rilmodem.c                |   78 ++
 drivers/rilmodem/rilmodem.h                |   71 ++
 drivers/rilmodem/rilutil.c                 |  194 ++++
 drivers/rilmodem/rilutil.h                 |  165 ++++
 drivers/rilmodem/sim.c                     | 1200 +++++++++++++++++++++++
 drivers/rilmodem/sms.c                     |  315 ++++++
 drivers/rilmodem/ussd.c                    |  264 +++++
 drivers/rilmodem/vendor.h                  |   32 +
 drivers/rilmodem/voicecall.c               |  824 ++++++++++++++++
 drivers/rilmodem/voicecall.h               |   71 ++
 gril/gfunc.h                               |   42 +
 gril/gril.c                                | 1295 +++++++++++++++++++++++++
 gril/gril.h                                |  172 ++++
 gril/grilio.c                              |  399 ++++++++
 gril/grilio.h                              |   69 ++
 gril/grilreply.c                           | 1450 ++++++++++++++++++++++++=
++++
 gril/grilreply.h                           |  185 ++++
 gril/grilrequest.c                         | 1161 ++++++++++++++++++++++
 gril/grilrequest.h                         |  293 ++++++
 gril/grilunsol.c                           |  638 ++++++++++++
 gril/grilunsol.h                           |   99 ++
 gril/grilutil.c                            |  830 ++++++++++++++++
 gril/grilutil.h                            |   63 ++
 gril/parcel.c                              |  293 ++++++
 gril/parcel.h                              |   53 +
 gril/ril_constants.h                       |  429 ++++++++
 include/types.h                            |    6 +
 plugins/infineon.c                         |   77 ++
 plugins/ril.c                              |  461 +++++++++
 plugins/ril.h                              |   30 +
 plugins/rildev.c                           |  133 +++
 src/common.h                               |   20 +
 src/gprs.c                                 |   12 -
 src/network.c                              |    8 -
 49 files changed, 15881 insertions(+), 21 deletions(-)
 create mode 100644 drivers/infineonmodem/infineon_constants.h
 create mode 100644 drivers/rilmodem/call-barring.c
 create mode 100644 drivers/rilmodem/call-forwarding.c
 create mode 100644 drivers/rilmodem/call-settings.c
 create mode 100644 drivers/rilmodem/call-volume.c
 create mode 100644 drivers/rilmodem/devinfo.c
 create mode 100644 drivers/rilmodem/gprs-context.c
 create mode 100644 drivers/rilmodem/gprs.c
 create mode 100644 drivers/rilmodem/gprs.h
 create mode 100644 drivers/rilmodem/network-registration.c
 create mode 100644 drivers/rilmodem/phonebook.c
 create mode 100644 drivers/rilmodem/radio-settings.c
 create mode 100644 drivers/rilmodem/radio-settings.h
 create mode 100644 drivers/rilmodem/rilmodem.c
 create mode 100644 drivers/rilmodem/rilmodem.h
 create mode 100644 drivers/rilmodem/rilutil.c
 create mode 100644 drivers/rilmodem/rilutil.h
 create mode 100644 drivers/rilmodem/sim.c
 create mode 100644 drivers/rilmodem/sms.c
 create mode 100644 drivers/rilmodem/ussd.c
 create mode 100644 drivers/rilmodem/vendor.h
 create mode 100644 drivers/rilmodem/voicecall.c
 create mode 100644 drivers/rilmodem/voicecall.h
 create mode 100644 gril/gfunc.h
 create mode 100644 gril/gril.c
 create mode 100644 gril/gril.h
 create mode 100644 gril/grilio.c
 create mode 100644 gril/grilio.h
 create mode 100644 gril/grilreply.c
 create mode 100644 gril/grilreply.h
 create mode 100644 gril/grilrequest.c
 create mode 100644 gril/grilrequest.h
 create mode 100644 gril/grilunsol.c
 create mode 100644 gril/grilunsol.h
 create mode 100644 gril/grilutil.c
 create mode 100644 gril/grilutil.h
 create mode 100644 gril/parcel.c
 create mode 100644 gril/parcel.h
 create mode 100644 gril/ril_constants.h
 create mode 100644 plugins/infineon.c
 create mode 100644 plugins/ril.c
 create mode 100644 plugins/ril.h
 create mode 100644 plugins/rildev.c

-- =

2.1.4


--===============7916079659188464692==--

