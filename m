Content-Type: multipart/mixed; boundary="===============4114772918603149355=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 0/2] gemalto: enable ELS81x modem
Date: Sat, 27 Jun 2020 14:08:36 +0300
Message-ID: <20200627110838.808865-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4114772918603149355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

These two simple patches enable oFono support for ELS81x modem using
cdc_ether/cdc_acm drivers. As far as I know, new firmwares for ELS81x
enable support for MBIM as well. But I have not yet tried that.

Regards,
Sergey

Sergey Matyukevich (2):
  plugins: udevng: detect Centirion ELS81x modem
  plugins: gemalto: enable LTE for ELS81x

 plugins/gemalto.c | 5 ++++-
 plugins/udevng.c  | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- =

2.27.0

--===============4114772918603149355==--

