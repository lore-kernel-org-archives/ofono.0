Content-Type: multipart/mixed; boundary="===============3722650198691680765=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Thu, 07 Jan 2016 10:46:21 +0000
Message-ID: <1452163577-23146-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3722650198691680765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

The area where I could test this behavior has gotten better reception now s=
o I
cannot test this patch as thoroughly as I'd like but it seems to work.
Please be extra strict during the review to minimize the risk of something
being by this.

John Ernberg (1):
  network: Fix use-after-free caused by Scan() in poor reception.

 src/network.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- =

1.9.1

--===============3722650198691680765==--

