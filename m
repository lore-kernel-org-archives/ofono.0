Content-Type: multipart/mixed; boundary="===============4618982765166862243=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 00/20] HFP1.6: Codec negotiation and HF Connect
Date: Tue, 12 Mar 2013 11:21:24 -0300
Message-ID: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4618982765166862243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This RFC implements codec negotiation and HF initiated audio
connection for HFP 1.6

Dependency: "[PATCH v0 00/15] Add handsfree audio card driver"

Open issues:
* Use bitmask or keep the array to store the supported audio codecs?
* Return -EINPROGRESS for Audio Connect. Is it acceptable?

Missing:
* Unregister the codec watcher
* Some errors handling

Development branch:
git://git.infradead.org/users/cktakahasi/ofono.git external-hfp16

Claudio Takahasi (18):
  handsfree-audio: Add card driver for HFP 1.6
  handsfree-audio: Add user data to card driver
  hfp_hf_bluez5: Pass modem as user data
  handsfree-audio: Add user data to connect declaration
  hfp_hf_bluez5: Add user data to connect implementation
  hfp_hf_bluez5: Add HFP 1.6 connect implementation
  handsfree-audio: Add HFP 1.6 connect hook
  handsfree-audio: Add "Connect" reply for HFP 1.6
  handsfree-audio: Add function to get the codecs
  hfp_hf_bluez5: Register codec watcher
  handsfree-audio: Add function to select the codec
  hfp_hf_bluez5: Set the audio codec in the card
  handsfree-audio: Send the selected codec
  handsfree-audio: Set CVSD as default in the card
  handsfree-audio: Use bitmask for supported codecs
  handsfree-audio: Disable mSBC if defer is off
  bluetooth: Add define for SCO voice settings
  handsfree-audio: Add setting SCO air mode

Vinicius Costa Gomes (2):
  hfpmodem: Send AT+BAC with the supported codecs
  hfpmodem: Add codec watcher register

 drivers/hfpmodem/slc.c    |  89 +++++++++++++++++++++++++++++++-
 drivers/hfpmodem/slc.h    |   4 ++
 include/handsfree-audio.h |   9 +++-
 plugins/hfp_hf_bluez5.c   |  56 +++++++++++++++++++-
 src/bluetooth.h           |  12 +++++
 src/handsfree-audio.c     | 127 +++++++++++++++++++++++++++++++++++++++---=
----
 6 files changed, 274 insertions(+), 23 deletions(-)

-- =

1.7.11.7


--===============4618982765166862243==--

