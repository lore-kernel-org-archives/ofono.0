Content-Type: multipart/mixed; boundary="===============1758243615942516608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Fri, 14 Sep 2012 11:18:55 -0500
Message-ID: <505358EF.8000305@gmail.com>
In-Reply-To: <CABvLYuB=QD4n3JzOw3AhUvWxPdoUhEPRB8j44Oqz8EXQSA8DzQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1758243615942516608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 09/14/2012 08:41 AM, Cedric Jehasse wrote:
> Hi,
>
> It looks like "AT+COPS?" returns an invalid character. I guess this is
> passed to DBUS which causes oFono to exit.
>

Correct, but looks like the modem is doing something stupid.

> ofonod[10318]: PCUI:>  AT+COPS?\r
> ofonod[10318]: PCUI:<  \r\n+COPS: 0,0,"BASE\241",2\r\n\r\nOK\r\n

I have no idea what it is sending out, but in theory COPS responses are =

limited to IRA characters.  \241 is clearly not.

The question is, what should the output look like?

Regards,
-Denis

--===============1758243615942516608==--

