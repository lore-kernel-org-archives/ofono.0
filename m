Content-Type: multipart/mixed; boundary="===============6163304778754800607=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Mon, 17 Sep 2012 10:43:44 -0500
Message-ID: <50574530.3030709@gmail.com>
In-Reply-To: <CABvLYuBcjxmc2a4ZUwYj36qbpJrvkuHfL7sQU2+arGW=Yt2cTw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6163304778754800607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

Just a gentle reminder not to top-post on this mailing list

On 09/15/2012 04:20 AM, Cedric Jehasse wrote:
> Hi Denis,
>
> I know the modem is buggy. But oFono could skip invalid characters,
> this would be better then exiting.
>
> Actually the output should be "Mobile Vikings" :-) (but this is
> another bug in the modem). So "BASE" would be the correct output for
> oFono.

To me it sounds like the output should be BASE followed by the inverted =

'!' sign.  Unfortunately the modem is sending ISO-8859-1 characters =

instead of GSM like it is being told to do by the driver.  That =

particular character is not valid utf8, hence we go kaboom.

Having said that, I'm not familiar with 'BASE', does the above sound =

reasonable?

Regards,
-Denis

--===============6163304778754800607==--

