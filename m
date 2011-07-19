Content-Type: multipart/mixed; boundary="===============1141204598870951623=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 0/2] Add support for modem handled setup call proactive command
Date: Tue, 19 Jul 2011 00:13:25 -0700
Message-ID: <1311059607-10695-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1141204598870951623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patch set fixes the review comments.

If the modem is able to setup the call, then the alpha id will be freed whe=
n the
initiated call ends.

If the modem is not able to setup the call due to some reason, then the mem=
ory
allocated for alpha id and dial request are freed when the command end/sess=
ion
end is received.

Thanks and Regards,
Jeevaka

Jeevaka Badrappan (2):
  voicecall: api for set/clear alpha and icon id
  stk: Handle set up call in handled_notify

 src/ofono.h     |    6 +++
 src/stk.c       |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 src/voicecall.c |   62 ++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 3 deletions(-)

-- =

1.7.4.1


--===============1141204598870951623==--

