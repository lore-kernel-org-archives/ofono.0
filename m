Content-Type: multipart/mixed; boundary="===============4767598816206082545=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] Bearer documentation
Date: Wed, 12 Jan 2011 08:40:45 -0800
Message-ID: <1294850445.3873.96.camel@aeonflux>
In-Reply-To: <1294732414.5651.1131.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4767598816206082545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > As Denis said, the vendor commands indicate that it is a global bearer
> > information. If one context is on HSPA, then others will be as well. So
> > how does ISI provide this information? Is it globally or per context?
> =

> I doubt contexts can even be on different bearers. At least on ISI, the
> indication for HS*PA channel allocations is global, and so is cell
> supported technologies.

that is what I thought. It is just a stupidity in the AT command
specification that they give a CID with it.

Regards

Marcel



--===============4767598816206082545==--

