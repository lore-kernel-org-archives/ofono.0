Content-Type: multipart/mixed; boundary="===============3350831046418799454=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 0/1] Patch Description
Date: Wed, 03 Nov 2010 14:57:45 +0800
Message-ID: <1288767466-12837-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3350831046418799454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes we need to know the version of phonesim via a command. This patch=
 is to add this support. =


By the way, oFono introduces a file named version.h.in for the macro OFONO_=
VERSION. Can we use VERSION directly so that this file can be removed?

Yang Gu (1):
  Add option to support version

 Makefile.am  |    2 +-
 bootstrap    |    2 +-
 configure.ac |    1 +
 src/main.cpp |   11 +++++++++--
 4 files changed, 12 insertions(+), 4 deletions(-)

-- =

1.7.2.3


--===============3350831046418799454==--

