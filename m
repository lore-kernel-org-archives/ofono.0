Content-Type: multipart/mixed; boundary="===============5660712065051045937=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/7] hfp_hf_bluez5: Register Audio Cards in handsfree
 manager
Date: Wed, 27 Feb 2013 14:58:37 -0300
Message-ID: <1361987924-497-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5660712065051045937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series contains the changes in the hfp_hf_bluez5 plugin to
create/register/remove audio cards.

Claudio Takahasi (7):
  handsfree-audio: Switch argument order when creating card
  hfp_hf_bluez5: Add registering Audio Card
  hfp_hf_bluez5: Add local Bluetooth address to Audio Card
  hfp_hf_bluez5: Remove Audio Card when SLC fails
  hfp_hf_bluez5: Remove Audio Card when SLC is disconnected
  hfp_hf_bluez5: Remove Audio Card when modem is disabled
  hfp_hf_bluez5: Remove Audio Card when disconnection is requested

 include/handsfree-audio.h |  4 ++--
 plugins/hfp_hf_bluez5.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/handsfree-audio.c     |  4 ++--
 3 files changed, 46 insertions(+), 4 deletions(-)

-- =

1.7.11.7


--===============5660712065051045937==--

