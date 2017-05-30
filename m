Content-Type: multipart/mixed; boundary="===============2946601368719590846=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Does Ofono pass error codes up to applications over DBus
Date: Tue, 30 May 2017 17:28:02 -0500
Message-ID: <9a0ad062-0f42-7bdb-7ffd-cc0788feee44@gmail.com>
In-Reply-To: <CAOLU1cT=T81vS3=deCzp=yfvVFRJ2-d5rs+ZB8z7gdo2-xNzvQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2946601368719590846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rohit,

Hi Rohit,

On 05/24/2017 11:27 AM, Rohit Agrawal wrote:
> Hi All,
>
> I have a general query regarding error code value being passed up by
> ofono to applications over Dbus.
>
> Assume Ofono talks to Modem through RILD. Does Ofono passes error code
> or error value when Voice-Call or Data-Call or Send-SMS fails so that
> application can do something on receiving such error codes ?
>

Not really.  We try to decode the error into something more generic if =

the driver provides us such information, but the raw error value is not =

returned to the application.  See src/dbus.c, __ofono_error_from_error()

>
> Also SMS Delivery Report is given to application through which Signal
> (Immediate Message or Incoming Message) ?

Delivery reports are handled through the history plugin.  They are not =

exposed over the D-Bus API.  See include/history.h and examples/history.c

Regards,
-Denis

--===============2946601368719590846==--

