Content-Type: multipart/mixed; boundary="===============2060624434446055206=="
MIME-Version: 1.0
From: ofonoconn@encambio.com
Subject: Re: Problem using wwan0 modem
Date: Tue, 28 Jun 2011 22:01:53 +0200
Message-ID: <20110628200153.GA20542@debut.europalab.com>
In-Reply-To: <4E0A2C1A.8000806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2060624434446055206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Thierry,

On Tues., juin 28, 2011, Thierry Boureille wrote:
>I have the same problem I guess. I use ofono 0.40 and connman since
>release 0.64 which was working well.  after migration to connman
>0.75 I've recently noticed on that ip address is not mounted
>anymore on my gsm interface after my modem is connected and I have
>equivalent ifconfig result than you
>
Not sure what you mean. It's possible that we have a common ofono
or connman problem, but the solution that helped me use list-modems
to 'see' my modem is not in your patch. Instead, it is in udev.c.

...but because I'm having problems even after being able to properly
detect the modem, it may be that the next problem is solved by
looking at your patch. Thanks for the help with that.

>please find here the patch I've just submitted :
>http://lists.connman.net/pipermail/connman/2011-June/005156.html
>
Just looked, but what problem are you trying to solve with that?
If you type ifconfig wwan0 do you get something that you don't
expect? I think the interfaces uses DHCP to get an IP address
from a GPRS carrier rather than PPP, but I'm rather new to this.

Regards,
Michael

--===============2060624434446055206==--

