Content-Type: multipart/mixed; boundary="===============7680307620834063576=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/10] quectel: add basic support for serial connected
 modems
Date: Mon, 08 Jul 2019 11:12:50 -0500
Message-ID: <95f32004-bbbe-b70b-7d23-b97c7589da69@gmail.com>
In-Reply-To: <20190708090509.GA30143@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7680307620834063576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 07/08/2019 04:05 AM, Lars Poeschel wrote:
> On Fri, Jul 05, 2019 at 05:57:05PM -0500, Denis Kenzior wrote:
>> Hi Martin,
>>
>> On 07/03/2019 01:09 PM, Martin Hundeb=C3=B8ll wrote:
>>> Setup GSM 07.10 multiplexing using the kernel n_gsm line discpline
>>> driver, and use the virtual tty devices as Aux and Modem channels.
>>>
>>> The driver supports rts/cts on the underlying serial device. This is
>>> enabled with OFONO_QUECTED_RTSCTS udev environment, e.g.:
>>>
>>> KERNEL=3D=3D"ttymxc0", ENV{OFONO_DRIVER}=3D"quectel", \
>>>           ENV{OFONO_QUECTEL_RTSCTS}=3D"on"
>>
>> So from what I recall the kernel multiplexer was pretty much hard-coded =
as
>> to how many DLCs you could request and it was up to the driver to do tha=
t.
>> GAtMux has no such limitations...  We tried it with the ifx driver, but =
in
>> the end GAtMux was more flexible.  Plus you actually get support for
>> multiple devices...
>>
>> So are you sure you want to use the kernel one?
> =

> I would also opt for a way to use the kernel multiplexer. This does not
> mean to make the ofono GAtMux obsolete.
> Some time ago I also wrote a patch for ofono to use the kernel
> multiplexer and it worked quite well. Unfortunately I did not find the
> time to clean it up properly for submission.
> I choose to use the kernel multiplexer because I had some experience
> with it and - well - the ofono one was not flexible enough. ;-) It did
> not support the mux parameters I needed.

So how hard would it be to add support for these parameters to GAtMux =

instead?

> The number of DLCs in the kernel multiplexer is not hardcoded. It
> presents all possible DLCs to userspace (/dev/gsmtty1 - /dev/gsmtty64)
> and as soon as an application tries to open that specific file it sets
> up the DLC on mux level.

Ah, so I was not remembering correctly.  I haven't looked at the kernel =

multiplexer in ~8 years or so.  Thanks for the correction.

However, there is still the fundamental issue of not being able to =

correlate the created ttys to the original one...  If we can fix that in =

the kernel, then a strong argument can be made to drop GAtMux entirely. =

Which is actually what I would prefer as it would make conversion to ell =

much easier.

> =

> So, besides from the code review comments, count this as my vote for the
> kernel multiplexer.
> =

What I want to avoid is having each driver implement its own thing.  It =

makes things far easier to maintain if the driver code is consistent. =

Right now GAtMux is the 'standard', so unless there's a strong argument =

not to use GAtMux in this particular case (I prefer 'foo' is not a =

strong argument),  I'd prefer that we stuck to GAtMux for the sake of =

consistency.

But really, per my earlier comment, I'd be quite supportive of getting =

rid of GAtMux entirely...

Regards,
-Denis

--===============7680307620834063576==--

