Content-Type: multipart/mixed; boundary="===============2079165229744445969=="
MIME-Version: 1.0
From: Kiviluoto, Jaakko J <jaakko.j.kiviluoto@intel.com>
Subject: RE: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Mon, 15 Nov 2010 08:04:44 +0000
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9A039E9B@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1289574670.3266.112.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2079165229744445969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > To support this feature then first we need to convert the current
> > > feature into returning a dict. And then have this feature using a
> dict
> > > as input.
> >
> > Is there already a specification/draft of the format of this dict? If
> not, I would be tempted to use the 27.007 +CPBR/W field names as keys
> (e.g. index, number, type, text, adnumber, secondtext, sip_uri, etc.)
> =

> there is not. So you need to propose one here.

For simplicity, I would propose that both import and export would use an ar=
ray of dict's with the 27.007 keys:

index: type=3Dinteger, import=3Dalways export=3Dignored
number: type=3Dstring, import=3Dalways/empty export=3Doptional/empty
type: type=3Dinteger, import=3Dalways export=3Dmandatory
text: type=3Dstring, import=3Dalways/empty export=3Doptional/empty
hidden: type=3Dint, import=3Dalways, export=3Doptional/default=3D0
group: type=3Dstring, import=3Dif nonempty, export=3Doptional
adnumber: type=3Dstring, import=3Dif nonempty, export=3Doptional
adtype: type=3Dinteger, import/export=3Dmandatory if adnumber nonempty
secondtext: type=3Dstring, import=3Dif nonempty, export=3Doptional
email: type=3Dstring, import=3Dif nonempty, export=3Doptional
sip_uri: type=3Dstring, import=3Dif nonempty, export=3Doptional
tel_uri: type=3Dstring, import=3Dif nonempty, export=3Doptional

Either 'text' or 'number' must be nonempty on export.

This simple scheme would also necessitate removing the contact merging from=
 the import functionality. Would that be ok?

Otherwise the dict would have to contain a list of number structures instea=
d of number/adnumber fields, and merging/unmerging would have to be (re)imp=
lemented for both import and export.

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


--===============2079165229744445969==--

