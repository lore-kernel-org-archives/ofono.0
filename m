Content-Type: multipart/mixed; boundary="===============1022214675844604741=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] ACFC and PFC options implementation
Date: Thu, 16 Jun 2011 13:55:19 +0200
Message-ID: <1308225321-21611-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1022214675844604741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Those 2 patches, are implementing:
	- Address and Control Field Compression option
	- Protocol Field Compression option

It has been tested with gsmdial that do not negotiate any options and Win7
that negotiate both option.
An improvement of gsmdial and some ppp_lcp APIs could be done to test optio=
ns
separately e.g. only PFC negotiated and only ACFC negotiated

Guillaume Zajac (2):
  GAtPPP: Add ACFC option support
  GAtPPP: Add PFC option support

 gatchat/gatppp.c  |  169 ++++++++++++++++++++++++++++++++++++++++++++++---=
----
 gatchat/ppp.h     |   10 +++
 gatchat/ppp_lcp.c |   49 ++++++++++++++-
 3 files changed, 203 insertions(+), 25 deletions(-)


--===============1022214675844604741==--

