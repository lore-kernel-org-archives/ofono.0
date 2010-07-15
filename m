Content-Type: multipart/mixed; boundary="===============7935623586295953340=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Error sending DTMF with calypso
Date: Thu, 15 Jul 2010 09:42:27 -0500
Message-ID: <4C3F1E53.3070602@gmail.com>
In-Reply-To: <AANLkTim0KnxfQnkIajle0Y-gid-3c3x19FX_uCMFRp21@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7935623586295953340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

On 07/15/2010 09:37 AM, Nicola Mfb wrote:
> On Thu, Jul 15, 2010 at 4:30 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Niko,
>>
>> On 07/14/2010 09:03 PM, Nicola Mfb wrote:
>>> Hi!
>>> I tried SendTones with calypso during an active call but it failed (v0.=
22):
>>>
>>> ofonod[259]: DLC0: > AT\r
>>> ofonod[259]: DLC0: < \r\nOK\r\n
>>> ofonod[259]: DLC0: Finally woke up the modem
>>> ofonod[259]: DLC0: > AT+VTS=3D"1"\r
>>> ofonod[259]: DLC0: < \r\nERROR\r\n
>>> ofonod[259]: src/voicecall.c:generic_callback() command failed with
>>> error: Unknown error type
>>>
>>> Am I missing somethings?
>>>
>>
>> I admit I never tested it on the calypso.  I have a hunch that the
>> quotes are not needed for the DTMF character.  E.g. AT+VTS=3D1.
>>
>> Can you try the attached patch and report back?
> =

> What fine timing! I just was going to report that rebuilding ofono
> without the quotes on the tone char fixed the issue ;)

Good :) I pushed the quote fix upstream.

Thanks,
Denis

--===============7935623586295953340==--

