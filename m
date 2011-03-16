Content-Type: multipart/mixed; boundary="===============1633124232525306284=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Fixes issue with Get Inkey variable timeout
Date: Wed, 16 Mar 2011 10:57:29 -0700
Message-ID: <1300298250-2205-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1633124232525306284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 As per the ETSI TS 102 384 specification 27.22.4.2.8 section, duration
data object needs to be sent as part of the Get Inkey terminal response
for "No response from user" result.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  stk: fix issue with Get Inkey variable timeout

 src/stk.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)


--===============1633124232525306284==--

