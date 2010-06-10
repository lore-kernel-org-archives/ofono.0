Content-Type: multipart/mixed; boundary="===============4297904035045064394=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: SMS status report
Date: Thu, 10 Jun 2010 11:30:20 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A55@jklmail01.ixonos.local>
In-Reply-To: <1276127434.2509.38.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4297904035045064394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Inaky
> Hi Pasi
|
>
> there is a set of patches there which lay out changes in the SMS code
> infrastructure to do the following:
> =

> - export of SMS messages to D-Bus
> =

>   - each message is an object in the bus
> =

>   - messages can be canceled, properties queried, etc

If a message that waits for a status report is canceled, status_report_asse=
mbly
data structure must be updated (msg_id and mr-number removed).

> =

> - in transit SMS messages get an state machine describing at which phase
> they are. D-Bus signals are sent in transitions

This could become topical when we decide how to react to different status
report results. Currently it is just "delivered"/"undelivered". =


> =

> - messages waiting for an status report are queued in a separate queue

I need to know the the lifespan of these messages that are waiting for stat=
us
reports. When a message that requests for status report is created, it must
be added to the status_report_assembly data structure. And when the
status report arrives, the data structure must be updated accordingly. I
have implemented functions for these actions and they are going to be
in smsutil file.

> =

> - a unique ID is generated based on message contents and destination
> nunmber to reduce the chances of collision -- need still to apply it to
> received messages so it's easier to gather status reports from different
> fragments

I think this is one place where we need to keep track of what we are doing,
because at least for now I am using this msg_id as a key in a hashmap
which I use to keep track of pending status reports.

> =

> - provide an internal C API for managing messages (D-Bus's maps on top
> of this)
> =

> =

> FIXMEs/TODOs/RFCs:
> =

>   still need to cleanup some more to adapt to your code

You can also suggest to me if you would like me to change something in my
code. Mainly I have been going under Denis's guidance to get up to speed
here in my start for the project.

> =

>   plenty of whatifs/FIXMEs litered around the code still
> =

>   remove the 'request-status-report' from D-Bus::SendMessage

This is currently done via SetProperty. ofono_sms has use_delivery_reports
boolean variable.

> =

>   message id needs more uniquedness fed into it
> =

|
> Thanks!
Thank you :)
-Pasi



--===============4297904035045064394==--

