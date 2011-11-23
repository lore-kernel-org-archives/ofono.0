Content-Type: multipart/mixed; boundary="===============0666842635213135588=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 0/6] gatchat IPv6 CP support
Date: Wed, 23 Nov 2011 14:57:46 +0200
Message-ID: <1322053072-20252-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0666842635213135588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

These patches add IPv6 CP support to gatppp and tools.

Changes from v2:

- gatppp API for IPv4, IPv6, IPv4v6 contexts reworked.
- IPv6 CP integration with gatppp updated.
- ppp_net is shared in between IPv4 and IPv6.
- gsmdial, test-server tools updated.

Regards,
Oleg

Oleg Zhurakivskyy (6):
  gatppp: Add IPv6 CP hooks
  gsmdial: Add IPv6 CP option
  test-server: Add IPv6 CP options
  ppp_net: Add reference count
  gatppp: Add IPv6 CP connect callback
  gsmdial: Add IPv6 CP connect hook

 gatchat/gatppp.c      |  270 ++++++++++++++++++++++++++++++++++++++++-----=
----
 gatchat/gatppp.h      |   22 ++++
 gatchat/gsmdial.c     |   93 ++++++++++++++++-
 gatchat/ppp.h         |   10 ++-
 gatchat/ppp_ipv6cp.c  |   54 +++++++---
 gatchat/ppp_net.c     |   17 +++
 gatchat/test-server.c |   52 ++++++++--
 7 files changed, 438 insertions(+), 80 deletions(-)

-- =

1.7.5.4


--===============0666842635213135588==--

