Content-Type: multipart/mixed; boundary="===============2398095700434385172=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] Fix issue with AT parser in gatserver
Date: Thu, 07 Jul 2011 16:19:28 +0200
Message-ID: <1310048369-31394-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2398095700434385172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fix an issue with AT parser in gatserver.

If an empty command is issued after AT, then 2 answers are sent. The parser=
 can
also get in a bad state where next commands will not be handled. After that=
 the
parser will get back on his feets. This is caused by reentrency: =

new_bytes() calls g_at_server_send_final(), which in turns calls server_res=
ume
which calls new_bytes() again synchronously.

Sample dialog follows:

ofonod[30720]: Server: < AT+CMER=3D3,0,0,1\r\n
ofonod[30720]: Server: > \r\nOK\r\n
ofonod[30720]: Server: < AT+CFUN\r\n
ofonod[30720]: Server: > \r\nERROR\r\n
ofonod[30720]: Server: < AT\r\n
ofonod[30720]: Server: > \r\nOK\r\n
ofonod[30720]: Server: < \r\n
ofonod[30720]: Server: > \r\nOK\r\n\r\nOK\r\n
<2 answers sent>
ofonod[30720]: Server: < AT+CFUN\r\n
ofonod[30720]: Server: > \r\nERROR\r\n
ofonod[30720]: Server: < \r\n
ofonod[30720]: Server: > \r\nOK\r\n
ofonod[30720]: Server: < AT+CFUN\r\n
<missing ERROR reply to CFUN>
ofonod[30720]: Server: < \r\n
ofonod[30720]: Server: > \r\nOK\r\n


Fr=C3=A9d=C3=A9ric Dalleau (1):
  gatchat: Fix reentrency issue with empty commands

 gatchat/gatserver.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


--===============2398095700434385172==--

