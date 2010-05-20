Content-Type: multipart/mixed; boundary="===============5756078413373302190=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Need your help - Few queries on ofono
Date: Wed, 19 May 2010 23:19:41 -0500
Message-ID: <201005192319.41948.denkenz@gmail.com>
In-Reply-To: <20100520121105.GA18374@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5756078413373302190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

> > 1. I downloaded the ofono source code from the web, Tried compiling it,
> > and building it. 2. The code got successfully compiled and ofonod was
> > generated. But looks like no specific .so s got built for the
> > drivers/plugins.

In the future please post such questions to the oFono mailing list.  And to =

answer this specific topic:

All oFono drivers / plugins found in drivers/ and plugins/ are built as =

builtins.  This means that they're _statically_ linked and no .so files are =

generated.  However, oFono can load external .so plugins as well.

Regards,
-Denis

--===============5756078413373302190==--

