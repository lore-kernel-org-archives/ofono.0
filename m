Content-Type: multipart/mixed; boundary="===============7841744628946909929=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 00/20] *** LTE support with CSFB voice solution ***
Date: Mon, 11 Apr 2011 13:19:58 +0300
Message-ID: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7841744628946909929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

*** =

Subject: This patch enables LTE support to oFono with CSFB as voice solutio=
n.

Design considerations
1. Single packet atom to deal with multiple packet domains.
2. Can be considered as combination of gprs and eps functionality with just=
 needed segregation depending on the access technology camped.
 =

Aware of debate flared up in community on merits and demerits of individual=
 atoms or combined approach for dealing with EPS & GPRS.  =

After couple of turn arounds and prototype implementations, single packet a=
tom made better sense compared against segregated eps and gprs atoms. Reaso=
ns below briefly on advantages of single atom approach:
	1. Better architecture , in terms of living with a single packet domain at=
om catering for all the available bearer(s).
	2. Enables us to have a single packet interfaces.Exact bearer is more of c=
ontext property. =

	3. Would bring no change in DBus interfaces.
	3. Architecture fits the accommodating the IP continuity during CSFB. =


We have tested the patch against phonesim (modified for EPS).
Basic use cases that has been considered and tested are below.
1. Setting the modem to online.
2. CSFB  for voice call.
3. Recamp the modem into EPS once voice call terminates.

Todo List / Grey areas
1. We haven't addressed any IMS related issues here.
2. Not sure if USSD/voice call atoms apply for PS_ONLY Mode1/PS_ONLY Mode2.
3. Dedicated contexts haven't been addressed.

Note: This design & development has been done from our current understandin=
g of the 3gpp specs and tested against modified version of phonesim accordi=
ngly. =

I assume this would stand good in terms of giving us good base from where f=
urther development of LTE related things can be taken forward.
Modified phonesim would be sent as different patch.

Special thanks to Arun Ravindran, Jeevaka Badrappan, Rajesh Nagaiah for ext=
ending their support all along the activity.


 ***

Vijay Nayani (20):
  include: add generalised packet headers
  build: add generalised packet headers
  gprs: move bearer_to_string to common file
  build: add generalised packet files
  atmodem: add generalised packet source
  phonesim: use generalised packet source files
  common: add preferred_ue_mode enum
  include: add set preferred ue mode api
  modem: add preferred ue mode handling
  doc: add PreferredMode property to modem
  modem: generalise feature map table
  packet: add context type default
  include: add get technology api
  packet: add get technology api implementation
  include: add default context param and api
  packet: add default context implementation
  atmodem: add lte specific functions
  phonesim: Add cemode query implementation
  phonesim: atoms creation based on UE mode
  modem: Add netreg watch for tech switch

 Makefile.am                      |    9 +-
 doc/modem-api.txt                |   18 +
 drivers/atmodem/atmodem.c        |    4 +
 drivers/atmodem/atmodem.h        |    6 +
 drivers/atmodem/packet-context.c |  329 ++++
 drivers/atmodem/packet-service.c |  662 +++++++++
 include/modem.h                  |    2 +
 include/packet-context.h         |  127 ++
 include/packet-service.h         |  111 ++
 include/ps-provision.h           |   59 +
 plugins/phonesim.c               |  188 ++-
 src/common.c                     |   23 +
 src/common.h                     |   20 +
 src/gprs.c                       |   35 -
 src/modem.c                      |  143 ++-
 src/ofono.h                      |   14 +
 src/packet.c                     | 3054 ++++++++++++++++++++++++++++++++++=
++++
 src/ps-provision.c               |  101 ++
 18 files changed, 4789 insertions(+), 116 deletions(-)
 create mode 100644 drivers/atmodem/packet-context.c
 create mode 100644 drivers/atmodem/packet-service.c
 create mode 100644 include/packet-context.h
 create mode 100644 include/packet-service.h
 create mode 100644 include/ps-provision.h
 create mode 100644 src/packet.c
 create mode 100644 src/ps-provision.c


--===============7841744628946909929==--

