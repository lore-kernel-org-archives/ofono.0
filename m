Content-Type: multipart/mixed; boundary="===============3092848249213346612=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 00/13] Add handsfree audio card driver
Date: Fri, 08 Mar 2013 20:11:12 -0300
Message-ID: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3092848249213346612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds an abstraction to allow HFP 1.5 and HFP 1.6
to use the same infra-structure. It avoids adding the slc.h and
gatchat.h dependency to the core (src/handsfree-audio.c)

Remaining patches (HFP 1.6 and service level negotiation):
git://git.infradead.org/users/cktakahasi/ofono.git external-hfp16

Claudio Takahasi (13):
  handsfree-audio: Add card driver
  hfp_hf_bluez5: Register handsfree audio driver
  hfp_hf_bluez5: Add extracting version
  handsfree-audio: Add version to card driver
  hfp_hf_bluez5: Pass version to card registration
  hfp_hf_bluez5: Add version to HFP 1.5 card driver
  core: Add bt_str2ba() to bluetooth.h
  hfp_hf_bluez5: Add HFP 1.5 card connect callback
  handsfree-audio: Add calling connect callback
  handsfree-audio: Add connect GIOChannel watch
  handsfree-audio: Add sending SCO fd
  handsfree-audio: Return an error on Card Connect
  handsfree-audio: Check agent before sending fd

 include/handsfree-audio.h |  15 ++++++-
 plugins/hfp_hf_bluez5.c   |  98 +++++++++++++++++++++++++++++++++++++++++-
 src/bluetooth.h           |   8 ++++
 src/handsfree-audio.c     | 107 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 4 files changed, 224 insertions(+), 4 deletions(-)

-- =

1.7.11.7


--===============3092848249213346612==--

