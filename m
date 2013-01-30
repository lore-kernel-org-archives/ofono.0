Content-Type: multipart/mixed; boundary="===============7655592177573963910=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 0/2] Reject SCO connection
Date: Wed, 30 Jan 2013 10:32:43 -0300
Message-ID: <1359552765-9851-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7655592177573963910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add service level connection hash table to track active connections
using the remote address as key, and the adapter address as value.
It is not supported the scenario that the host has multiple local adapters,
and the remote needs to establish more than one SLC to this host/oFono.

Rejects the incoming SCO connection if the address pair is not found in the
hash table.

Claudio Takahasi (2):
  hfp_hf_bluez5: Add SLC hash table
  hfp_hf_bluez5: Add rejecting SCO connection

 plugins/hfp_hf_bluez5.c | 75 ++++++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 61 insertions(+), 14 deletions(-)

-- =

1.7.11.7


--===============7655592177573963910==--

