Content-Type: multipart/mixed; boundary="===============4794228785313510558=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 00/11] Add BIP commands support
Date: Mon, 04 Jul 2011 18:06:31 +0200
Message-ID: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4794228785313510558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 - Remove the list of private context as we don't expect to activate multip=
le contexts from STK  or to activate a context outside of STK.
 - Replace the context id argument in the GPRS private APIs by the GPRS ato=
m data. This way, the global variable used to store the STK private context=
 is checked against the solicited GPRS atom.
 It prevents concurrent access if we have multiple STK enabled modems in th=
e system.
 - Introduce an anonymous structure in ofono_stk structure to group all the=
 BIP parameters
 - Release the STK context when the associated GPRS context is unregistered=
 or when the STK context is deactivated after a network forced detach.  =


Philippe Nunes (11):
  gprs: Add private APIs to activate/deactivate a private context for
    STK
  stk: Add support for the proactive command 'Open channel'
  stk: Add support for the proactive command 'Get channel status'
  stk: Add support for the proactive command 'Close channel'
  stk: Add 'ofono_stk_activate_cb' definition
  stk: Add 'ofono_stk_deactivate_context_cb' definition
  stk: Add support for the proactive command 'Receive data'
  stk: Add support for the proactive command 'Send data'
  stk: Add support of the Setup event list proactive command
  stk: Add host route to route the traffic through the stk interface
  gprs: Add API to set a 'detach'notification callback

 src/gprs.c  |  256 +++++++++++++++++
 src/ofono.h |   23 ++
 src/stk.c   |  920 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 1199 insertions(+), 0 deletions(-)


--===============4794228785313510558==--

