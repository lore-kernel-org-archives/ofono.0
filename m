Content-Type: multipart/mixed; boundary="===============4675506105984764786=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Fix issue in ifx nitz time reporting
Date: Fri, 18 Mar 2011 08:58:08 -0700
Message-ID: <1300463889-4828-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4675506105984764786==
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

 drivers/atmodem/network-registration.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)


--===============4675506105984764786==--

