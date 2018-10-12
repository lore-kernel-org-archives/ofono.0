Content-Type: multipart/mixed; boundary="===============5969745646834126161=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 18:54:18 +0200
Message-ID: <CAKSBH7EWLpeujk-QegZmB0P3P7Kdi4Tv1PLg7F0gb6T0WPLZMg@mail.gmail.com>
In-Reply-To: <fe2ef791-e8de-c3ca-b430-8a5c6ddec9c6@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5969745646834126161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I trust you, but I have checked the code :)

you are right, the at_command_create may fail (on allocation error
from g_try_new0) and in this case it doesn't call the g_free.

However I have to say that the code leaks alot: overall the construct
is used 237 times, and only 98 times the g_free is called.
That said, according to Denis nowadays we don't use g_try_new0 because
the allocation won't fail, so we are unlikely to see it in action.

I add the g_free :D

Regards,
Giacinto

On Fri, Oct 12, 2018 at 6:31 PM Jonas Bonn <jonas@southpole.se> wrote:
>
>
> On 12/10/18 18:23, Giacinto Cifelli wrote:
> > actually:
> >
> >>> +
> >>> +     if (g_at_chat_send(cbd->ldd->chat, buf, NULL,
> >>> +                     at_lte_set_auth_cb, cbd, g_free) > 0)
> >>> +             return;
> >>> +
> >> Here you'll leak cbd again.
> > here there is a g_free in the call. Also in case of failure the g_free
> > is executed, I think (also because it is the same construct as
> > everywhere else).
> > Or not?
>
> If g_at_chat_send returns 0, g_free() won't be called so you need to
> free the data yourself.  That should be the construct used elsewhere so
> if you see it done differently your seeing bugs (probably).
>
> /Jonas
>

--===============5969745646834126161==--

