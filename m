Content-Type: multipart/mixed; boundary="===============7622376841094709710=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 0/6] gatchat IPv6 CP support
Date: Tue, 08 Nov 2011 14:46:52 +0200
Message-ID: <1320756418-30890-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7622376841094709710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

These patches correct issues found at the initial review.

New functionality:

- IPCP, IPv6 CP can co-exist.
- Add basic IPv6 CP connect callback actions.

I would appreciate your feedback.
 =

Regards,
Oleg

Oleg Zhurakivskyy (6):
  gatchat: Add IPv6 Control Protocol
  gatppp: Add IPv6 CP hooks
  gsmdial: Add IPv6 CP option
  test-server: Add IPv6 CP options
  gatppp: Add IPv6 CP connect, disconnect callbacks
  gsmdial: Add IPv6 CP connect hook

 Makefile.am           |    2 +-
 gatchat/gatppp.c      |   99 ++++++++++++-
 gatchat/gatppp.h      |   12 ++-
 gatchat/gsmdial.c     |   48 ++++++
 gatchat/ppp.h         |   11 ++
 gatchat/ppp_ipv6cp.c  |  390 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/test-server.c |   23 +++-
 7 files changed, 580 insertions(+), 5 deletions(-)
 create mode 100644 gatchat/ppp_ipv6cp.c

-- =

1.7.5.4


--===============7622376841094709710==--

