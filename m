Content-Type: multipart/mixed; boundary="===============5952287904110533455=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 0/2] Add null text/alpha identifier and icon specific handling
Date: Wed, 29 Dec 2010 15:16:38 +0200
Message-ID: <1293628600-8684-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5952287904110533455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Following patch adds the missing "text/alpha identifier and icon" one
particular case handling.

As per the ETSI TS 102 223 section 6.5.4, "If the terminal receives an
icon, and either an empty or no alpha identifier/text string is given
by the UICC, than the terminal shall reject the command with general"
result "Command data not understood by terminal"."

As per the ETSI 102 223 section 6.8, Text string is only required in
response to a GetInkey or GetInput proactive command. So, there is no
need to add any specific handling for null or empty strings cases.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  stkutil: Allocate for empty string in text dataobj
  stk: add missing text and icon case handling

 src/stk.c     |  114 +++++++++++++++++++++++++++++++++++++++--------------=
---
 src/stkutil.c |    2 +-
 2 files changed, 80 insertions(+), 36 deletions(-)


--===============5952287904110533455==--

