Content-Type: multipart/mixed; boundary="===============7665664550305207004=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] Introduction of HACKING file in phonesim
Date: Tue, 01 Jun 2010 19:40:23 -0700
Message-ID: <1275446423.2182.9.camel@localhost.localdomain>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731E11FF73@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7665664550305207004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >+When using "./configure --enable-maintainer-mode" the automake scripts =
will
> >+use the plugins directly from within the repository. This removes the n=
eed
> >+to use "make install" when testing "phonesim". The "bootstrap-configure"
> >+automatically includes this option.
> >+
> >+  Run phonesim in foreground using the following options
> >+    # ./src/phonesim -p 12345 -gui xml/default.xml
> =

> The "xml" directory has been removed. So here should be "src/default.xml".

good catch. I fixed that up. Thanks.

Regards

Marcel



--===============7665664550305207004==--

