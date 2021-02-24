Content-Type: multipart/mixed; boundary="===============3732308589954342006=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v2 0/4] oFono uBlox SARA R4 QMI 
Date: Wed, 24 Feb 2021 19:39:20 +1100
Message-ID: <20210224083924.3480-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3732308589954342006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Hope it can be accepted.

Thank you.

Kind regards,

- Jupiter

Bing Jupiter (4):
  SARA R4 QMI support
  Enable SARA R4 vendor ID for gprs create
  Add SARA R4 vendor ID
  Make SARA R4 vendor ID conditional being attach and detach

 drivers/atmodem/vendor.h |  1 +
 drivers/qmimodem/gprs.c  | 15 +++++++++++++++
 plugins/gobi.c           | 11 ++++++++++-
 plugins/udevng.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

-- =

2.25.1

--===============3732308589954342006==--

