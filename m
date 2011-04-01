Content-Type: multipart/mixed; boundary="===============2232592621129937184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Motorola Modem H24 gprs connection
Date: Fri, 01 Apr 2011 09:32:01 -0500
Message-ID: <4D95E1E1.8050901@gmail.com>
In-Reply-To: <65D0035E6914AC478A46CFE3E20C3926017CC3FA@snch1xch53.sicpa-net.ads>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2232592621129937184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

Gentle reminder not to top-post on this mailing list.

On 04/01/2011 02:00 AM, Ostermann, Christophe wrote:
> Hi Denis,
> =

> Thank you for this quick answer.
> =

> Yes H24 modem expects some raw data in this mode (after having created a
> TCP or UDP socket). =

> =

> This modem must also support standard way of sending data through ppp. I
> will start by using this mode. I ve tried but unfortunately AT+CGDATA is
> not recognized by this modem. I m just starting to play with this modem
> so I ve to investigate how to configure it properly without this
> command.
> =


You might have luck using the legacy ATD*99 variation instead of CGDATA,
but we don't support this inside the current atmodem/gprs-context.c.
Have a look at gatchat/gsmdial.c, it implements this functionality.  So
you might be able to quickly test whether PPP/ATD*99 works on the H24.

Regards,
-Denis

--===============2232592621129937184==--

