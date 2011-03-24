Content-Type: multipart/mixed; boundary="===============4229335399985402802=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/1] isimodem: fix network registration for older modems
Date: Thu, 24 Mar 2011 14:14:08 +0200
Message-ID: <1300968849-19877-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4229335399985402802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a patch to fix network registration with older ISI modems.
Verified with N95.

Claudio, could you give this a spin and let me know if this fixes
the problem for your 6760?

Br,

	MikaL

[PATCH 1/1] isimodem: fix network registration for older modems

 drivers/isimodem/network-registration.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

--===============4229335399985402802==--

