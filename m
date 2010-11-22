Content-Type: multipart/mixed; boundary="===============5256393768398640010=="
MIME-Version: 1.0
From: Kiviluoto, Jaakko J <jaakko.j.kiviluoto@intel.com>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Mon, 22 Nov 2010 08:05:19 +0000
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A098615@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1290369186.29148.29.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5256393768398640010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> no index number. We will never use them. It is either the full
> phonebook
> at once or nothing. The write function has to empty out left over
> entries.
...
> Actually I prefer we use proper Dict field names. We never use anything
> literally from the specifications in this area. So why start now.
> Please propose proper human readable names.

Well, if we want a generic data structure, I assume it shouldn't be locked =
to any finite amount of phone numbers (number, adnumber) per contact either?

Thus we should implement merging and I guess at the same time effort also t=
he same number categorization that is implemented witht he current Import()=
 function.

So the aa{sv} parameter/return value would be of format:
{
  'name'    : string,
  'group'   : string,   // optional, for eg. organization
  'hidden'  : integer,  // boolean value: defaults to 0
  'numbers' : array of dict {
    'number'   : string,
    'category' : integer
  },
  'emails' : array of dict {
    'address'  : string,
    'category' : integer
  },
  'voip_uris' : array of dict {
    'uri'      : string,
    'category' : integer
  },
}

category : enum { // like existing "enum phonebook_number_type"
  HOME, MOBILE, FAX, WORK, OTHER
}

Notes:
- Phone numbers must have '+' to indicate international type.
- VoIP uri's must have protocol prefix (e.g. 'sip:' or 'tel:')
- Number/address items could also be (si) structs, whichever feels better.

How does that sound?

Jaakko
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki =

Business Identity Code: 0357606 - 4 =

Domiciled in Helsinki =


This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============5256393768398640010==--

