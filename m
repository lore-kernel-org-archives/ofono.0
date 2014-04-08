Content-Type: multipart/mixed; boundary="===============5993193896608210828=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH 0/4] Add subscriber number for handsfree
Date: Tue, 08 Apr 2014 09:21:43 +0100
Message-ID: <1396945307-12195-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5993193896608210828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Here are the changes to add the subscriber number to the handsfree
API.

Thanks,

Andrew


Andrew Earl (4):
  doc: Add subscriber number to handsfree-api
  include: Add subscriber number to handsfree API
  hfp: Add subscriber number to handsfree properties
  hfp: Add CNUM query to handsfree interface for subscriber number

 doc/handsfree-api.txt        |   4 ++
 drivers/hfpmodem/handsfree.c |  88 ++++++++++++++++++++++++++++++
 include/handsfree.h          |   6 +++
 src/handsfree.c              | 124 +++++++++++++++++++++++++++++++++++++++=
++--
 4 files changed, 219 insertions(+), 3 deletions(-)

-- =

1.7.11.7


--===============5993193896608210828==--

