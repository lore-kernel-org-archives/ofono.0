Content-Type: multipart/mixed; boundary="===============0162828690746400534=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v3 0/7] QMI LTE series
Date: Sat, 15 Apr 2017 17:34:40 +0200
Message-ID: <20170415153446.31803-2-jonas@southpole.se>
In-Reply-To: <20170415153446.31803-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0162828690746400534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v2:
* Revert callback data setup changes; the original model was fine so
  this amounted mostly to churn and, unfortunately, ended up introducing
  memory leaks
* Use ofono_gprs_context_deactivated in the detach_shutdown path instead
  of modifying release_active_contexts()
* Add support for roaming registration state

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

Jonas Bonn (7):
  qmi: free cb_data on error
  qmi: implement detach_shutdown method
  qmi: activate default bearer context for LTE networks
  qim: use named status value
  qmi: use destroy callback for activate_primary
  qmi: stop listening to packet service notifications
  qmi: consolidate ss_info handling functions

 drivers/qmimodem/gprs-context.c         |  69 +++++++---------
 drivers/qmimodem/gprs.c                 | 135 ++++++++++++++++++++++++----=
----
 drivers/qmimodem/network-registration.c |  53 ++++++-------
 3 files changed, 151 insertions(+), 106 deletions(-)

-- =

2.9.3


--===============0162828690746400534==--

