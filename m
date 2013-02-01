Content-Type: multipart/mixed; boundary="===============1791272367448104522=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 0/3] Reject SCO connection
Date: Fri, 01 Feb 2013 14:51:35 -0300
Message-ID: <1359741098-27338-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359552765-9851-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1791272367448104522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Another proposal implemeting SCO connection reject. As discussed via IRC,
this approach uses a list to track the modems with active service level
connections.

This approach assumes that the remote Bluetooth device will not support
multiple active connections with multiple Bluetooth adapters available
in the same host. Extend this approach to check for the local adapter addre=
ss
can be added later easily.


Claudio Takahasi (3):
  hfp_hf_bluez5: Add active SLC connections list
  hfp_hf_bluez5: Add rejecting SCO connection
  hfp_hf_bluez5: Add SCO channel tracking

 plugins/hfp_hf_bluez5.c | 57 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 56 insertions(+), 1 deletion(-)

-- =

1.7.11.7


--===============1791272367448104522==--

