Content-Type: multipart/mixed; boundary="===============2839241635260492946=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/3] Add radio access atom and driver API
Date: Wed, 03 Feb 2010 11:30:57 +0200
Message-ID: <1265189457.2557.147.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <201002022202.31945.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2839241635260492946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ke, 2010-02-03 kello 05:02 +0100, ext Denis Kenzior kirjoitti:
> People on this list keep forgetting two things:
> 1. We're not designing a kitchen sink API here.  Most of the 'radio relat=
ed =

> settings' will simply never be exposed, nobody really cares what UMTS cha=
nnel =

> he/she is currently on.

There's the link status I mentioned earlier that needs to be exposed. I
now regret not writing it there in the first place. ;)

> 2. We're designing the API to be easy to use for everyone, not just GSM g=
eeks.

Currently, we're not doing a very good job at it, though:

From 366e4dac44734e20ad44194d8c0ab808eac082d4 Mon Sep 17 00:00:00 2001
From: Aki Niemi <aki.niemi@nokia.com>
Date: Wed, 3 Feb 2010 11:25:36 +0200
Subject: [PATCH] Technology names to use layman's terms

---
 src/common.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/common.c b/src/common.c
index db3e38b..a445616 100644
--- a/src/common.c
+++ b/src/common.c
@@ -622,21 +622,18 @@ const char *registration_tech_to_string(int tech)
 {
 	switch (tech) {
 	case ACCESS_TECHNOLOGY_GSM:
-		return "GSM";
 	case ACCESS_TECHNOLOGY_GSM_COMPACT:
-		return "GSMCompact";
+		return "2G";
 	case ACCESS_TECHNOLOGY_UTRAN:
-		return "UTRAN";
+		return "3G";
 	case ACCESS_TECHNOLOGY_GSM_EGPRS:
-		return "GSM+EGPRS";
+		return "2.5G";
 	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
-		return "UTRAN+HSDPA";
 	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
-		return "UTRAN+HSUPA";
 	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
-		return "UTRAN+HSDPA+HSUPA";
+		return "3.5G";
 	case ACCESS_TECHNOLOGY_EUTRAN:
-		return "EUTRAN";
+		return "4G";
 	default:
 		return "";
 	}
-- =

1.6.3.3

Cheers,
Aki


--===============2839241635260492946==--

