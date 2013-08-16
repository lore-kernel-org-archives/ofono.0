Content-Type: multipart/mixed; boundary="===============6013836979828768771=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP negotiation failing
Date: Fri, 16 Aug 2013 11:05:50 -0500
Message-ID: <520E4DDE.4030900@gmail.com>
In-Reply-To: <520CC8F0.2030802@dataprom.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6013836979828768771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On 08/15/2013 07:26 AM, Fabio S. Higa wrote:
> Hello all,
>
> We are working with the modem Telit GE910-QUAD (GSM/GPRS) and trying to
> make it work with Ofono 1.12.
>
> In our tests we successfuly make a connection using pppd, but using
> Ofono occur an error during ppp negotiation (configuration rejected, RCR-=
).
>
> Log follows below. Any help would be appreciated.
>

The AT command log is not useful in this case.  You would need to run =

gatchat/gsmdial with the pppdump option and examine it with wireshark to =

understand what fails.

Regards,
-Denis


--===============6013836979828768771==--

