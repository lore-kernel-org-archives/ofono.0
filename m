Content-Type: multipart/mixed; boundary="===============5745400158691294026=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Mon, 18 Jan 2010 13:38:16 +0200
Message-ID: <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
In-Reply-To: <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5745400158691294026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 14, 2010 at 1:39 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi,
>
> On Mon, Jan 11, 2010 at 5:05 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> On Mon, Jan 11, 2010 at 3:08 PM, Gustavo F. Padovan
>> <padovan@profusion.mobi> wrote:
>>> Hi,
>>>
>>> These patches implement the new API for the Audio Gateway in BlueZ. It
>>> follows the last version of the HandsfreeGateway and HandsfreeAgent
>>> Intefaces API.
>>> The first two patches is for BlueZ and the other for oFono. You can
>>> test it with using enable-modem and test-voicecall scripts into the
>>> test dir of oFono.
>>> Feel free to test it and send me your comments. We have some bugs yet.
>>
>> New version of the patches: now we do not handle tty stuff on the BlueZ =
side.
>
> New version of the patches. Known issues:
> "'org.bluez.HandsfreeAgent.Release' part not implemented" and it's not
> working with more than one bluetooth devices in some cases. Comments
> are welcome.

Since nobody really respond me in the thread about merging endpoints
with this spec I will comment in this one, although Johan disagree on
having it as a MediaEndpoint I guess it is probably a good idea to
have a similar design as we will have in endpoints, so the
registration actually happen in adapter path rather than device path,
which probably should avoid the having to resolve the device path
while probing if we just send the device path as a parameter of
NewConnection so we can do while in DEFER_SETUP stage so we don't risk
missing or getting timeouts while transferring the the fd to ofono.

>>
>>>
>>> The audio part is not working yet. We are going to work on pulseaudio
>>> this week to get this done soon.

Well I suppose we will be using the endpoint to handle this.

>>> Regards,
>>>
>>> --
>>> Gustavo F. Padovan
>>> ProFUSION embedded systems - http://profusion.mobi
>>>
>>
>>
>>
>> --
>> Gustavo F. Padovan
>> ProFUSION embedded systems - http://profusion.mobi
>>
>
>
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>



-- =

Luiz Augusto von Dentz
Engenheiro de Computa=C3=A7=C3=A3o

--===============5745400158691294026==--

