Content-Type: multipart/mixed; boundary="===============2971888337255197495=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Error sending DTMF with calypso
Date: Thu, 15 Jul 2010 16:37:36 +0200
Message-ID: <AANLkTim0KnxfQnkIajle0Y-gid-3c3x19FX_uCMFRp21@mail.gmail.com>
In-Reply-To: <4C3F1B94.2070406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2971888337255197495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 15, 2010 at 4:30 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Niko,
>
> On 07/14/2010 09:03 PM, Nicola Mfb wrote:
>> Hi!
>> I tried SendTones with calypso during an active call but it failed (v0.2=
2):
>>
>> ofonod[259]: DLC0: > AT\r
>> ofonod[259]: DLC0: < \r\nOK\r\n
>> ofonod[259]: DLC0: Finally woke up the modem
>> ofonod[259]: DLC0: > AT+VTS=3D"1"\r
>> ofonod[259]: DLC0: < \r\nERROR\r\n
>> ofonod[259]: src/voicecall.c:generic_callback() command failed with
>> error: Unknown error type
>>
>> Am I missing somethings?
>>
>
> I admit I never tested it on the calypso. =C2=A0I have a hunch that the
> quotes are not needed for the DTMF character. =C2=A0E.g. AT+VTS=3D1.
>
> Can you try the attached patch and report back?

What fine timing! I just was going to report that rebuilding ofono
without the quotes on the tone char fixed the issue ;)

Thanks

     Niko

--===============2971888337255197495==--

