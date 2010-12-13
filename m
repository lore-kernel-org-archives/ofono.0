Content-Type: multipart/mixed; boundary="===============8821609953880147540=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA MO Call Support
Date: Mon, 13 Dec 2010 12:53:22 -0800
Message-ID: <1292273602.11965.46.camel@dardoyle-desktop>
In-Reply-To: <1292017318.4927.67.camel@dardoyle-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8821609953880147540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Fri, 2010-12-10 at 22:41 +0100, Spieker-Doyle Dara
(Nokia-MS/SanDiego) wrote:
> Hi Denis
> =

> On Thu, 2010-12-09 at 09:43 +0100, ext Denis Kenzior wrote:
> =

> > =

> > >  drivers/cdma-atmodem/atutil.c    |   45 +++++++++
> > >  drivers/cdma-atmodem/atutil.h    |   65 +++++++++++++
> > =

> > Are these verbatim copies of atmodem/atutil.[ch]?  If so, then there's
> > no reason why you can't re-use those.  No need to copy them.
> =

> No, they are not verbatim copies as e.g. error decoding is different.
> Would you prefer we clarify this by renaming the files cdmautil.(ch)?
> =

On second thoughts, I agree for this patch - I will correct this and
re-use the drivers/atmodem/atutil.[ch].
Additionally, for future feature support, I do envisage some delta with
various AT utilities for CDMA. For example, with our current hardware,
the AT return string can have a different format from the GSM AT command
standard. =

Do you have any particular preference in such cases as to whether we
modify the e.g. gatchat sources directly to support this or whether we
create CDMA specific functions within the cdma-atmodem driver?

Thank you
Dara



--===============8821609953880147540==--

