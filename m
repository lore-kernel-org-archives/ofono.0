Content-Type: multipart/mixed; boundary="===============5399879816827151236=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] AGPS Support
Date: Wed, 03 Nov 2010 12:55:11 -0500
Message-ID: <4CD1A1FF.50101@gmail.com>
In-Reply-To: <AANLkTimt4=Gkh9K1Xh4qckTKKO+WqacdmtJJuf_Jaubd@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5399879816827151236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 11/03/2010 12:40 PM, Aki Niemi wrote:
> Hi,
> =

> 2010/11/3 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
>> I was previously under the false impression that you wanted oFono API
>> to export AGPS functionality using dbus types only. Piping the AGPS
>> XML (or ASN.1 coded data)
>> through oFono certainly makes the oFono implementation much simpler.
>> I'm all for that :-)
> =

> I think it has been the working assumption to just forward raw data
> over D-Bus; PDU as an array of bytes. I believe the ISI modem
> interface exposes raw ASN.1 PDUs directly.
> =

> Obviously we need to pick one format for the D-Bus interface, but I'm
> a little wary of transcoding between the two formats, be it in the
> core or in the drivers.

Oh I can definitely see that no matter which one we pick it will be
inconvenient for some vendors.  But I think we're all interested in
picking one 'standard' one to avoid fragmentation.

Are all vendors utilizing the same ASN.1 binary encoding format, or is
that also variable between vendors?  We already have a disaster with CAT
spec using C-TLVs and BER-TLVs and it is a really bad idea to expose
upper layers to these details.

Can someone perform due diligence into what it would take to convert
ASN.1 into XML?  If the amount of work is not large, then it is another
point for the XML / 27.007 approach.

Regards,
-Denis

--===============5399879816827151236==--

