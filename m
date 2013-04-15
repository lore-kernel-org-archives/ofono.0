Content-Type: multipart/mixed; boundary="===============1622705692328204255=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 0/2] Setting the SCO air mode
Date: Mon, 15 Apr 2013 16:03:49 -0300
Message-ID: <1366052631-19705-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1622705692328204255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Sending this as an RFC as this depends on an socket API that is still
being discussed[1]. If the current proposed API (SCO_SETTINGS) is
approved, this series can be promoted to 'PATCH'.

If we want to send mSBC data over SCO, we need to enable the
transparent mode in the SCO link, the only way to inform that to the
kernel is using the SCO_SETTINGS (or similar) socket option.


Cheers,


[1] http://thread.gmane.org/gmane.linux.bluez.kernel/34902

Claudio Takahasi (2):
  bluetooth: Add define for SCO voice settings
  handsfree-audio: Add setting SCO air mode

 src/bluetooth.h       | 11 +++++++++++
 src/handsfree-audio.c | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- =

1.8.2.1


--===============1622705692328204255==--

