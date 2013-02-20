Content-Type: multipart/mixed; boundary="===============6572759833096175136=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH] doc: Add experimental handsfree-audio API
Date: Wed, 20 Feb 2013 10:19:35 +0100
Message-ID: <51249527.8000605@linux.intel.com>
In-Reply-To: <CANT-zCXA0E-5MOu-KWu9HL=8e3BrPRavufd3cM3mY_-u3jaKvA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6572759833096175136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mikel,

On 20/02/2013 09:55, Mikel Astiz wrote:
<snip>

>> +Handsfree Audio Card hierarchy [experimental]
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Service                org.ofono
>> +Interface      org.ofono.HandsfreeAudioCard
>> +Object path    /{device0,device1,...}
>
> I'd propose dropping this interface entirely or at least using the
> conventional modem object path, assuming that every HandsfreeAudioCard
> would necessarily have an associated modem.
>
> After all, the Audio agent would typically have to match cards with
> modems, probably because the associated voicecall status needs to be
> known (e.g. if the HS wants to ignore the inband-ringing and instead
> use another ring tone).
>
In case of HFP AG, there could be connections with multiple handsfrees, =

so multiple emulator and HandsFreeAudioCard for a modem.

So, we can not use modem path directly.

Regards

Fred


-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============6572759833096175136==--

