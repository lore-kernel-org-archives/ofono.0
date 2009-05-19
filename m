Content-Type: multipart/mixed; boundary="===============4041004890654238972=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call Control, Media Control, Documentation
Date: Tue, 19 May 2009 10:07:15 -0500
Message-ID: <200905191007.16848.denkenz@gmail.com>
In-Reply-To: <8f9d9e260905182145t2a371590w54e73e97c610ef51@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4041004890654238972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vince,

On Monday 18 May 2009 23:45:34 Vince Corning wrote:
> Hello from a newbie,
>
> I'm interested in finding out more about ofono's call control and media
> control capabilities.  From the high level diagram, it looks like call
> control is included, but what about media control (ex. record call, ASR,
> TTS, play music to call, open microphone, play music to speaker)

These parts are generally extremely specific to the particulars of the =

hardware.  Currently we're not planning to support any of the things you =

mentioned in the oFono D-Bus APIs.

The encapsulation of audio driver/hardware/implementation should ideally be=
 in =

another subsystem anyway.  Something like PulseAudio for instance.  Of cour=
se =

to support certain platforms we will need some way of integrating with the =

audio policy framework (e.g. sending vendor-specific at commands related to =

audio.)  We haven't really figured out the details here yet...

>
> Any pointer to documentation and supported hardware/os would be
> appreciated...

No hardware is officially supported yet.

>
> Thanks,
>
> Vince

Regards,
-Denis

--===============4041004890654238972==--

