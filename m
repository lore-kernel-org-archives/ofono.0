Content-Type: multipart/mixed; boundary="===============5435392038728717313=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Pulse Audio issues with Ofono
Date: Mon, 06 Mar 2017 17:45:59 +0100
Message-ID: <3a876ab8-9c47-3ba2-37b6-55ca85c3748b@chini.tk>
In-Reply-To: <CAH9_wRNaD0NNO6n7gC6JeSixt27+Fa6O=bYL9TdAG59DYzcfag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5435392038728717313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 17:36, Sriram V wrote:
> Hello,
>
> I have compiled ofono and am able to dial numbers. (Without Audio
> being exercised)
>
> However, when i get a call, my device throws the following messages:
>
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 16340).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 24736).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 33133).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 41530).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 49995).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 58392).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 66788).
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 75186).
>
>
> I see that there is a mismatch of sampling rate. My sound device
> supports 8K, 44.1K. I am not
> sure what could the problem?
>
> Has anyone see this issue before?
>
>
> Regards,
> sriram
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

What version of pulseaudio are you using? The output from module-loopback
looks rather old. Also did you load module-bluetooth-discover with option
headset=3Dofono?
What version of bluez?


--===============5435392038728717313==--

