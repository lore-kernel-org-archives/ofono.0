Content-Type: multipart/mixed; boundary="===============6918004416431333586=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Tue, 23 Nov 2010 07:37:13 +0100
Message-ID: <1290494233.13641.3.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A098615@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6918004416431333586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jaakko,

> > no index number. We will never use them. It is either the full
> > phonebook
> > at once or nothing. The write function has to empty out left over
> > entries.
> ...
> > Actually I prefer we use proper Dict field names. We never use anything
> > literally from the specifications in this area. So why start now.
> > Please propose proper human readable names.
> =

> Well, if we want a generic data structure, I assume it shouldn't be locke=
d to any finite amount of phone numbers (number, adnumber) per contact eith=
er?
> =

> Thus we should implement merging and I guess at the same time effort also=
 the same number categorization that is implemented witht he current Import=
() function.
> =

> So the aa{sv} parameter/return value would be of format:
> {
>   'name'    : string,
>   'group'   : string,   // optional, for eg. organization
>   'hidden'  : integer,  // boolean value: defaults to 0
>   'numbers' : array of dict {
>     'number'   : string,
>     'category' : integer
>   },
>   'emails' : array of dict {
>     'address'  : string,
>     'category' : integer
>   },
>   'voip_uris' : array of dict {
>     'uri'      : string,
>     'category' : integer
>   },
> }
> =

> category : enum { // like existing "enum phonebook_number_type"
>   HOME, MOBILE, FAX, WORK, OTHER
> }

this feels a bit too complicated for me. I actually don't want to
over-design this feature, but it does have to be consistent with our
other key names.

To be honest, the more and more I think about this, the more my
conclusion is to not support phonebook export. It is a bad idea. It is
highly complex and it is not a feature that will be used anyway.

Regards

Marcel



--===============6918004416431333586==--

