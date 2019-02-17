Content-Type: multipart/mixed; boundary="===============1142328516030472841=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/8] ublox-serial: add new plugin for u-blox
Date: Sun, 17 Feb 2019 15:46:27 +0100
Message-ID: <d75a7fb1-8ead-f0c2-5381-75c3760be7bd@norrbonn.se>
In-Reply-To: <CAPsFW+SkMXs609tAnEdgjAZPUVR4n3TR6y5YL=h6JHR4P3cKFA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1142328516030472841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/02/2019 14:55, Philippe De Swert wrote:
> Hi,
> =

> On 16/02/2019, Jonas Bonn <jonas@norrbonn.se> wrote:
>> Hi,
>>
>> My spontaneous reaction to this is:  why does this need to be a separate
>> plugin?  At first glance, it appears to be largely a copy of the ublox
>> plugin and the seemingly small differences would have been easy to
>> finesse into the existing driver.
>> Could you provide some more justification for requiring a completely new
>> plugin here?
> =

> True it looks very similar, however the current driver works for USB
> only and also uses muxing which seems to be buggy on the serial port.
> (it eats error messages for example).
> =


Could you elaborate on this?  If you don't want the mux'ing, you just =

skip setting up the channel (that you don't have, anyway).  There's no =

other mux'ing in the driver.  If you skip that, I can't immediately see =

that you are actually doing anything particularly different that will =

cause any change in how error messages are propagated.



>> Thanks,
>> Jonas
>>
>> (Just for info, I'm working on support for the TOBY L4 currently... it
>> would be preferable to get as much u-blox support into one place as
>> possible rather than spreading it out over multiple plugins/drivers.
>> All these modems share common documentation, after all.)
> =

> I understand the sentiment but I did not immediately see a way to
> combine the two, and giving the limited time to get it running making
> it's own plugin turned out to be the easiest given the issues
> (USB/broken mux) I ran into.

I spent some time looking at this... I really don't see that this =

warrants it's own plugin.  Half of the diff is just data->aux --> =

data->dlc renaming... the rest is simple stuff that's easily hidden =

behind model checks.  This is better implemented as incremental changes =

to the existing ublox plugin; that's much easier to review and provides =

better insight into what's going on.

Or provide more justification as to why having this as a separate plugin =

is absolute necessary.

Thanks,
/Jonas


> =

> Regards,
> =

> Philippe
>=20

--===============1142328516030472841==--

