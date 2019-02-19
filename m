Content-Type: multipart/mixed; boundary="===============6623165358321582696=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Test clients for ofono: rfone, Unicsy Demo
Date: Tue, 19 Feb 2019 12:41:50 +0100
Message-ID: <20190219114150.GA845@amd>
In-Reply-To: <5c1f3935-3b97-745c-93ab-66dfb3583f8f@wizzup.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6623165358321582696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > What ofono client are you using for development.. and for real usage
> > on a cellphone?
> > =

> > There are scripts in test/ which are suitable for early development,
> > but not really for real use or 'does everything work?' testing.
> > =

> > Anyway, I created some.
> > =

> > RFone -- https://gitlab.com/tui/tui/tree/master/rfone -- command line
> > tool written in Rust, by default monitors interesting events
> > (incomming call, sms, signal changes, registration changes), and has
> > command-line options for making/answering calls and sending sms. I'm
> > starting gtk support.
> =

> This looks like fun!

Yes, it is fun :-). But I'm a bit busy.

> > Is there any other software I should look at?
> =

> I am also wondering about this. For Maemo Leste we also want a gtk or qt
> (likely gtk2 for now) ofono phone UI, and I was also not able to find
> much. Would like it to be written in C, C++ or Rust though (not Python
> for performance and ram/memory usage concerns).
> =

> If we can agree on some general architectural/UI direction and goals I
> could try to help out. (In the end I probably want something that
> monitors ofono but is not shown all the time, as on Maemo Fremantle)

I agree that Python needs too much RAM; I tried with Vala, but I
believe Rust is really a better solution.

And yes, the long running stuff (ph monitor) should probably not
display window all the time, but work with the system tray to show the
signal. But I did not do too much investigation into that.

My design goals are described below. Help would be certainly welcome.

Best regards,
								Pavel

# Goals

One day, this should turn into "Unicsy Phone", phone support that
integrates well with the rest of the Unix system. Phone functionality
should be available both from command-line and from simple
GUI. Important data should be stored in plain-text formats that are
easy to access with common software.

SMS messages should be handled in similar way e-mails currently are --
stored in maildir or mailbox formats, and accessible by common email
clients. Access by two or more clients at the same time should be
possible. Of course, special GUI client should be provided to work
with SMS (using same maildir backend).

Simple text format should be supported for contacts -- probably as
simple as number '\t' name. Many users will want something a bit more
advanced, I'd prefer hierarchical structure offered by emacs "org"
mode, allowing me to group contacts together. We should call external
program to list contacts for us, allowing easy merging of contacts
from multiple sources. "ph book" should provide the merged list.

# Design

Non-GUI component should be responsible for maintaining call log and
incoming SMSes. History plugin in ofono can probably do this. Ideally,
GSM should go offline when this component fails, so that SMSes are
queued by the network.

There should be "ph primary" component responsible for calls and
incoming SMSes -- mostly for actions not initiated by local user. On
incoming events, it should play a melody. For calls, it should set up
mixers, and display a window allowing user to manipulate volume,
answer, reject and terminate the call. For incoming message,
notification window should be displayed.

"ph monitor" should be usable for monitoring phone status from the
command line, displaying current network and signal status, any
incoming calls and messages.

There should be a GUI component for doing actions for local user. It
should allow basic control (online/airplane mode, starting data
connection), allow placing phone calls (but audio will be controlled
and call window will still be displayed by "ph primary"), and sending
SMS messages.

								Pavel



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6623165358321582696==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseHI2MzRBQ2drUU1PZndhcFhiK3ZKaXJRQ2dtU3g2L0pubFM4MHRRTkRKOUZvaHF6enMK
OGFVQW9KcENSK0ZuckpUZkszVFd4eDg4ams2enIxT2MKPU9haVoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6623165358321582696==--

