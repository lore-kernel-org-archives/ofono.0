Content-Type: multipart/mixed; boundary="===============8141566695755125925=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Pulse Audio issues with Ofono
Date: Mon, 06 Mar 2017 20:32:56 +0100
Message-ID: <b01327e9-3186-4b71-6765-087dae9439c0@chini.tk>
In-Reply-To: <CAH9_wROzwHWBRUBXRXUk7_3hm1SsAc50Se3o4D7e=pW+NqCuJQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8141566695755125925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06.03.2017 20:08, Sriram V wrote:
> Hi greg,
>
> I have in the default.pa file.. However, when i issue the command
> using commandline after pulseaudio is executed. i get the error
>
> shared memfd open() failed: Function not implemented
> Connection failure: Connection refused
> pa_context_connect() failed: Connection refused

Which command? Have you run pulseaudio with debug output?

>
> Not sure, if i am missing anything. Is it possible to find out what
> modules pulse audio has loaded after processing default.pa file?
>
> Also, What does the below message mean?
>
> W: [pulseaudio] module-loopback.c: Sample rates too different, not
> adjusting (8000 vs. 24736).

The loopback modules get inserted to connect your speakers/microphone
to your phone (two of them, one for phone output -> speakers and one
for microphone -> phone input). The error message probably originates
from the second module.
It means that module-loopback will not try to adjust the latency, because
the current latency is too far away from the latency that is configured.
Module loopback normally tries to adjust the latency to 200ms if not
otherwise specified by using a different output rate than the input rate.
This way, the samples are played a bit faster or slower until the configured
latency is reached. If the output sample rate would be too far from the
input rate, module loopback refuses to do the correction.
In your case it probably means that the microphone is pushing audio
into the loopback module which is not played back to the phone for some
reason and so accumulates in the buffer of the loopback module. The
latency is growing more and more, you can see that the sample rates
needed for the correction are increasing.

> Thanks,
> Sriram
>
>


--===============8141566695755125925==--

