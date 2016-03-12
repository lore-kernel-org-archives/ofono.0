Content-Type: multipart/mixed; boundary="===============5662086826364490821=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [RFC v0 0/3] use GEREG for when in LTE networks
Date: Sat, 12 Mar 2016 15:51:29 +0100
Message-ID: <1457794292-21184-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5662086826364490821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here the first alternative to reading registration status on a LTE network
correctly. This is an aswer to the review request for the U-Blox Toby L2
support patches.

The other proposed alternative was to change how the gprs core handles
the attach status in LTE. But that needs a more thorough thinking. Until
then this would be a decent interim solution.

Thanks,
Dragos

Dragos Tatulea (3):
  gprs.h: add api for reading access technology
  gprs: add api for reading access technology
  atmodem: gprs: do CEREG instead of CGREG for LTE

 drivers/atmodem/gprs.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 include/gprs.h         |  2 ++
 src/gprs.c             |  5 +++++
 3 files changed, 47 insertions(+), 2 deletions(-)

-- =

2.5.0


--===============5662086826364490821==--

