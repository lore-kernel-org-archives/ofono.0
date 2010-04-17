Content-Type: multipart/mixed; boundary="===============4887333589999163464=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] HDLC fixes 
Date: Sat, 17 Apr 2010 11:15:32 -0700
Message-ID: <1271528135-12337-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4887333589999163464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix some issues with the HDLC code, and then use it in PPP.
The first 2 patches are a resend of previous patches, the last
is new to this series.

Kristen Carlson Accardi (3):
  hdlc: allow for scanning and escaping
  hdlc: handle wrapped buffers
  ppp: use GAtHDLC

 gatchat/gathdlc.c  |  121 +++++++++++++-----
 gatchat/gathdlc.h  |   12 ++
 gatchat/gatppp.c   |  347 +++++++++---------------------------------------=
----
 gatchat/ppp.h      |   11 ++
 gatchat/ppp_auth.c |    2 +-
 gatchat/ppp_cp.c   |    6 +-
 gatchat/ppp_net.c  |    3 +-
 7 files changed, 175 insertions(+), 327 deletions(-)


--===============4887333589999163464==--

