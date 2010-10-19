Content-Type: multipart/mixed; boundary="===============4713331809745413638=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Need clarification in querying the pin status
Date: Tue, 19 Oct 2010 10:01:59 -0500
Message-ID: <4CBDB2E7.5090505@gmail.com>
In-Reply-To: <AANLkTi=H6EyU+axbHFavYR3DqYo7BVByTnLHje_3hKUq@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4713331809745413638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mamata,

On 10/19/2010 09:20 AM, mamata l wrote:
> Hi,
> =

> I need clarification for querying the pin status when enabling/disabling
> pin fails and the maximum number of attempts of wrong password are
> reached in the modem.
> =

> I am trying to enable pin with the wrong password, and trying to get the
> pin status. I observe that the maximum number of attempts for wrong
> password
> have reached and the modem has reached to puk state and also the modem
> de-registers from network.
> In this case when i tried to get the properties using "GetProperties",
> the properties from the ofono core are received without querying the
> information
> from the modem. The "PinRequired" received is "none" .
> =

> Could you please provide some info how to get the sim pin state when sim
> is blocked on puk at run-time and is there any way for app to know the
> number of attempts remaining.

This is actually a bug in oFono, somehow we missed the fact that
ChangePin with the wrong PIN will decrease the retry counts.  The core
needs to be fixed to query the current PIN state and reset the state to
pre-sim if the retry limit is reached.

Regards,
-Denis

--===============4713331809745413638==--

