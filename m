Content-Type: multipart/mixed; boundary="===============8691367278141251402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel TCP/IP connection
Date: Wed, 08 May 2019 19:16:50 -0500
Message-ID: <9b6eae26-9952-fcbd-4b45-dbd85d4a3654@gmail.com>
In-Reply-To: <CACUGKYNcz0xOZsiJLnsVzvwfX4QK-LBvGTYX+2LZL7SoZnu1xg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8691367278141251402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 05/08/2019 06:13 PM, John Tobias wrote:
> Hi all,
> =

> I was trying to integrate the quectel =

> <https://www.quectel.com/UploadImage/Downlad/Quectel_BG96_TCP(IP)_AT_Comm=
ands_Manual_V1.0.pdf>=C2=A0tcp/ip =

> connection in the ofono driver. I used AT+QIOPEN for opening the =

> socket,=C2=A0AT+QIRD for receiving data from the server and=C2=A0AT+QISEN=
DEX for =

> sending data to the server.
> =


Out of curiosity, why?  Since you're running oFono, which runs on Linux, =

you should have a fully-featured and much easier to use IP stack =

available to you?

> The 3 functions are working correctly if I executed it directly in the =

> serial port. I had issue with ofono when it send the AT+QISENDEX. Below =

> is the command:
> =

> char const *command2 =3D "AT+QISENDEX=3D2,\"48656c6c6f\"";
> g_at_chat_send(data->aux, command2, none_prefix, NULL, NULL,NULL);
> =

> =

> The first execution of the QISENDEX works. My server received the data =

> but when I try it again, the ofono stuck somewhere where the it couldn't =

> run any AT commands anymore. Then, I killed the ofono and opened the =

> serial, I ran this command=C2=A0AT+QISENDEX=3D2,"48656c6c6f" and it works=
 fine.

You may want to enable AT command debugging.  See HACKING for details. =

One possibility is that the firmware gets AT command response formatting =

wrong.  E.g. something in the response confuses GAtSyntax.

Regards,
-Denis

--===============8691367278141251402==--

