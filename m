Content-Type: multipart/mixed; boundary="===============2482778528115699980=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/2] ACFC and PFC options implementation
Date: Mon, 27 Jun 2011 18:15:28 +0200
Message-ID: <1309191330-5462-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2482778528115699980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v2 is:
	- make compression options application independant from
	  sending or receiving frames
	- add an option into GAtPPP to disable completely ACFC and
	  PFC

Guillaume Zajac (2):
  GAtPPP: Add ACFC option support
  GAtPPP: Add PFC option support

 gatchat/gatppp.c  |  145 +++++++++++++++++++++++++++++++++++++++++++++++++=
----
 gatchat/gatppp.h  |    3 +
 gatchat/ppp.h     |   12 ++++
 gatchat/ppp_lcp.c |   49 ++++++++++++++++--
 4 files changed, 195 insertions(+), 14 deletions(-)


--===============2482778528115699980==--

