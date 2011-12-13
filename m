Content-Type: multipart/mixed; boundary="===============0097416770742028975=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v0] CDMA modem implementation support
Date: Tue, 13 Dec 2011 15:51:51 +0100
Message-ID: <4EE76687.4030200@linux.intel.com>
In-Reply-To: <4EE7653B.3040102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0097416770742028975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 13/12/2011 15:46, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 12/13/2011 08:40 AM, Guillaume Zajac wrote:
>> Hi,
>>
>> This is v0 of patch to support CDMA modems into ConnMan ofono plugin.
>> Please tell me if it needs to be split.
>>
>> As current implementation is based on context that is GSM specific,
>> a unique context is created for CDMA modems to be able to add the networ=
k as
>> we can't trigger the context creation from oFono side.
>> Maybe be should create a add_cdma_network() function no to be context
>> dependant although we need to have one to store the IPv4/IPv6 settings, =
index,
>> and modem path.
>>
> I think you sent to the wrong list ;)

Indeed :) I entered --to=3Dofono(a)ofono.org by reflex...

Kind regards,
Guillaume

--===============0097416770742028975==--

