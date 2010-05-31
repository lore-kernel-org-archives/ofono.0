Content-Type: multipart/mixed; boundary="===============7889276920351259616=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/6] Add bluetooth plugin skeleton.
Date: Mon, 31 May 2010 08:51:21 -0700
Message-ID: <1275321081.2658.8.camel@localhost.localdomain>
In-Reply-To: <87pr0c2sel.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7889276920351259616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> >> +#ifndef __BLUETOOTH_H
> >> +#define __BLUETOOTH_H
> >
> > No ifdef guards please.
> =

> I'm curious, why not?

the ifdef guards are only needed for public exposed include files to
protect against circular inclusion.

For local headers I do want it fail if anybody attempts a circular
inclusion. If they are needed, then it is a good sign that something is
way too complex.

Regards

Marcel



--===============7889276920351259616==--

