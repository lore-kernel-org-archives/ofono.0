Content-Type: multipart/mixed; boundary="===============0718317290312507631=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: The very first oFono release
Date: Mon, 13 Jul 2009 09:05:35 +0200
Message-ID: <ae4639cfbfef6b6dd524174f0db71552@chewa.net>
In-Reply-To: <4a2e0412bb7c4c0fd69cc769728d2dd7@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0718317290312507631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




On Mon, 13 Jul 2009 09:04:01 +0200, R=C3=A9mi Denis-Courmont <remi@remlab=
.net>
wrote:
> =

> =

> =

> On Mon, 13 Jul 2009 00:15:44 +0200, Jeremiah Foster
> <jeremiah@jeremiahfoster.com> wrote:
>> =

>> On Jul 10, 2009, at 20:56, Marcel Holtmann wrote:
>>>
>>> I also think it is a good time for package maintainers to look into
>>> making oFono available in their distributions. And give feedback on
>>> things that don't integrate well.
>> =

>> The first sticking point, at least from a debian perspective, is this
>> line in the README file;
>> Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
> =

> 10:03 redenisc(a)leon /usr/src/linux-2.6% grep "All rights reserved" */*.c
> crypto/aes_generic.c: * All rights reserved.
> crypto/fcrypt.c: * All rights reserved.
> crypto/gf128mul.c: Copyright (c) 2003, Dr Brian Gladman, Worcester, UK.  =

> All rights reserved.
> fs/compat_binfmt_elf.c: * Copyright (C) 2007 Red Hat, Inc.  All rights
> reserved.
> lib/crc-t10dif.c: * Copyright (c) 2007 Oracle Corporation.  All rights
> reserved.
> lib/kobject_uevent.c: * Copyright (C) 2004 Red Hat, Inc.  All rights
> reserved.
> lib/kobject_uevent.c: * Copyright (C) 2004 Novell, Inc.  All rights
> reserved.
> lib/kobject_uevent.c: * Copyright (C) 2004 IBM, Inc. All rights reserved.
> scripts/unifdef.c: * Copyright (c) 2002 - 2005 Tony Finch <dot@dotat.at=
>.

> All rights reserved.
> scripts/unifdef.c: *    The Regents of the University of California.  All
> rights reserved.
> scripts/unifdef.c:      The Regents of the University of California.  All
> rights reserved.\n";

A more exhaustive search yields 1374 matches, only in .c files. This is
2.6.31-rc1...

-- =

R=C3=A9mi Denis-Courmont


--===============0718317290312507631==--

