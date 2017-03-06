Content-Type: multipart/mixed; boundary="===============7036848418333528123=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Pulse Audio issues with Ofono
Date: Mon, 06 Mar 2017 18:53:24 +0100
Message-ID: <732f8f0d-4895-c943-3791-d6495a4f7ec5@chini.tk>
In-Reply-To: <CAH9_wRPstqG4up-VrVHnnim_xSabPkn=Xc3j8vpHW0wwn6jxzQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7036848418333528123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 18:34, Sriram V wrote:
> Hi,
>
> I am using Pulse Audio 9.0. When i load i get the error
>
> shared memfd open() failed: Function not implemented
> Connection failure: Connection refused
> pa_context_connect() failed: Connection refused
>
> Is this the right pulseaudio version to use with bluez 5.4.3?
>
> Regards,
> Sriram

Pulseaudio 9.0 should be OK. As mentioned below, did you
add the option headset=3Dofono to module-bluetooth-discover
in default.pa?

>
> On Mon, Mar 6, 2017 at 10:15 PM, Georg Chini <georg@chini.tk> wrote:
>> On 06.03.2017 17:36, Sriram V wrote:
>>> Hello,
>>>
>>> I have compiled ofono and am able to dial numbers. (Without Audio
>>> being exercised)
>>>
>>> However, when i get a call, my device throws the following messages:
>>>
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 16340).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 24736).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 33133).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 41530).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 49995).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 58392).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 66788).
>>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>>> adjusting (8000 vs. 75186).
>>>
>>>
>>> I see that there is a mismatch of sampling rate. My sound device
>>> supports 8K, 44.1K. I am not
>>> sure what could the problem?
>>>
>>> Has anyone see this issue before?
>>>
>>>
>>> Regards,
>>> sriram
>>> _______________________________________________
>>> ofono mailing list
>>> ofono(a)ofono.org
>>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>> What version of pulseaudio are you using? The output from module-loopback
>> looks rather old. Also did you load module-bluetooth-discover with option
>> headset=3Dofono?
>> What version of bluez?
>>


--===============7036848418333528123==--

