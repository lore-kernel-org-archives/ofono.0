Content-Type: multipart/mixed; boundary="===============6457740743371626870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to get network interface working
Date: Fri, 03 Oct 2014 09:28:18 -0500
Message-ID: <542EB282.2060007@gmail.com>
In-Reply-To: <CAH4ZQwtdtSyR_Fy8R_dEd-PgGpK+uF+7spUxssF_EcnrMh_fLQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6457740743371626870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/03/2014 07:40 AM, Enrico Sau wrote:
> Hi Denis, hi all,
>
> I finally got the network interface working by uninstalling the network
> manager and manually setting the ppp0 interface with parameters
> retrieved from the modem.
>

good

> I have another problem:
> I start the network interface with activate-context python script, and
> stop with deactivate-context script.
> Once I call deactivate-context, I'm no more able to activate it because
> ppp disconnect function calls io_disconnect method, which clears the at
> channel.
> The only way to resume the ppp connection is to disable and re-enable
> the modem in order fot the at channel structures to be filled in again.
>

This is a known issue on some hardware, or may be an issue with the =

modem driver for the hardware you are using.  First some background:

Whenever PPP is disconnected, there are several ways to indicate a hangup:
   1. Send an escape sequence to AT mode, followed by 'NO CARRIER'
   2. Send a low level serial line hang-up

Many modems do both, which results in the tty port being 'closed'.  This =

is why you see the ppp_disconnect being triggered.

oFono understands escape sequences, so #1 is sufficient.  On most =

hardware we can send AT&C0 to disable #2, but some hardware still =

ignores that.

Hardware that uses a high-speed interface (most anything released in the =

last few years) doesn't suffer from this issue.

> Is there any reason for that? Is deactivate-context the correct way to
> temporary stop the network?
>

Yes, that is the correct way, assuming your hardware is well behaved.

Regards,
-Denis

--===============6457740743371626870==--

