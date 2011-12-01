Content-Type: multipart/mixed; boundary="===============1361133844708540731=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v1 0/2] Add SIM polling mechanism for Sierra
Date: Thu, 01 Dec 2011 17:48:51 +0100
Message-ID: <1322758133-19701-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1361133844708540731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v0:
	- Separate memory leak fix in another patch
	- Fix issue into polling mechanism

Kind regards,
Guillaume

Guillaume Zajac (2):
  sierra: Fix memory leak
  sierra: Add SIM state polling

 plugins/sierra.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)


--===============1361133844708540731==--

