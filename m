Content-Type: multipart/mixed; boundary="===============0881461342020298136=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [Usage] SMS handling
Date: Fri, 19 Mar 2010 09:32:02 -0500
Message-ID: <201003190932.03486.denkenz@gmail.com>
In-Reply-To: <4BA38325.80204@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0881461342020298136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> Hi all,
> I have a question: what is the best practice (or the suggested
> behaviour) to handle SMSes in an application using oFono?
> I am thinking about two common cases:
> 1) handling outgoing message status: I use the SendMessage DBus API but
> AFAIK I'm not aware of the status of the sending operation (pending,
> blocked, sent...) in the DBus response;

The current semantics are that the DBusMessage returns only when the SMS ha=
s =

been successfully sent to the network, or oFono determined that it cannot s=
end =

it.  So you can assume that SMS is pending as soon as dbus_message_send is =

performed by your client.  And that SMS has been sent/failed as soon as the =

message call returns.

The history plugin is given a bit more information.  It is notified when th=
e =

SMS is queued, successfully sent / not.

> 2) handling incoming messages when application is (re)starting/crashed:
> is there a way to retrieve a message if it comes in during a phase where
> the application is not running or it can't receive the IncomingMessage
> signal? Does oFono logs or stores the messages somewhere?

This is what the history plugin is for.  History is notified when an SMS co=
mes =

in and can persist this information however it wishes.  The plugin can even =

define its own D-Bus interface for notifying external clients if needed.

> =

> I think I found something in the "Example Call History" plugin, does
> this mean I need to create an oFono plugin to manage my application
> needs or am I missing some info/API somewhere?

You don't have to use history plugin, but it can make certain tasks really =

easy.

> =

> Thank you in advance, best regards,
> Dario.

Regards,
-Denis

--===============0881461342020298136==--

