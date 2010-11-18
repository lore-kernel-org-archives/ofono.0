Content-Type: multipart/mixed; boundary="===============1013090506919261068=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: RE: [PATCH] stkutil: mask the DCS value to keep only the intersting
 bits
Date: Thu, 18 Nov 2010 08:54:07 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018813542B193@irsmsx501.ger.corp.intel.com>
In-Reply-To: <4CE3E31D.9050800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1013090506919261068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> =

> Hi Guillaume,
> =

> On 11/15/2010 08:17 AM, Lucas, GuillaumeX wrote:
> > From: Guillaume Lucas <guillaumex.lucas@intel.com>
> >
> > For SIM tool kit only the bits 2 and 3 are interesting
> > for the DCS value. The others ones sould be masked. The
> > masking is necessary because some SIM car set the
> > upper bits to 1.
> > ---
> >  src/stkutil.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/src/stkutil.c b/src/stkutil.c
> > index cdd66bd..a54dd02 100644
> > --- a/src/stkutil.c
> > +++ b/src/stkutil.c
> > @@ -78,7 +78,7 @@ static char *decode_text(unsigned char dcs, int
> len, const unsigned char *data)
> >  {
> >  	char *utf8;
> >
> > -	switch (dcs) {
> > +	switch (dcs & 0x06) {
> =

> Do you mean to bitwise and with 0xc here?  Otherwise you break the UCS2
> case.  Also do any SIMs use the '1111' Coding Bits Entry entry from
> 23.038 Section 4?  If so, then we need to use sms_dcs_decode to
> retrieve
> the character set.

Yes you are right. I did a bit-shifting error in my mask and don't see it d=
uring my test.
It's 0xc and not 0x6 to use for the mask.

The issue that I've is effectively due to the fact that some SIMs use the '=
1111' Coding Bits Entry (it's the case for French Orange SIM card for examp=
le). For me having the upper bits set to '1' do not really changes the char=
acter set decoding (only diff is that UCS2 will not be possible in that cas=
e). It's the reason why I've simply add a mask in the decode_text function.=
 Using the sms_dcs_decode function is probably better as the DCS of the SIM=
 ToolKit is the same as the one used for SMS.

Do you want that I re-publish a patch using the sms_dcs_decode function?

Regards
Guillaume
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1013090506919261068==--

