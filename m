Content-Type: multipart/mixed; boundary="===============4389628082915029688=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] If EF-MWIS is not available use the CPHS version.
Date: Tue, 12 Jan 2010 18:23:48 -0600
Message-ID: <201001121823.48282.denkenz@gmail.com>
In-Reply-To: <1262864361-32154-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4389628082915029688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I applied this patch, but really it was completely broken and I shouldn't =

have.  I ended up rewriting most of it since the  CPHS MWIS format is =

completely different from 3GPP.

Please test and make sure my changes are correct.

Regards,
-Denis

--===============4389628082915029688==--

