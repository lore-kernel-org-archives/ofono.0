Content-Type: multipart/mixed; boundary="===============3578159045251554872=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/1] Fix issue in ifx nitz time reporting
Date: Fri, 18 Mar 2011 09:48:47 -0700
Message-ID: <1300466928-10794-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3578159045251554872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 CTZDST will be reported only if the network daylight saving time is
received from network as part of the MM information message. Due to this,
time was not reported to the core.
 Fix is to schedule the timer once the CTZV is received. This way, time
information will be reported always and also only once as expected.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  atmodem: fix issue in time reporting with ifx

 drivers/atmodem/network-registration.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)


--===============3578159045251554872==--

