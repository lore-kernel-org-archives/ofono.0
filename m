Content-Type: multipart/mixed; boundary="===============1333956345669048298=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/4] Reject SCO connection
Date: Tue, 29 Jan 2013 17:38:36 -0300
Message-ID: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1333956345669048298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remaining patches of "External HFP: Add SCO" patch series.
* Patches left of the last series:
hfp_hf_bluez5: Add rejecting SCO connection
hfp_hf_bluez5: Fix missing fd close

* Major changes:
- splits patch "hfp_hf_bluez5: Add rejecting SCO connection"
- Replaces bdaddr_t by string. Adapter address is now being
  stored as modem string

Claudio Takahasi (2):
  hfp_hf_bluez5: Add rejecting SCO connection
  hfp_hf_bluez5: Fix missing fd close

Vinicius Costa Gomes (2):
  hfp_hf_bluez5: Rename 'Address' modem property to 'Remote'
  hfp_hf_bluez5: Set the 'Remote' and 'Local' properties

 plugins/hfp_hf_bluez5.c | 111 ++++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 88 insertions(+), 23 deletions(-)

-- =

1.7.11.7


--===============1333956345669048298==--

