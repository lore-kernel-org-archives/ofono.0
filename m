Content-Type: multipart/mixed; boundary="===============6936544741928198698=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SMS doubt
Date: Thu, 15 Jan 2015 10:00:35 -0600
Message-ID: <54B7E423.1040703@gmail.com>
In-Reply-To: <CAH4ZQwvKJZTbANZ7i-AhaSy8fJM2Z01c0koVgvQM3Ej4sgJPag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6936544741928198698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 01/15/2015 03:55 AM, Enrico Sau wrote:
> Hi all,
> I was wondering how should ofono behave on a SMS reception.
> Should the message be saved somewhere by ofono, or another application
> in needed for that?

oFono does not save anything.  One can write a history plugin to write =

this information to a database of your choice, or export this =

information via DBus/other IPC in some way.  See examples/history.c for =

a very basic example.  Search the mailing list archives for more complex =

examples of this.

Alternatively, you can write a simple application that listens to the =

MessageManager.ImmediateMessage and MessageManager.IncomingMessage =

signals to store messages.  However, this is not quite as reliable as =

the history plugin approach since if your application is not running / =

crashes, messages that are received during that time would be lost.

> I'm asking because after some SMS receptions, the script list-messages
> does not show anything.
>

The Message objects exposed by GetMessages() method, MessageAdded() and =

MessageRemoved() signals are for the outgoing path only.  If you notice, =

the states are:

"
Properties      string State

                         Contains the state of the message object.  Possible
                         values are:
                                 "pending",
                                 "sent",
                                 "failed"
"

Hope this helps.

Regards,
-Denis

--===============6936544741928198698==--

