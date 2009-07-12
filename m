Content-Type: multipart/mixed; boundary="===============3471264173644817315=="
MIME-Version: 1.0
From: Jeremiah Foster <jeremiah@jeremiahfoster.com>
Subject: Re: The very first oFono release
Date: Mon, 13 Jul 2009 00:15:44 +0200
Message-ID: <31BD9C0F-EDFD-4339-899C-4E712463CD07@jeremiahfoster.com>
In-Reply-To: <1247252160.9709.89.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3471264173644817315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Jul 10, 2009, at 20:56, Marcel Holtmann wrote:
>
> I also think it is a good time for package maintainers to look into
> making oFono available in their distributions. And give feedback on
> things that don't integrate well.

The first sticking point, at least from a debian perspective, is this  =

line in the README file;
Copyright (C) 2008-2009  Intel Corporation. All rights reserved.

This does not fit with debian's free software guidelines[0].  =

Specifically point 7;

"The rights attached to the program must apply to all to whom the  =

program is redistributed without the need for execution of an  =

additional license by those parties."

Until that line in the README file is changed, ofono cannot be  =

packaged for debian and placed into debian's free software repositories.

Regards,

Jeremiah

0. http://www.debian.org/social_contract



--===============3471264173644817315==--

