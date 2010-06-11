Content-Type: multipart/mixed; boundary="===============4372035274163982186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Fri, 11 Jun 2010 14:31:39 -0500
Message-ID: <201006111431.40078.denkenz@gmail.com>
In-Reply-To: <AANLkTimppyAsTK346PXxtdlRG0JF2DwvU-yMuKPLXxti@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4372035274163982186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi,
> =

> On 10 June 2010 03:06, Denis Kenzior <denkenz@gmail.com> wrote:
> > Hi Andrew,
> >
> >>               /* Network Byte Order */
> >> -             unsigned int ipv4;
> >> +             guint32 ipv4;
> >
> > Why?
> =

> int has no guranteed size except at the ABI level.  So the SysV r4
> ABIs for x86, ARM and amd64 make it 32-bit but you don't know what
> happens elsewhere.  I'll remove this change as it's unlikely int will
> be < 32-bit and if it's wider we don't care.  (I, too, prefer stdint
> types like uint32_t).

Lets go with uint32_t, I think everyone agrees it the better approach.

Regards,
-Denis

--===============4372035274163982186==--

