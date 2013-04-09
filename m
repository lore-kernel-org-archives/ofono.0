Content-Type: multipart/mixed; boundary="===============2588762637527833656=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/8] HFP 1.6 codec selection
Date: Tue, 09 Apr 2013 17:45:35 -0300
Message-ID: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2588762637527833656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series adds support for selecting the codec inside the card.

We still don't set the SCO socket options because the API for that is
still being discussed. The patches for that are ready, they can be
sent as a RFC if desired.

The main question with this series is how to notify the audio card
that its selected codec has changed (PATCH 1/8). It was chosen to do
it this way to avoid adding knowledge of ofono_handsfree_card to the
hfpmodem.


Cheers,


Claudio Takahasi (5):
  hfp_hf_bluez5: Register codec watcher
  hfp_hf_bluez5: Set the audio codec in the card
  handsfree-audio: Send the selected codec
  handsfree-audio: Set CVSD as default in the card
  handsfree-audio: Enable wideband speech if defer is enabled

Vinicius Costa Gomes (3):
  hfpmodem: Add codec watcher register
  include: ofono_handsfree_card_select_codec()
  handsfree-audio: Implement ofono_handsfree_card_select_codec()

 drivers/hfpmodem/slc.c    | 62 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/hfpmodem/slc.h    |  4 +++
 include/handsfree-audio.h |  2 ++
 plugins/hfp_hf_bluez5.c   | 15 ++++++++++++
 src/handsfree-audio.c     | 31 +++++++++++++++++++-----
 5 files changed, 108 insertions(+), 6 deletions(-)

-- =

1.8.2


--===============2588762637527833656==--

