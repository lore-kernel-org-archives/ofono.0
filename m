Content-Type: multipart/mixed; boundary="===============1728803779752650817=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: No D-Bus Reply to Activating Context
Date: Tue, 11 Feb 2014 11:18:35 -0600
Message-ID: <52FA5B6B.6020106@gmail.com>
In-Reply-To: <056e01cf2725$54cc6bb0$fe654310$@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1728803779752650817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Brian,

 > 09:20:42.611 gprs.c:863                  pri_activate_callback
> Activating context failed with error: Unknown error type
>

Looking at that line, we are sending a reply right after printing the =

message.  In case the message is NULL, you'd most likely crash inside =

D-Bus or get an assertion of some kind.

The pending variable is also not messed with anywhere else, so you =

should be getting a reply.

The only thing I can suggest is to try and simulate this behavior with =

phonesim and see if you can duplicate / debug it.

Regards,
-Denis


--===============1728803779752650817==--

