Content-Type: multipart/mixed; boundary="===============7902231762242306460=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/3] Add null text/alpha identifier and icon check handling
Date: Tue, 04 Jan 2011 14:42:00 -0800
Message-ID: <1294180923-12241-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7902231762242306460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Following patch adds the missing "text/alpha identifier and icon"
check handling.

As per the ETSI 102 223 section 6.8, Text string is only required in
response to a GetInkey or GetInput proactive command. So, there is no
need to add any specific handling for null or empty strings cases.

As per the ETSI TS 102 223 section 6.5.4, "If the terminal receives an
icon, and either an empty or no alpha identifier/text string is given
by the UICC, than the terminal shall reject the command with general"
result "Command data not understood by terminal"."

Regards,
Jeevaka

Jeevaka Badrappan (3):
  stkutil: Allocate for empty string in text dataobj
  stkutil: add missing text and icon check
  unit: add error status support for failure cases

 src/stkutil.c       |  122 ++++++++++++++++++++++++++++++++++++++++++++---=
----
 unit/test-stkutil.c |   12 +++--
 2 files changed, 114 insertions(+), 20 deletions(-)


--===============7902231762242306460==--

