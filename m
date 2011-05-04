Content-Type: multipart/mixed; boundary="===============5916223752266956598=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 0/8] Escape sequence test implementation
Date: Wed, 04 May 2011 17:38:58 +0200
Message-ID: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5916223752266956598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

After set of patches has been applied, you can test it in launching:

sudo src/ofonod -nd '*' (with phonesim enabled and online)

sudo gsmdial -i xxx.xxx.xxx.xxx -p xxxx -b -e

This will establish a PPP connection and terminate it using "+++"
escape sequence and ATH0 command.

Change log from v3:
	- remove "+++" detection mechanism, use Denis implementation
	- "+++" is sent from GAtPPP not anymore from at_chat
	- suspend function is set in PPP server and PPP client
	  to resume at_chat
	- dun_ato_cb will be committed in separated set of patches

Guillaume Zajac (8):
  gathdlc: delete read/write handler in hdlc_suspend and add public
    suspend function for testing
  ppp_net: add ppp_net_suspend_interface() function
  gatppp: add function to set ppp_suspend() and proxy function to call
    ppp_net_suspend_interface()
  gatppp: add public suspend function for testing
  emulator: add suspend_ppp() definition and and register it into
    GAtPPP
  gsmdial: add new option to test escape sequence
  emulator: add dun_ath_cb() and register it
  gsmdial: add ATH0 command test

 gatchat/gathdlc.c |   12 +++++++++
 gatchat/gathdlc.h |    2 +
 gatchat/gatppp.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatppp.h  |    3 ++
 gatchat/gsmdial.c |   39 ++++++++++++++++++++++++++++++
 gatchat/ppp.h     |    1 +
 gatchat/ppp_net.c |    9 +++++++
 src/emulator.c    |   69 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 8 files changed, 192 insertions(+), 2 deletions(-)


--===============5916223752266956598==--

