Content-Type: multipart/mixed; boundary="===============3368261133976900003=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: Re: [VPATH PATCH 2/2] Fix $(INCLUDE) in Makefile.am
Date: Wed, 31 Aug 2011 10:09:24 +0000
Message-ID: <1314785345.15078.13.camel@agni>
In-Reply-To: <1314729601.3373.248.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3368261133976900003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, =


On Tue, 2011-08-30 at 11:39 -0700, ext Marcel Holtmann wrote:
> what problem is this patch fixing?

The problem was that things like

#include <gisi/iter.h>

did not work with VPATH.

--Pekka



--===============3368261133976900003==--

