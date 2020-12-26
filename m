Content-Type: multipart/mixed; boundary="===============5169105776647930853=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 0/2] gemalto: gprs context driver updates
Date: Sat, 26 Dec 2020 23:56:40 +0300
Message-ID: <20201226205642.10332-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5169105776647930853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and all,

This is the second version of the patches updating gemalto gprs context
driver. Major changes include support for automatic context activation
and support for gprs context authentication settings.

Regards,
Sergey

v1 -> v2

- drop patches 1, 2, 4 that has been already applied
- add detailed comment on AT^SWWAN patch
- address review comments


Sergey Matyukevich (2):
  gemalto: gprs: support automatic context activation
  gemalto: gprs: support authentication settings

 drivers/gemaltomodem/gprs-context.c | 155 ++++++++++++++++++++--------
 1 file changed, 114 insertions(+), 41 deletions(-)

-- =

2.29.2

--===============5169105776647930853==--

