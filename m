Content-Type: multipart/mixed; boundary="===============4099187943124384857=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/2] GPRS patches
Date: Thu, 24 Mar 2011 14:32:22 +0200
Message-ID: <1300969944-20659-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4099187943124384857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here's a memory leak fix and a new test script for GPRS.

Br,

	MikaL

[PATCH 1/2] gprs: fix memory leak
[PATCH 2/2] test: add a script to set any GPRS context property

 Makefile.am               |    3 ++-
 src/gprs.c                |    2 ++
 test/set-context-property |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletions(-)

--===============4099187943124384857==--

