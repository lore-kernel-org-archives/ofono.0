Content-Type: multipart/mixed; boundary="===============6931127426384810242=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 0/2] Fix rilmodem SMSC quoting
Date: Fri, 04 Dec 2015 16:16:56 -0500
Message-ID: <1449263818-14263-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6931127426384810242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This changeset fixes the string formatting of the
RIL_REQUEST_SET_SMSC_ADDRESS request, which requires
the string to bracketed by quotation marks.

Tony Espy (2):
  rilmodem: restore SET_SMSC_ADDRESS number format
  unit: update test-rilmodem-sms set_sca test case

 drivers/rilmodem/sms.c   | 4 +++-
 unit/test-rilmodem-sms.c | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

-- =

2.1.4


--===============6931127426384810242==--

