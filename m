Content-Type: multipart/mixed; boundary="===============4085762449710837973=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] hdlc fixes 
Date: Fri, 16 Apr 2010 19:31:01 -0700
Message-ID: <1271471463-7956-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4085762449710837973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Kristen Carlson Accardi (2):
  hdlc: allow for scanning and escaping
  hdlc: handle wrapped buffers

 gatchat/gathdlc.c |  121 ++++++++++++++++++++++++++++++++++++++-----------=
---
 gatchat/gathdlc.h |   12 +++++
 2 files changed, 100 insertions(+), 33 deletions(-)


--===============4085762449710837973==--

