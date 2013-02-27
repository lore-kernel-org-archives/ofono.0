Content-Type: multipart/mixed; boundary="===============2855750781068351634=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 0/6] hfp_hf_bluez5: Register Audio Cards in handsfree
 manager
Date: Wed, 27 Feb 2013 17:33:48 -0300
Message-ID: <1361997234-13804-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361987924-497-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2855750781068351634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series contains the changes in the hfp_hf_bluez5 plugin to
create/register/remove audio cards.

Changes from v0-v1:
* Removed commit "Switch argument order when creating card"

Claudio Takahasi (6):
  hfp_hf_bluez5: Add registering Audio Card
  hfp_hf_bluez5: Add local Bluetooth address to Audio Card
  hfp_hf_bluez5: Remove Audio Card when SLC fails
  hfp_hf_bluez5: Remove Audio Card when SLC is disconnected
  hfp_hf_bluez5: Remove Audio Card when modem is disabled
  hfp_hf_bluez5: Remove Audio Card when disconnection is requested

 plugins/hfp_hf_bluez5.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- =

1.7.11.7


--===============2855750781068351634==--

