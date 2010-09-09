Content-Type: multipart/mixed; boundary="===============5051365711230810384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] sim: read EFiidf
Date: Thu, 09 Sep 2010 09:10:16 -0500
Message-ID: <4C88EAC8.5050007@gmail.com>
In-Reply-To: <1282925966-14419-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5051365711230810384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 08/27/2010 11:19 AM, Kristen Carlson Accardi wrote:
> EFiidf can be larger than 256 bytes, so allow callers to read
> portions of the EFiidf from a specified offset.  Cache EFiidf
> files as blocks of 256 bytes so that it's not necessary to
> read the entire (potentially large) file.

This patch has been applied.  I refactored sim file system writing into
a separate source file afterwards.  It was getting a bit too large to be
contained inside sim.c

Regards,
-Denis

--===============5051365711230810384==--

