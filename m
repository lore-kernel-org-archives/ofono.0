Content-Type: multipart/mixed; boundary="===============8097857569012934779=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 0/3] Add STK APDU editor
Date: Fri, 24 Aug 2012 10:32:32 +0200
Message-ID: <1345797155-27517-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8097857569012934779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add to phonesim the capability to symply send STK APDU

Nicolas Bertrand (3):
  phonesim: accept STK command without application
  controlbase_ui: Add manual stk command editor
  control: Link functionnality to STK command editor

 src/control.cpp    |   12 ++++++++++++
 src/control.h      |    2 ++
 src/controlbase.ui |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/phonesim.cpp   |    8 ++++++--
 4 files changed, 66 insertions(+), 2 deletions(-)

-- =

1.7.9.5


--===============8097857569012934779==--

