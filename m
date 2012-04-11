Content-Type: multipart/mixed; boundary="===============0630131030633320647=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] Fix wrong Huawei modem behavior
Date: Wed, 11 Apr 2012 12:08:22 +0200
Message-ID: <1334138904-2005-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0630131030633320647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

When network is lost on Huawei modems during a data call, oFono core will
reset the context that was active and emit that it became inactive.
However it might happen the modem will not end the PPP session, it means
it will be active at driver level although we lost the network.
This behaviour is specific to Huawei, on ZTE for instance, the PPP ending is
initiated correctly by the modem itself everytime the network is lost.

I have thought about 2 ways to fix this:
	1 - If we try to connect again although previous PPP session is
	    still active, just try to use the current active PPP session,
	    like resuming the session. However there is no AT command to
	    do such resume_ppp.
	2- This the is the solution given in this set of patches, I just
	   trigger a g_at_ppp_shutdown()if we try to activate context although
	   it is already active, and when the no carrier is received,
	   we can restart the activate context logic (AT+CGDCONT, AT+CGDATA...)


Guillaume Zajac (2):
  huawei: Specify vendor in creating gprs context atom
  atmodem: Fix wrong behavior with Huawei modems

 drivers/atmodem/gprs-context.c |   80 ++++++++++++++++++++++++++++++++++++=
++++
 plugins/huawei.c               |    2 +-
 2 files changed, 81 insertions(+), 1 deletions(-)

-- =

1.7.4.1


--===============0630131030633320647==--

