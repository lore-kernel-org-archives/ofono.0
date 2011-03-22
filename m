Content-Type: multipart/mixed; boundary="===============8704556792952736351=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] gprs.c: add list contexts for emulator
Date: Tue, 22 Mar 2011 10:08:59 -0500
Message-ID: <4D88BB8B.5030101@gmail.com>
In-Reply-To: <4D887EA3.9060000@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8704556792952736351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

Gentle reminder not to top-post on this mailing list.

On 03/22/2011 05:49 AM, Olivier Guiter wrote:
> Thanks Denis for your feedback.
> The idea behind this code is to propose the complete support of the
> usual AT+CGDCONT in the emulator. I think the best solution might be to
> stick on contexts exposed over DBus, but this could lead to problems
> like : a context is delete throught the DBus interface... how to handle
> this change in the AT emulator, and avoid the use of the deleted context ?

Personally I'm not convinced CGDCONT management is even a good idea.
The typical usecase is for DUN clients to send a CGDCONT string, but
this can simply be accepted and ignored (for instance).

Just overwriting oFono's context store is not a good idea anyway as you
lose certain valuable information.  For instance whether this context is
used for internet (and ConnMan should pay attention to it) or it is used
for mms, etc.

It is also possible for the dial up client to provide context details
that are identical to a context already defined in oFono.  In which case
those details should be used instead (for the reasons outlined in the
previous paragraph)

Regards,
-Denis

--===============8704556792952736351==--

