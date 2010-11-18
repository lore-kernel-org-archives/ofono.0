Content-Type: multipart/mixed; boundary="===============3406390425759059647=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 0/2] Provide Local Information
Date: Thu, 18 Nov 2010 18:55:54 +0800
Message-ID: <1290077756-28124-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3406390425759059647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently only the access technology in proactive command "Provide Local In=
formation" is handled. In order not to bloat the patch, I plan to send the =
left parts in separate patches. Would you please review this part first?
I have some concerns/questions on this command:
1. The definition of access technology got from network is different from t=
he definition in stk, so I did some map here. Please comment if I made some=
thing wrong.
2. How about if oFono couldn't provide some information. For example, if oF=
ono couldn't provide the time info, need we ask the application to provide =
one? Thus we'd need to introduce an agent.

Yang Gu (2):
  stk: provide access technology info
  network: Use bit as size instead of byte

 src/network.c |   18 +++++-
 src/ofono.h   |    1 +
 src/stk.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 196 insertions(+), 2 deletions(-)

-- =

1.7.2.3


--===============3406390425759059647==--

