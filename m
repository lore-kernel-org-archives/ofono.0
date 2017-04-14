Content-Type: multipart/mixed; boundary="===============8067795940654854962=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 00/13] QMI LTE series
Date: Fri, 14 Apr 2017 23:36:33 +0200
Message-ID: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8067795940654854962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LTE is different from other 'GPRS' technologies in that a default bearer
always gets set up when the modem registers to the network.  Ofono has
some support for this and this series tries to set this up for QMI
modems.

The key to understanding this series is to understand that QMI modems
do not automatically enable the network interface when connecting to
an LTE network, even though the default bearer is already set up.  A
call to "start network" needs to be made in order to allow packets to
flow.  So the jist of this series is:

i) detect network registration to LTE network
ii) call ofono_gprs_cid_activated
iii) in read_settings, start by calling "start network"

...and then there are some other adjustments in the series to make
this all work.

I've tested this with my EC21, both on LTE and UMTS networks.  It
all seems to work, including moving out of network connectivity and
bringing the modem repeatedly online/offline.

One open question at this point:

* What happens if the connection manager calls deactivate_context
on the default bearer context?  I don't see that any other drivers
guard against this, and the QMI driver will happily stop the network
interface even though the default bearer is still up in the background.

Jonas Bonn (13):
  qmi: duplicate callback data correctly
  qmi: fix typo
  gprs: release active contexts completely
  gprs: _cid_activated is an 'attaching' state
  gprs: set driver_attached when activating automatic contexts
  qmi: implement detach_shutdown method
  qmi: read_settings needs to call start network
  qmi: don't leak cbd and rely on destroy function
  qmi: activate default bearer context for LTE networks
  qmi: use destroy callback for activate_primary
  qmi: stop listening to packet service notifications
  qmi: rely on destroy callback
  qmi: consolidate ss_info handling functions

 drivers/qmimodem/gprs-context.c         | 126 +++++++++++++---------------
 drivers/qmimodem/gprs.c                 | 140 ++++++++++++++++++++++------=
----
 drivers/qmimodem/nas.h                  |   2 +-
 drivers/qmimodem/network-registration.c |  73 +++++++----------
 src/gprs.c                              |  22 ++++-
 5 files changed, 205 insertions(+), 158 deletions(-)

-- =

2.9.3


--===============8067795940654854962==--

