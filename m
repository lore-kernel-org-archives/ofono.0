Content-Type: multipart/mixed; boundary="===============5181798785397652665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Read own numbers from EFmsisdn instead of AT+CNUM.
Date: Thu, 18 Jun 2009 03:32:46 -0500
Message-ID: <200906180332.46998.denkenz@gmail.com>
In-Reply-To: <1245296696-15259-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5181798785397652665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wednesday 17 June 2009 22:44:56 Andrzej Zaborowski wrote:
> This was found to be more portable.  On the other hand this doesn't give
> the service type or speed information per number.
>

Patch has been applied.  The service type and speed information is mostly =

fudged by the modems anyway.  This can still be obtained by parsing the EFc=
cp2 =

record if one is provided in the EFmsisdn.

Regards,
-Denis

--===============5181798785397652665==--

