Content-Type: multipart/mixed; boundary="===============7190717505335835362=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/8] handsfree-audio: Audio Card registration
Date: Mon, 25 Feb 2013 11:34:13 -0300
Message-ID: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7190717505335835362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds the initial Handsfree Audio Card hierarchy
implementation.

Open issues:
* Define Audio Card object path: it is using modem path in this series

Not implemented in this series:
* SCO audio connection
* LocalAddress property

Claudio Takahasi (8):
  handsfree-audio: Add atom modem tracking
  handsfree-audio: Add Audio Card registration
  handsfree-audio: Add Audio Card GetProperties
  handsfree-audio: Add emitting CardAdded
  handsfree-audio: Add function to append properties
  handsfree-audio: Add emitting CardRemoved
  handsfree-audio: Add registered cards tracking
  handsfree-audio: Add GetCards

 src/handsfree-audio.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 194 insertions(+), 2 deletions(-)

-- =

1.7.11.7


--===============7190717505335835362==--

