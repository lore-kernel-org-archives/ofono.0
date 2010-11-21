Content-Type: multipart/mixed; boundary="===============4784812671453241721=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Sun, 21 Nov 2010 20:53:06 +0100
Message-ID: <1290369186.29148.29.camel@aeonflux>
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A039E9B@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4784812671453241721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jaako,

> > > Is there already a specification/draft of the format of this dict? If
> > not, I would be tempted to use the 27.007 +CPBR/W field names as keys
> > (e.g. index, number, type, text, adnumber, secondtext, sip_uri, etc.)
> > =

> > there is not. So you need to propose one here.
> =

> For simplicity, I would propose that both import and export would use an =
array of dict's with the 27.007 keys:
> =

> index: type=3Dinteger, import=3Dalways export=3Dignored

no index number. We will never use them. It is either the full phonebook
at once or nothing. The write function has to empty out left over
entries.

> number: type=3Dstring, import=3Dalways/empty export=3Doptional/empty
> type: type=3Dinteger, import=3Dalways export=3Dmandatory
> text: type=3Dstring, import=3Dalways/empty export=3Doptional/empty
> hidden: type=3Dint, import=3Dalways, export=3Doptional/default=3D0
> group: type=3Dstring, import=3Dif nonempty, export=3Doptional
> adnumber: type=3Dstring, import=3Dif nonempty, export=3Doptional
> adtype: type=3Dinteger, import/export=3Dmandatory if adnumber nonempty
> secondtext: type=3Dstring, import=3Dif nonempty, export=3Doptional
> email: type=3Dstring, import=3Dif nonempty, export=3Doptional
> sip_uri: type=3Dstring, import=3Dif nonempty, export=3Doptional
> tel_uri: type=3Dstring, import=3Dif nonempty, export=3Doptional

Actually I prefer we use proper Dict field names. We never use anything
literally from the specifications in this area. So why start now. Please
propose proper human readable names.

Regards

Marcel



--===============4784812671453241721==--

