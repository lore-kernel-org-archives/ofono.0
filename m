Content-Type: multipart/mixed; boundary="===============2843473337431339678=="
MIME-Version: 1.0
From: devel@jlranta.com
Subject: [PATCH] huawei: fix AT^DDSETEX=2 timing
Date: Sat, 10 Mar 2012 18:46:12 +0200
Message-ID: <1331397973-28076-1-git-send-email-devel@jlranta.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2843473337431339678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jarkko Lehtoranta <devel@jlranta.com>

Hi,

Voice output serial port is enabled on some Huawei models (e.g. E169) witho=
ut
problems, but for example on E173u-2 it is never enabled during an incoming
call. There might also be other Huawei models having the same issue.

I traced the issue down to "^DDSETEX" AT command, which is used to notify
the device to start streaming audio. It seems that Ofono sends this
command too early on incoming calls. The command should always be sent
*after* the dial "D" or answer "A" command. The patch fixes this behavior
and afterwards voice will also work on E173u-2.

Best regards,
Jarkko

Jarkko Lehtoranta (1):
  huawei: fix AT^DDSETEX=3D2 timing

 drivers/huaweimodem/voicecall.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- =

1.7.9.3


--===============2843473337431339678==--

