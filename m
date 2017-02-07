Content-Type: multipart/mixed; boundary="===============6395232474040368228=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: telit modem NW DETACH
Date: Tue, 07 Feb 2017 11:22:55 -0600
Message-ID: <9252452d-2ee5-5450-3b72-fa918291381c@gmail.com>
In-Reply-To: <1486468142.20825.22.camel@andred.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6395232474040368228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On 02/07/2017 05:49 AM, Andr=C3=A9 Draszik wrote:
> Hi,
>
> I am looking for advise for how to implement the TODO item in
> ofono_gprs_detached_notify() in src/gprs.c
>
> Using my Telit UE910-EU modem, the modem always reports a network initiat=
ed
> detach after closing the data connection (by disconnecting the service via
> connman), and oFono ends up ofono_gprs_detached_notify(). It is my
> understanding that this is unusual behaviour, and that other people are
> seeing the same, e.g.
> https://lists.01.org/pipermail/ofono/2015-May/015765.html
>

Generally the network shouldn't just detach you if you deactivated a =

context, so my first guess would be that the modem firmware is doing =

something silly.  Do you have another modem to test by any chance?


> I can get around that by disabling/re-enabling the modem, but I would like
> to avoid that...
>
> As a further point, whenever the modem reports that it has been disconnec=
ted
> but then the CellID changes, it magically reconnects, so I believe I shou=
ld

Even more evidence that seems to indicate a firmware issue.  But who knows.

> be looking to set oFono's state machine back to trying to reconnect and
> eventually issue the correct AT command to do so forcefully. See 2nd part=
 of
> the log below.
>

You can try the simplistic approach of trying to re-attach whenever we =

have been detached.  Though ideally we'd need some form of detach reason =

enumeration to be added in the API (obtained via +CEER or similar) so =

that the gprs atom can try and make an informed guess whether the attach =

is likely to succeed.

 From 27.007, Section 6.10 Extended error report +CEER:
Execution command causes the TA to return one or more lines of =

information text <report>, determined by the MT manufacturer, which =

should offer the user of the TA an extended report of the reason for
-	the failure in the last unsuccessful call setup (originating or =

answering) or in=E2=80=91call modification;
-	the last call release;
-	the last unsuccessful GPRS attach or unsuccessful PDP context activation;
-	the last GPRS detach or PDP context deactivation.
Typically, the text will consist of a single line containing the cause =

information given by GSM/UMTS network in textual format.

Regards,
-Denis

--===============6395232474040368228==--

