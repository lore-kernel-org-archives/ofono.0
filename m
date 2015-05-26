Content-Type: multipart/mixed; boundary="===============8362399798155787383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: bug reactivating primary context?
Date: Tue, 26 May 2015 11:21:36 -0500
Message-ID: <55649D90.80603@gmail.com>
In-Reply-To: <CANPyyuM9YBrrGuTM9FS9ZKgNqUJ6tXvS5RADYstUsoXCFW+ZyA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8362399798155787383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On 05/26/2015 10:38 AM, Mike Williams wrote:
> All,
>
> Using connman/ofono to connect to a cellular network, the first time
> activating the GPRS context works. After deactivation, the next
> activation fails with an unknown error. I believe this is related to
> this issue:
> https://lists.01.org/pipermail/ofono/2015-May/015745.html
>
> Looking through the code, it looks like at_gprs_activate_primary() fails =
at:
>
>         if (g_at_chat_send(gcd->chat, buf, none_prefix,
>                                 at_cgdcont_cb, gc, NULL) > 0)
>                 return;
>
> g_at_chat_send() is returning NULL from at_chat_send_common() because
> the chat command_queue is NULL.

That generally happens because the underlying AT command port for the =

GAtChat has been closed (most likely due to a serial line hangup).

What modem are you using?  Some manufacturers' modems are known to have =

this issue: whenever the PPP connection is dropped, the AT command port =

is closed by the modem.  Issuing AT&C0 should disable this behavior, but =

some modems do not honor that command.

Regards,
-Denis

--===============8362399798155787383==--

