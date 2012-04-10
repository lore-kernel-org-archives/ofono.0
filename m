Content-Type: multipart/mixed; boundary="===============8832289292375297305=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/2] ussd fixes
Date: Tue, 10 Apr 2012 17:35:03 +0200
Message-ID: <1334072105-32105-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8832289292375297305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix some issues with ussd:
        - Crash with speedup dongles
        - Crash with ZTE dongles

Nicolas Bertrand (2):
  ussd: rise up buffer lenght for ussd strings
  ussd: Fix speedup ussd encoding

 drivers/atmodem/ussd.c |   15 +++++++++++----
 plugins/speedup.c      |    2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

-- =

1.7.5.4


--===============8832289292375297305==--

