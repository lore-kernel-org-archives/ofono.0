Content-Type: multipart/mixed; boundary="===============2315499537919934643=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH v4 0/2] Add support for modem handled setup call proactive
 command
Date: Mon, 25 Jul 2011 11:15:25 -0700
Message-ID: <1311617727-10294-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2315499537919934643==
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

Also, noticed there is a break missing in the ofono_stk_proactive_command_h=
andled_notify
for STK_COMMAND_TYPE_SEND_SS case. Fix for that will be provided as a separ=
ate patch.

Note: This version of the patch is not tested.

Thanks and Regards,
Jeevaka

Jeevaka Badrappan (2):
  voicecall: api for set/clear alpha and icon id
  stk: Handle set up call in handled_notify

 src/ofono.h     |    6 ++
 src/stk.c       |  166 ++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 src/voicecall.c |   65 +++++++++++++++++++++
 3 files changed, 211 insertions(+), 26 deletions(-)

-- =

1.7.4.1


--===============2315499537919934643==--

