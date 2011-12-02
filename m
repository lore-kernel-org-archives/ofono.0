Content-Type: multipart/mixed; boundary="===============3911474575356684751=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/9] CPHS SPN, short-SPN support
Date: Fri, 02 Dec 2011 13:10:28 +0200
Message-ID: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3911474575356684751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the initial version of the CPHS SPN and short-SPN TODO items.

What's missing:

- changes to SPN callback in src/grps.c in order not to duplicate the logic=
 for SPN, CPHS SPN and short SPN in both files.

Regards,
Oleg

Oleg Zhurakivskyy (9):
  network: M9 coding style corrections
  network: Refactor sim_spn_read_cb()
  network: Rename spname to spn
  gprs-provision: Fix crash if no SPN present
  simutil: Add CPHS SPN and short-SPN IDs
  network: Add CPHS SPN, short-SPN flags
  network: Add CPHS SPN fallback
  network: Add CPHS short-SPN fallback
  TODO: Remove completed CPHS SPN and short-SPN tasks

 TODO                 |   14 -----
 examples/provision.c |    2 +-
 src/network.c        |  155 ++++++++++++++++++++++++++++++++++------------=
----
 src/simutil.h        |    2 +
 4 files changed, 109 insertions(+), 64 deletions(-)

-- =

1.7.5.4


--===============3911474575356684751==--

