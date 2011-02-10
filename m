Content-Type: multipart/mixed; boundary="===============4636892574154306326=="
MIME-Version: 1.0
From: Kjetil ASDAL <kjetil.asdal@stericsson.com>
Subject: RE: [RFCv2] doc: Proposal for LTE/IMS API
Date: Thu, 10 Feb 2011 10:30:08 +0100
Message-ID: <24601CEAED63B94588D46990641D59241B7B5CE964@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <201102081647.26748.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4636892574154306326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

R=C3=A9mi wrote:
> > +			The registered application is tracked, if the
> > +			application exits the registration will be
> > +			automatically released.
> > +
> > +			Related AT command: AT+EISR.
> =

> Is this a standard command? As it is not in the 3GPP namespace
> (AT+C...), it
> might be nice to provide a reference pointer.

We should remove the reference above as it is incorrect. There is =

no standard AT command specified for this as of today, however, we =

will be entering a CR on 3GPP TS 27.007 in the upcoming meeting to =

address the lack of such a command.

BR
Kjetil

--===============4636892574154306326==--

