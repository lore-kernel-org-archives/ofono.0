Content-Type: multipart/mixed; boundary="===============3423523128898993725=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Telit he910 ---- modem port got stuck
Date: Tue, 12 Mar 2013 14:42:03 +0100
Message-ID: <513F30AB.6060806@southpole.se>
In-Reply-To: <513F2CF7.7040704@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3423523128898993725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/12/2013 02:26 PM, Ming Li Wu wrote:
> Hello,
>
> I am using Telit HE910 modem, the version of firmware is 12.00.03.
>
> Sometimes, the modem port got stuck after sending AT+CGDCONT=3D1.
> (Such as AT+CGDCONT=3D1,"IP","internet.tele2.se").
>
>
> The following was the situation when this problem happened
>   Aux: > AT+CRSM=3D192,28621\r
>   Modem: > AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
>   Modem: < AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
>   Aux: < \r\n+CME ERROR: 4\r\n

The problem, in short, is that the Telit HE910 does not support sending =

any AT command on the Modem port while there is an outstanding command =

on the Aux port (this should be true for all Telit modems).  Does Ofono =

support synchronizing these two channels so that they effectively share =

a common command queue?  If yes, how?

/Jonas

--===============3423523128898993725==--

