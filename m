Content-Type: multipart/mixed; boundary="===============3958146741246563674=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/1] Initial patches for gatchat IPv6 CP support
Date: Wed, 26 Oct 2011 17:20:31 +0300
Message-ID: <1319638832-22487-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3958146741246563674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

These patches implement IPv6 Control Protocol support for gatchat. The impl=
ementation is based and following gatchat's IPCP approach.

I tested with gsmdial and test-server, basic cases already work. In case an=
yone wants to initiate IPv6 CP address negotiation, patches to gsmdial and =
test-server are included.

These patches aren't complete, things yet to be done:

- Error case (Configure-Reject)
- Connect callback actions
- Proper integration with IPCP

I would appreciate your feedback.
 =

Regards,
Oleg

Oleg Zhurakivskyy (1):
  gatchat: Add IPv6 CP support

 Makefile.am           |    2 +-
 gatchat/gatppp.c      |   58 +++++++++-
 gatchat/gatppp.h      |    2 +
 gatchat/gsmdial.c     |    6 +
 gatchat/ppp.h         |   23 ++++
 gatchat/ppp_ipv6cp.c  |  306 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/test-server.c |   17 +++-
 7 files changed, 410 insertions(+), 4 deletions(-)
 create mode 100644 gatchat/ppp_ipv6cp.c

-- =

1.7.4.1


--===============3958146741246563674==--

