Content-Type: multipart/mixed; boundary="===============1338131522785352013=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v5 0/4] QMI LTE series
Date: Sat, 29 Apr 2017 14:46:39 +0200
Message-ID: <20170429124643.21080-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1338131522785352013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v4:

* Address feedback from Denis
* Lots of testing; this is robust against loss of network connectivity
and transitions across technologies.
* Dropped LTE atom for now since it's not doing anything interesting
currently... I'll resend it separately.

Original cover letter follows:

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

Jonas Bonn (4):
  qmi: watch packet status for spontaneous disconnection only
  qmi: use shared services
  qmi: use named status values
  qmi: activate default bearer context for LTE networks

 drivers/qmimodem/gprs-context.c         | 12 ++++--
 drivers/qmimodem/gprs.c                 | 72 +++++++++++++++++++++++++----=
----
 drivers/qmimodem/network-registration.c |  2 +-
 drivers/qmimodem/radio-settings.c       |  2 +-
 4 files changed, 66 insertions(+), 22 deletions(-)

-- =

2.9.3


--===============1338131522785352013==--

