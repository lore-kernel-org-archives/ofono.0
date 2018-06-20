Content-Type: multipart/mixed; boundary="===============3932856684866563727=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SV: SV: Handling empty row from AT command
Date: Wed, 20 Jun 2018 09:28:12 -0500
Message-ID: <3ee3995a-d389-2a50-47b9-d522066a2a9b@gmail.com>
In-Reply-To: <AM5PR1001MB1171A62ECEBBF1FCC2397B0A96770@AM5PR1001MB1171.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3932856684866563727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

By the way, please no top-posting on this list.

> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: AppFinally woke up the modem
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D30\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: =

> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D40\r
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\nDecoder List 0 =

> bytes sent\r\nOK\r\n
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: =

> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App> AT+XSYSTRACE=3D50\r

So this tells me that XSYSTRACE=3D40 command response was processed =

correctly (e.g. OK was detected) and we start the XSYSTRACE=3D50 command.

> Jun 20 13:44:03 lev-26e7jvbe ofonod[16440]: App< \r\n\r\n
> =


This tells me the modem is buggered and isn't responding with anything =

resembling a 'proper' response.  The AT trace will still show anything =

that is being sent on the serial port, so if there's no 'OK' showing up, =

there isn't much that oFono can do.

> But if I skip the=C2=A0AT+XSYSTRACE=3D40, the sequence runs fine:
> =

> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: AppFinally woke up the modem
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT+XSYSTRACE=3D30\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: =

> plugins/verimalto.c:trace_start_at_cb()
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App> AT+XSYSTRACE=3D50\r
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: App< \r\nOK\r\n
> Jun 20 13:54:04 lev-26e7jvbe ofonod[16598]: =


Right, so something in the earlier XSYSTRACE sequence is screwing up the =

firmware.  Get your vendor on the line.

> =

> So I'm suspecting that somehow the extra empty line from AT+XSYSTRACE=3D4=
0 =

> ends up as the response for the AT+XSYSTRACE=3D50, but as it is not an OK =

> it expects more, which for some reason isn't read... Don't know why...

Nope.  The socket is read and data is printed to debug output regardless =

of what the syntax state is.  See gatio.c:received_data()

Regards,
-Denis

--===============3932856684866563727==--

