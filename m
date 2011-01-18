Content-Type: multipart/mixed; boundary="===============0316979732364953983=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 0/5] Implement CPHS CSP support
Date: Tue, 18 Jan 2011 15:19:02 +0200
Message-ID: <1295356747-29758-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0316979732364953983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

This patch set implements support for the PLMN mode bit found in the
CPHS EFcsp file. Based on the PLMN mode setting, the netreg atom
enables or disables manual network registration.

There is a new Mode property value of 'forced-auto' for indicating the
case when manual selection is disabled. Any attempt to manually
Register() will also fail with an error.

In addition, we add a short description of the CPHS spec in
doc/standards.txt. Unfortunately that spec is not publically
available, although people may have luck finding an unofficial version
online with the help of a search engine. ;)

Aki Niemi (5):
  simutil: Add EFcsp file and service group IDs
  netreg: Add CPHS CSP PLMN mode implementation
  doc: Add documentation for 'forced-mode'
  doc: Add short mention of CPHS under standards
  TODO: Remove completed CPHS CSP task

 TODO                |   13 --------
 doc/network-api.txt |   24 ++++++++------
 doc/standards.txt   |    9 +++++
 src/network.c       |   85 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/simutil.h       |   16 +++++++++
 5 files changed, 123 insertions(+), 24 deletions(-)



--===============0316979732364953983==--

