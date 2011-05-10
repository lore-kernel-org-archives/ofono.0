Content-Type: multipart/mixed; boundary="===============7312426256347650920=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v5 0/3] Escape sequence test implementation
Date: Tue, 10 May 2011 10:34:13 +0200
Message-ID: <1305016456-24542-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7312426256347650920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changelog from v4:
	- contain only the gsmdial tool to test escape sequence
	- add GSource track of guard_timeouts to send "+++" to
	  remove it properly in case of problem

All associated resume functions for g_at_hdlc_... and g_at_ppp_...
will be sent with ATO0 callback implementation patches.

Guillaume Zajac (3):
  gatppp: add public suspend function
  gsmdial: add new option to test escape sequence
  gsmdial: add ATH0 command test

 gatchat/gatppp.c  |   43 +++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatppp.h  |    1 +
 gatchat/gsmdial.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)


--===============7312426256347650920==--

