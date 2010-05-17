Content-Type: multipart/mixed; boundary="===============3887510551556179187=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] detect NO CARRIER within HDLC 
Date: Mon, 17 May 2010 12:43:42 -0700
Message-ID: <1274125424-14490-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3887510551556179187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
I know this is a different design than what we discussed for this,
but wanted to run this one by you for your comments.  I was thinking
that maybe we didn't really need anything very complicated here, and
rather than using a GAtSyntax to detect a single string of interest,
we should just try to match on the string as we decode our packet.
I imagined we may get NO CARRIER embedded within a PPP stream and =

not on it's own.

Kristen Carlson Accardi (2):
  hdlc: detect NO CARRIER
  ppp: check for NO CARRIER

 gatchat/gathdlc.c |   37 ++++++++++++++++++++++++++++++++++---
 gatchat/gathdlc.h |    4 ++++
 gatchat/gatppp.c  |    1 +
 3 files changed, 39 insertions(+), 3 deletions(-)


--===============3887510551556179187==--

