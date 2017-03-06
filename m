Content-Type: multipart/mixed; boundary="===============8007159753237991472=="
MIME-Version: 1.0
From: Sriram V <vshrirama@gmail.com>
Subject: Re: Pulse Audio issues with Ofono
Date: Tue, 07 Mar 2017 01:54:31 +0530
Message-ID: <CAH9_wRMqbygDygEL=FdSQEm2zj_uSfnBmA=SB14POXg2ksisUg@mail.gmail.com>
In-Reply-To: <b01327e9-3186-4b71-6765-087dae9439c0@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8007159753237991472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for your response. Is there a way to use only the speaker and
not the microphone?

I have some issues with the microphone on my system.

On 3/7/17, Georg Chini <georg@chini.tk> wrote:
> On 06.03.2017 20:08, Sriram V wrote:
>> Hi greg,
>>
>> I have in the default.pa file.. However, when i issue the command
>> using commandline after pulseaudio is executed. i get the error
>>
>> shared memfd open() failed: Function not implemented
>> Connection failure: Connection refused
>> pa_context_connect() failed: Connection refused
>
> Which command? Have you run pulseaudio with debug output?
>
>>
>> Not sure, if i am missing anything. Is it possible to find out what
>> modules pulse audio has loaded after processing default.pa file?
>>
>> Also, What does the below message mean?
>>
>> W: [pulseaudio] module-loopback.c: Sample rates too different, not
>> adjusting (8000 vs. 24736).
>
> The loopback modules get inserted to connect your speakers/microphone
> to your phone (two of them, one for phone output -> speakers and one
> for microphone -> phone input). The error message probably originates
> from the second module.
> It means that module-loopback will not try to adjust the latency, because
> the current latency is too far away from the latency that is configured.
> Module loopback normally tries to adjust the latency to 200ms if not
> otherwise specified by using a different output rate than the input rate.
> This way, the samples are played a bit faster or slower until the
> configured
> latency is reached. If the output sample rate would be too far from the
> input rate, module loopback refuses to do the correction.
> In your case it probably means that the microphone is pushing audio
> into the loopback module which is not played back to the phone for some
> reason and so accumulates in the buffer of the loopback module. The
> latency is growing more and more, you can see that the sample rates
> needed for the correction are increasing.
>
>> Thanks,
>> Sriram
>>
>>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============8007159753237991472==--

