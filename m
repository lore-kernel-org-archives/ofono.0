Content-Type: multipart/mixed; boundary="===============7226966440424046903=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] ppp option cleanups 
Date: Mon, 12 Apr 2010 07:38:50 -0700
Message-ID: <1271083133-13760-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7226966440424046903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove all references to magic number, as we will not be supporting
loopback detection (resend)

Remove all references to pfc and acfc, we will not be implementing =

this.

Nak a config option request for any other authentication protocol
except CHAP/MD5

Kristen Carlson Accardi (3):
  ppp: remove references to magic number
  ppp: remove pfc and acfc
  ppp: nak unknown auth protocol

 gatchat/gatppp.c   |   26 --------------------------
 gatchat/ppp.h      |   14 ++++++++++----
 gatchat/ppp_auth.c |    2 --
 gatchat/ppp_cp.c   |    8 +++++++-
 gatchat/ppp_lcp.c  |   35 ++++++++++++++++++++++++-----------
 5 files changed, 41 insertions(+), 44 deletions(-)


--===============7226966440424046903==--

