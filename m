Content-Type: multipart/mixed; boundary="===============6714089522383045599=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 16:30:05 -0600
Message-ID: <4D50726D.9090102@gmail.com>
In-Reply-To: <AANLkTin7-jU3z7nhLmfHBsVeBTZkRjQb5-zzKAc4uX0m@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6714089522383045599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

>     when submitting patches please follow our coding style guidelines.  Y=
ou
>     had at least 1 style violation, namely rule M4.
> =

> =

> That is strange i run checkpatch  on the code i did not get any warning.
> Is there a  better script for the checking the patches before sending?

We follow Linux kernel coding style + a few extra rules.  These are not
covered by checkpatch.  See doc/coding-style.txt for a fairly
comprehensive list of them.

Nobody has yet volunteered to maintain a checkpatch style script for
oFono specifically, so today we rely on the review process to find most
of these violations.  Much of the codebase is consistent with these
rules, but you will find some inconsistencies in the code that was
written before some of these rules went into effect.  If you do, then
feel free to send a patch ;)

If in doubt check doc/coding-style.txt or the rest of the code.

Regards,
-Denis

--===============6714089522383045599==--

