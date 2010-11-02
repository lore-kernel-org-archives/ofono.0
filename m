Content-Type: multipart/mixed; boundary="===============5782301830444552111=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] AGPS Support
Date: Tue, 02 Nov 2010 15:50:02 -0500
Message-ID: <4CD0797A.5070602@gmail.com>
In-Reply-To: <AANLkTi=fV5PfLtyzpWUsJt+uG0VoULdBUG5AAT-OxC0h@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5782301830444552111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 11/02/2010 03:36 PM, Sjur Br=C3=A6ndeland wrote:
> Hi Denis,
> =

> Fredric wrote:
>> On positioning framework side, XML containers encoding/decoding does not=
 seem to be yet widely used, while the support of RRC and RRLP framing is c=
ommon, thanks to the support of SUPL.
>>
>> Using XML and 27.007 format would be great as long as long as ofono is n=
ot obliged to interpret the XML containers.
> =

> Denis, is this something you would consider as an option, to transport
> both ASN.1 coded RRC / RRLP frames
> and XML transparently over the oFono API ?
> =


The question here is really about what has the best chance of being
accepted as 'official' API prefixed with org.ofono.  I don't see the
binary variant having a chance of being accepted right now.  With XML I
can see it becoming the official API since it is defined by 27.007.

Having said that, both can indeed co-exist side-by-side.

What are the possible reasons as to why oFono might need to peek inside
the XML?

> Regards,
> Sjur

Regards,
-Denis

--===============5782301830444552111==--

