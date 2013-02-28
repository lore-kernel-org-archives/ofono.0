Content-Type: multipart/mixed; boundary="===============3041236106457461185=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 0/6] hfp_hf_bluez5: Register Audio Cards in handsfree
 manager
Date: Thu, 28 Feb 2013 13:00:25 -0300
Message-ID: <1362067225-8567-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361997234-13804-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3041236106457461185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series contains the changes in the hfp_hf_bluez5 plugin to
create/register/remove audio cards.

Changes between v0-v1:
* Removed commit "Switch argument order when creating card"

Changes between v1-v2:
* Fixed coding style: 80 character limit

Changes between v2-v3:
* Fixed M5: Git commit message 50/72 formatting
* Fixed M1: Blank line before and after an if/while/do/for statement

Claudio Takahasi (6):
  hfp_hf_bluez5: Add registering Audio Card
  hfp_hf_bluez5: Add local address to Audio Card
  hfp_hf_bluez5: Remove Card when SLC fails
  hfp_hf_bluez5: Remove Card if SLC is disconnected
  hfp_hf_bluez5: Remove Card when modem is disabled
  hfp_hf_bluez5: Remove Card on RequestDisconnection

 plugins/hfp_hf_bluez5.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

-- =

1.7.11.7


--===============3041236106457461185==--

