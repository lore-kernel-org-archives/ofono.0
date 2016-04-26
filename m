Content-Type: multipart/mixed; boundary="===============1203056550692906450=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2 0/2] [RFC] Clean up undefined function pointer casts
Date: Tue, 26 Apr 2016 06:19:38 +0000
Message-ID: <1461651574-31530-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1203056550692906450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

v2: Bump glib requirement to version 2.32 to gain access to g_queue_free_fu=
ll,
this saves using a wrapper function to clean up the queue in the stk.

John Ernberg (2):
  configure: Bump glib dependecy to 2.32
  stk: clean up undefined function pointer casts

 configure.ac | 4 ++--
 src/stk.c    | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- =

1.9.1

--===============1203056550692906450==--

