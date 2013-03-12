Content-Type: multipart/mixed; boundary="===============6490001261963270578=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 00/15] Add handsfree audio card driver
Date: Tue, 12 Mar 2013 09:41:58 -0300
Message-ID: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6490001261963270578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds an abstraction to allow HFP 1.5 and HFP 1.6
to use the same infra-structure. It avoids adding the slc.h and
gatchat.h dependency to the core (src/handsfree-audio.c)

Remaining patches (HFP 1.6 and service level negotiation):
git://git.infradead.org/users/cktakahasi/ofono.git external-hfp16

Changes between RFC v0 and PATCH v0:
* Fixed register/unregister of the Card driver
* Changed handsfree-audio doc: added possible errors

Claudio Takahasi (15):
  handsfree-audio: Add card driver
  hfp_hf_bluez5: Register handsfree audio driver
  hfp_hf_bluez5: Add extracting version
  handsfree-audio: Add version to card driver
  hfp_hf_bluez5: Pass version to card registration
  hfp_hf_bluez5: Add version to HFP 1.5 card driver
  core: Add bt_str2ba() to bluetooth.h
  hfp_hf_bluez5: Add HFP 1.5 connect implementation
  handsfree-audio: Add calling connect callback
  handsfree-audio: Add connect GIOChannel watch
  handsfree-audio: Add sending SCO fd
  handsfree-audio: Return NotAvailable on "Connect"
  handsfree-audio: Return InProgress on Connect
  handsfree-audio: Check agent before sending fd
  doc: Add Handsfree Audio Card "Connect" errors

 doc/handsfree-audio-api.txt |   5 ++
 include/handsfree-audio.h   |  15 +++++-
 plugins/hfp_hf_bluez5.c     |  98 ++++++++++++++++++++++++++++++++++++++-
 src/bluetooth.h             |   8 ++++
 src/handsfree-audio.c       | 110 ++++++++++++++++++++++++++++++++++++++++=
+++-
 5 files changed, 232 insertions(+), 4 deletions(-)

-- =

1.7.11.7


--===============6490001261963270578==--

