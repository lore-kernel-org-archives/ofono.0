Content-Type: multipart/mixed; boundary="===============2904090670991801823=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v1 0/5] oFono uBlox SARA R4 QMI support 
Date: Tue, 23 Feb 2021 15:46:48 +1100
Message-ID: <20210223044653.4933-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2904090670991801823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Fixed taps,hope it satisfies your requirements.

Thank you.

Jupiter (1):
  Use tabs as Denis required

Jupiter (4):
  Change 1: SARA R4 QMI support
  Change 2: Add SARA R4 vendor ID
  Change 3: Check SARA R4 vendor ID, need to make it conditional on the
    actions being attach and detach
  Change 4: Add SARA R4 vendor and enable vendor in gprs create

 drivers/atmodem/vendor.h |  1 +
 drivers/qmimodem/gprs.c  | 15 +++++++++++++++
 plugins/gobi.c           | 11 ++++++++++-
 plugins/udevng.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

-- =

2.25.1

--===============2904090670991801823==--

