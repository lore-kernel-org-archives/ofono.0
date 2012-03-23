Content-Type: multipart/mixed; boundary="===============9031454032280512944=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 0/6] mmsd: bug fixing in send message recovery
Date: Fri, 23 Mar 2012 17:45:35 +0100
Message-ID: <1332521141-31865-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9031454032280512944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series concerns mmsd for ofono mailing list.

Patch 1 to 3 fix some leaks when a problem arises when a send request is
created.
Patch 4 to 6 fix some mistakes in send message recovery.

S=C3=A9bastien Bianti (6):
  service: remove dead file
  service: fixed possible meta with NULL uuid
  service: remove pdu without meta
  service: request_post_file opens the pdu itself
  service: fix some leaks
  service: request needs to keep msg

 src/service.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

-- =

1.7.4.4


--===============9031454032280512944==--

