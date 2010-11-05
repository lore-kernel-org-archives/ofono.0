Content-Type: multipart/mixed; boundary="===============4322289891403582618=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/3] doc: addidng documentation for basic assisted gps
Date: Fri, 05 Nov 2010 15:26:25 -0500
Message-ID: <4CD46871.40507@gmail.com>
In-Reply-To: <AANLkTi=eOBp64sTe0en_0G2VXGQ9mFppFd54W1KiY6oe@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4322289891403582618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 11/05/2010 03:21 PM, Sjur Br=C3=A6ndeland wrote:
> Hi,
>>> So in general I'm currently against introducing this API as oFono
>>> official API.  I suggest prefixing this with an IFX specific identifier.
>>>  Maybe modem.ifx.AgpsManager.
>>
>> I would actually go one step further and call this com.infineon.Agps or
>> something like that.
>>
>> As I stated this many times, before we make this a generic oFono API, we
>> need at least three types of modems that support this kind of feature
>> and find the common API.
>>
>> For me this is clearly IFX and ISI right now. And it looks to me that
>> Sjur has also shown interested, so the third one might be STE/MBM.
> =

> Yes, I can confirm that we are looking into this and are planning to
> support AGPS for
> oFono. Would you be interested if we proposed an API whith transparent tr=
ansport
> of the XML specified by 3GPP? Such an API should be possible to
> implement with the
> 3GPP standardized AGPS commands, so that a generic driver could be implem=
ented
> (atmodem/agps.c).
> =


I would definitely like to see a 27.007 based aGPS proposal.

Regards,
-Denis

--===============4322289891403582618==--

