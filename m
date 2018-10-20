Content-Type: multipart/mixed; boundary="===============4938671879444593469=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 18:09:07 +0200
Message-ID: <CAKSBH7GdXVfM_ngUuvUZH6GoXPQ_C5aA=gA=gQfJPeah8HUDEw@mail.gmail.com>
In-Reply-To: <a96c428a-500d-1a92-a7ae-1f2c0690cebf@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4938671879444593469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, Oct 20, 2018 at 6:04 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/20/2018 05:26 AM, Giacinto Cifelli wrote:
> > added the function g_at_chat_finish_command, in order to be able to
> > interrupt a pending command.
> > The function is useful in special cases, for example to implement
> > a custom g_at_chat_set_wakeup_command. This command will never
> > return if the device does not answer, and therefore it is unsuitable
> > to probe configurations.
>
> I don't think this is a good idea.  In general the caller has no clue
> what command he is actually finishing since there may be other commands
> being queued.
>
> You might want to provide more context as to what you're actually trying
> to accomplish.  It might be easier to just use g_at_chat_cancel and a
> g_timeout_add_seconds combination for this...

I need to probe with 'AT' once per second the modem and the
application port, one after the other.
It needs to be repeated a few times, because the device might be
booting up, but it could also be that the device is not responding
(because, for example, mapped on the RS232).

Another use could be to abort a long-running command (eg: SMS sending,
which can take up to 3 minutes), to allow the application to do
something else, eg: emergency call.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============4938671879444593469==--

