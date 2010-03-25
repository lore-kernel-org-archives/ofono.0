Content-Type: multipart/mixed; boundary="===============5281755288944299678=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/4] add PPP_DEAD and PPP_TERMINATE support 
Date: Wed, 24 Mar 2010 21:41:51 -0700
Message-ID: <1269492115-15412-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5281755288944299678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches complete implementation of the PPP_DEAD and PPP_TERMINATE =

phases, as well as allow this to be tested via gsmdial.

Kristen Carlson Accardi (4):
  remove unneeded debug statement
  add tracing for PPP terminate path
  separate memory cleanup from PPP shutdown
  gsmdial: shutdown ppp link if we have one.

 gatchat/gatppp.c  |   25 +++++++------------------
 gatchat/gsmdial.c |    4 +++-
 gatchat/ppp.c     |   27 +++++++++++++++++++++++----
 gatchat/ppp_cp.c  |   10 ++++++++++
 4 files changed, 43 insertions(+), 23 deletions(-)


--===============5281755288944299678==--

