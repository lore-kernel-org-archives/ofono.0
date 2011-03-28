Content-Type: multipart/mixed; boundary="===============0516029985982604218=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] Introduce a new method to display abortable information 
Date: Mon, 28 Mar 2011 18:32:28 +0200
Message-ID: <1301329952-10152-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0516029985982604218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an alpha Id is provided by the UICC, the proactive commands such as
Send DTMF, Open Channel, Close Channel, Send Data, Receive Data require to
display this information but also to handle a possible user termination
(user decides to end the session). A new method is added for this purpose.

Philippe Nunes (4):
  stk-api.txt: Introduce a new API to display abortable information
  stk: Handle user termination for Send DTMF.
  stkagent: Call the new display method when user termination is
    allowed
  test-stk-menu: Extend to support the new method
    DisplayAbortableActionInfo

 doc/stk-api.txt    |   11 +++++++++
 src/stk.c          |   30 ++++++++++++++++++++-----
 src/stkagent.c     |   62 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h     |   10 ++++++++
 test/test-stk-menu |   10 ++++++++
 5 files changed, 117 insertions(+), 6 deletions(-)


--===============0516029985982604218==--

