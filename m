Content-Type: multipart/mixed; boundary="===============5329160999528332082=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC] AGPS Support
Date: Wed, 27 Oct 2010 10:39:18 +0100
Message-ID: <129600E5E5FB004392DDC3FB599660D70104BC3ED9@irsmsx504.ger.corp.intel.com>
In-Reply-To: <4CC1B462.7040409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5329160999528332082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

My two cents...
> -----Original Message-----
> =

> > I think the oFono interface should not use binary data, but rather be
> aligned with 27.007
> > and present decoded data as DBUS typed signals and methods with the
> same information
> > content as specified in the XML data for AT+CPOS, AT+CPOSR.
> =

> This was proposed several times.  The main objections against the XML
> file format was the difficulty of parsing such a beast and support of
> it
> by modem vendors.
> =

> Personally (and this is based on rather limited experience with this
> area) I'm not against the idea; it fits with oFono's overall strategy
> of
> following 27.007 whenever possible...


AFAIK, it does not exist a free standard API for satellite measurements and=
 GPS assistance data. Moreover, while Galileo and Compass GNSS are not yet =
deployed, GLONASS support will be soon a need.

So, the idea is to not interpret positioning data or request and to pass th=
em transparently from the modem to the positioning framework and vis versa. =


On positioning framework side, XML containers encoding/decoding does not se=
em to be yet widely used, while the support of RRC and RRLP framing is comm=
on, thanks to the support of SUPL.

Using XML and 27.007 format would be great as long as long as ofono is not =
obliged to interpret the XML containers. =


BR,

Fred =

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


--===============5329160999528332082==--

