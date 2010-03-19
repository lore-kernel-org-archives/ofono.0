Content-Type: multipart/mixed; boundary="===============4535315694984703103=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Re: [Usage] SMS handling
Date: Fri, 19 Mar 2010 16:33:59 +0100
Message-ID: <4BA39967.2030403@djdas.net>
In-Reply-To: <201003190932.03486.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4535315694984703103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
> The current semantics are that the DBusMessage returns only when the SMS =
has =

> been successfully sent to the network, or oFono determined that it cannot=
 send =

> it.  So you can assume that SMS is pending as soon as dbus_message_send i=
s =

> performed by your client.  And that SMS has been sent/failed as soon as t=
he =

> message call returns.
>   =

This means I will have to use a synchronous call and wait for the =

response? I suppose an error response will mean a send failure, is it =

correct?
>   =

>> 2) handling incoming messages when application is (re)starting/crashed:
>> is there a way to retrieve a message if it comes in during a phase where
>> the application is not running or it can't receive the IncomingMessage
>> signal? Does oFono logs or stores the messages somewhere?
>>     =

>
> This is what the history plugin is for.  History is notified when an SMS =
comes =

> in and can persist this information however it wishes.  The plugin can ev=
en =

> define its own D-Bus interface for notifying external clients if needed.
>   =

OK, as per our IRC conversation I'm interested in writing an SQLite =

history plug-in to store calls and SMSes infos, so I'll try to design a =

simple DB and post it here in a few days.
Would it be a problem to have libsqlite as dependency of oFono? Is there =

a way to let it out of the project or however do you consider it a =

useful dependency for other (future) purposes?
Thank you very much in advance, best regards,
Dario.

--===============4535315694984703103==--

