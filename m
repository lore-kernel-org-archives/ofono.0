Content-Type: multipart/mixed; boundary="===============5116954708668381355=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: VS: SMS status report
Date: Fri, 11 Jun 2010 16:45:05 -0700
Message-ID: <1276299905.21431.38.camel@localhost.localdomain>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A55@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5116954708668381355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-10 at 11:30 +0300, Miettinen Pasi wrote: =

> Hello Inaky
> > Hi Pasi
> |
> >
> > there is a set of patches there which lay out changes in the SMS code
> > infrastructure to do the following:
> > =

> > - export of SMS messages to D-Bus
> > =

> >   - each message is an object in the bus
> > =

> >   - messages can be canceled, properties queried, etc
> =

> If a message that waits for a status report is canceled, status_report_as=
sembly
> data structure must be updated (msg_id and mr-number removed).

so I guess here we'd have to unify whichever infrastructure is there to
keep track of pending guys. The way I had it laid out was an extra queue
in the smsmanager object (sms->tx_wfaq) where those were kept, and then
the msg_id/ref was contained in there. That's going to be kind of like
the same like what you have, I have no personal preference on which one
to use.

> > =

> > - in transit SMS messages get an state machine describing at which phase
> > they are. D-Bus signals are sent in transitions
> =

> This could become topical when we decide how to react to different status
> report results. Currently it is just "delivered"/"undelivered". =


This one Denis and me discussed long and hard, as we wanted to move the
hole SMS interface to be fully asynchronous (you send the message, get
an object name back and then track it by signals reporting status
changes). That whole code is also implemented in the commit set; I am
decently satisfied with how it was working, I think it fits the bill. I
am just thinking of adding a last state (destroyed) so listeners can
tell when a message disappears from oFono's knowledge (it gets delivered
or fails completely or whatever). =

> > =

> > - messages waiting for an status report are queued in a separate queue
> =

> I need to know the the lifespan of these messages that are waiting for st=
atus
> reports. When a message that requests for status report is created, it mu=
st
> be added to the status_report_assembly data structure. And when the
> status report arrives, the data structure must be updated accordingly. I
> have implemented functions for these actions and they are going to be
> in smsutil file.

Ok.

> > =

> > - a unique ID is generated based on message contents and destination
> > nunmber to reduce the chances of collision -- need still to apply it to
> > received messages so it's easier to gather status reports from different
> > fragments
> =

> I think this is one place where we need to keep track of what we are doin=
g,
> because at least for now I am using this msg_id as a key in a hashmap
> which I use to keep track of pending status reports.

Yep, so I built some infrastructure for it to build a hash just piping
data to it -- those commits are kind of independent. I need to clean up
further my commits to fully isolate how it gets inserted into the actual
code, but at the end the idea is that the 16-bit message id gets
generated from this hash instead of having a monotonic increasing one. =


This is for the TX side; for the RX side I still hadn't started thinking
about it and probably you went further than me.

> > - provide an internal C API for managing messages (D-Bus's maps on top
> > of this)
> > =

> > =

> > FIXMEs/TODOs/RFCs:
> > =

> >   still need to cleanup some more to adapt to your code
> =

> You can also suggest to me if you would like me to change something in my
> code. Mainly I have been going under Denis's guidance to get up to speed
> here in my start for the project.

Likewise -- in any case, most of your stuff in the SRR side seems way
more advanced than were I was. Most of my progress was in reorganizing
the SMS & D-BUS code, the status machine and propagation. I had to
wiggle to force things into the changes you had done but that is mostly
done already.

So I guess the only collision part is now how to keep track of the
messages that are pending acknowledgement. Take your pick, after all
your code in that are is more advanced. Just please take a look at the
commits:

SMS-introduce-wait-for-ack-state-and-infrastructure

this is what creates the queue I was planning on using. Other commits do
the msg_id thingie, but I still need to cleanup the commits more so it
looks cleaner -- right now it is spread around a few commits.

[I just repushed a rebase of my smsdbus branch with more cleanups, so
you might want to force pull if you want to look at the commits]

> > =

> >   plenty of whatifs/FIXMEs litered around the code still
> > =

> >   remove the 'request-status-report' from D-Bus::SendMessage
> =

> This is currently done via SetProperty. ofono_sms has use_delivery_reports
> boolean variable.

Yes, this is something I still need to clean up, so feel free to ignore
it.



--===============5116954708668381355==--

