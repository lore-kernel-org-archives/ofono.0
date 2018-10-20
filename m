Content-Type: multipart/mixed; boundary="===============0315645296752118863=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Sat, 20 Oct 2018 19:34:44 +0200
Message-ID: <CAKSBH7G5XvQbuS8ws7S+0hJ0DG-uvFhjkXEcyEuj3NFWwq4FBg@mail.gmail.com>
In-Reply-To: <4db04535-7163-094a-2de5-fd7f1c0f3c77@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0315645296752118863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Oct 20, 2018 at 7:24 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/20/2018 05:13 AM, Giacinto Cifelli wrote:
> > Hi Denis,
> >
> > On Mon, Sep 24, 2018 at 11:25 PM Denis Kenzior <denkenz@gmail.com> wr=
ote:
> >>
> >> Hi Giacinto,
> >>
> >>> Besides, several modules use the option linux driver, which blocks in
> >>> case the port doesn't answer.
> >>> This single call:
> >>> g_at_chat_unref(port);
> >>> blocks either 30s or 1 minute, depending on the system. I might step
> >>> into it twice during my hardware initialization for several 3G models.
> >>> It helps to run this line on a separate thread unblocking the rest.
> >>>
> >>
> >> What system call blocks (use strace to determine this) ?  If anything
> >> inside the option driver blocks for 30-60 seconds, that is unacceptable
> >> and needs to be fixed in the kernel.
> >
> > I have finally had time to come back to this.
> > It is the close(fd), called in the g_lib that blocks.
> > I have further discovered that it is due to the fact that there are
> > write pending, and in this case a the closing_wait timeout kicks in.
> > I tried to remove this timeout with an udev rule, but it doesn't work.
> > I could set - still through udev, a call to the tool setserial, but it
> > doesn't seem proper, rules with scripts are heavy, and may also lead
> > to a wrong enumeration in udevng because some devices of the USB
> > enumeration are made available only after the rule has been executed.
>
> I will study this a bit more.  I'm surprised close can block a
> O_NONBLOCK fd...
>
> >
> > So, the code to fix this - in plugins/gemalto.c, would be:
> >
> > #include <asm/ioctls.h>
> > #include <linux/serial.h>
> >
> > int ioctl(int, int, void *);
> >
> > static void closeport(gpointer user_data)
> > {
> >          GAtChat *port =3D user_data;
> >          GIOChannel *channel =3D g_at_chat_get_channel(port);
> >          int fd =3D g_io_channel_unix_get_fd(channel);
> >          struct serial_struct old, new;
> >
> >          g_at_chat_cancel_all(port);
> >          g_at_chat_unregister_all(port);
> >          ioctl(fd, TIOCGSERIAL, &old);
> >          new =3D old;
> >          new.closing_wait =3D ASYNC_CLOSING_WAIT_NONE;
> >          ioctl(fd, TIOCSSERIAL, &new);
> >          g_at_chat_unref(port);
> > }
> >
> > do you see a better way to do it?
>
> Can we simply add this setting to g_at_tty_open?

Yes we can, but it is only available via direct call to ioctl.

Let me know the result of your studies, and in case I can submit a patch.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============0315645296752118863==--

