Content-Type: multipart/mixed; boundary="===============2811663485255679053=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Tue, 21 May 2019 05:49:09 +0200
Message-ID: <CAKSBH7FBrDDwdfv42jP-Edb9Z-AFfK91a+9YP1Q4S8UwZbB16A@mail.gmail.com>
In-Reply-To: <10f25d6c-bfdf-9efe-c315-bea6fc03fc90@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2811663485255679053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, May 21, 2019 at 5:43 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Richard,
>
> > ...and we have the issue that the indications seems to be sent in rando=
m order.
>
> Figured..
>
> Try looking at the strategy we employed when dealing with the 27.007
> voice calling (another nightmare) commands.  E.g. +CLIP, +CNAP, +CDIP,
> +CRING/RING, +CCWA, +CLCC, etc.  It might possibly give you some ideas.
> The general strategy is to start a timer, but not perform any queries
> right away and give the modem some time to send in all the unsolicited
> notifications.  Most of the time the modem will send us everything we
> need in one quick (temporal) burst.  But this is not guaranteed of course.
>
> If the timer expires with no additional info received, then perform the
> query/poll, which might end up being redundant due to timing, etc.  In
> general using timers like this is quite racy and can lead to quite ugly
> code.
>

the timer might not work well, because several stacks report a
detach/out-of-service only after an internal timeout. This happens
when another part of the stack, uncoordinated, has registered to
another technology.


> >
> > So what about when a c?reg indication is received from the modem.
> > Start a "poll" of all the supported c?reg and set a flag, so multiple
> > polls are not started in case of an additional indication is received.
> > When the poll of all the supported c?reg statuses returns -> update
> > the gprs "core" with the combined status?
>
> Are you talking about doing this in the gprs driver?  I would bite the
> bullet and do this in the core.  I would also assume the core has to
> perform its own 'combining of the status'.
>
> >
> > .. and the attached_status callback should also poll all supported c?re=
g...
>
> But essentially yes, you're stuck doing that whenever gprs_status has
> changed to searching/unknown.
>
> Regards,
> -Denis

Regards,
Giacinto

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============2811663485255679053==--

