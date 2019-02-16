Content-Type: multipart/mixed; boundary="===============5221420058658396166=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 1/8] ublox-serial: add new plugin for u-blox
Date: Sat, 16 Feb 2019 15:55:53 +0200
Message-ID: <CAPsFW+SkMXs609tAnEdgjAZPUVR4n3TR6y5YL=h6JHR4P3cKFA@mail.gmail.com>
In-Reply-To: <c47b185e-54ed-302d-9ec1-3fbca2651a09@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5221420058658396166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/02/2019, Jonas Bonn <jonas@norrbonn.se> wrote:
> Hi,
>
> My spontaneous reaction to this is:  why does this need to be a separate
> plugin?  At first glance, it appears to be largely a copy of the ublox
> plugin and the seemingly small differences would have been easy to
> finesse into the existing driver.
> Could you provide some more justification for requiring a completely new
> plugin here?

True it looks very similar, however the current driver works for USB
only and also uses muxing which seems to be buggy on the serial port.
(it eats error messages for example).

> Thanks,
> Jonas
>
> (Just for info, I'm working on support for the TOBY L4 currently... it
> would be preferable to get as much u-blox support into one place as
> possible rather than spreading it out over multiple plugins/drivers.
> All these modems share common documentation, after all.)

I understand the sentiment but I did not immediately see a way to
combine the two, and giving the limited time to get it running making
it's own plugin turned out to be the easiest given the issues
(USB/broken mux) I ran into.

Regards,

Philippe

--===============5221420058658396166==--

