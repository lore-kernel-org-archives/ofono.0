Content-Type: multipart/mixed; boundary="===============2499177567483080642=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Please comment on callhistory API
Date: Tue, 28 Sep 2010 23:08:53 +0900
Message-ID: <1285682933.2657.5.camel@aeonflux>
In-Reply-To: <4CA1291A.3040909@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2499177567483080642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> > this is the second time I have to remind you to not top post. Next time
> > I will ignore your email. Just a friendly reminder to follow proper
> > mailing list etiquette.
> >
> >   =

> >> org.ofono.History will be the main adapter interface and =

> >> org.ofono.CallHistoryAgent the callhistory agent and =

> >> org.ofono.SmsHistoryAgent as the sms history agent. I want to seperate =

> >> the two agents so that sms app will expose sms history agent and diale=
r =

> >> will register and expose callhistory agent. Then it will be clear whic=
h =

> >> agent is interested in which history, vs one org.ofono.HistoryAgent =

> >> exposing ReportCall and ReportTextMessage methods. In the later case =

> >> adapter needs to flush both smshistory and callsistory onto two agents =

> >> even though agents are not interested only in type of history.
> >>     =

> >
> > actually not really. So why does the dialer and SMS application need to
> > register for the history? Isn't that going to be stored central in
> > Tracker or something similar. Should not be Tracker or some Tracker
> > helper be registering the agent?
> >   =

> No, Dialer and Sms applications are the ones that read and stores =

> locally, this will probably move to tracker eventually.
> So I dont think we can assume that there is going to be a tracker agent.
> > I might be wrong, but does it really make sense to separate it on this
> > level?
> >   =

> I am thinking by separating the applications will only register and get =

> data they are interested in.

so Denis and I had a long chat about this. And essentially the history
agent concept is not really something that we should maintain long term.
We need be able to Tracker to listen on the D-Bus system bus and have
oFono history plugin send data directly to Tracker. The history plugin
should track if Tracker is running or not. If not spool. Otherwise send
data to Tracker directly. Everything else is a pretty much complicated
design.

However for a short term solution, you could do a history agent concept
as part of a MeeGo specific plugin.

So use org.ofono as D-Bus service name and com.meego.TelephonyHistory
and com.meego.TelephonyHistoryAgent as interface names.

The main object path is / since are not going to make this based on a
per modem.

Two method calls in the agent a) ReportVoiceCall a) ReportTextMessage
and that is it in. In the info dict include the Modem property which
points to the modem object this information originates from.

Failure of not existing a) or b) should be handled gracefully so that in
the first error case we don't retry anymore.

Regards

Marcel



--===============2499177567483080642==--

