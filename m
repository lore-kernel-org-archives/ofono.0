Content-Type: multipart/mixed; boundary="===============5188118837007296569=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Please comment on callhistory API
Date: Fri, 01 Oct 2010 09:33:37 +0200
Message-ID: <1285918417.4231.7.camel@aeonflux>
In-Reply-To: <4CA4D9DD.4090703@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5188118837007296569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> >>>> org.ofono.History will be the main adapter interface and =

> >>>> org.ofono.CallHistoryAgent the callhistory agent and =

> >>>> org.ofono.SmsHistoryAgent as the sms history agent. I want to sepera=
te =

> >>>> the two agents so that sms app will expose sms history agent and dia=
ler =

> >>>> will register and expose callhistory agent. Then it will be clear wh=
ich =

> >>>> agent is interested in which history, vs one org.ofono.HistoryAgent =

> >>>> exposing ReportCall and ReportTextMessage methods. In the later case =

> >>>> adapter needs to flush both smshistory and callsistory onto two agen=
ts =

> >>>> even though agents are not interested only in type of history.
> >>>>     =

> >>>>         =

> >>> actually not really. So why does the dialer and SMS application need =
to
> >>> register for the history? Isn't that going to be stored central in
> >>> Tracker or something similar. Should not be Tracker or some Tracker
> >>> helper be registering the agent?
> >>>   =

> >>>       =

> >> No, Dialer and Sms applications are the ones that read and stores =

> >> locally, this will probably move to tracker eventually.
> >> So I dont think we can assume that there is going to be a tracker agen=
t.
> >>     =

> >>> I might be wrong, but does it really make sense to separate it on this
> >>> level?
> >>>   =

> >>>       =

> >> I am thinking by separating the applications will only register and ge=
t =

> >> data they are interested in.
> >>     =

> >
> > so Denis and I had a long chat about this. And essentially the history
> > agent concept is not really something that we should maintain long term.
> > We need be able to Tracker to listen on the D-Bus system bus and have
> > oFono history plugin send data directly to Tracker. The history plugin
> > should track if Tracker is running or not. If not spool. Otherwise send
> > data to Tracker directly. Everything else is a pretty much complicated
> > design.
> >
> > However for a short term solution, you could do a history agent concept
> > as part of a MeeGo specific plugin.
> >
> > So use org.ofono as D-Bus service name and com.meego.TelephonyHistory
> > and com.meego.TelephonyHistoryAgent as interface names.
> >
> > The main object path is / since are not going to make this based on a
> > per modem.
> >
> > Two method calls in the agent a) ReportVoiceCall a) ReportTextMessage
> > and that is it in. In the info dict include the Modem property which
> > points to the modem object this information originates from.
>  For outgoing TextMessages, ofono updates the history plugin in two metho=
d calls, first all the text message history related properties msg id, mess=
age , local received time,actual sent time, lineid and status=3D'Pending' a=
nd in another method ofono updates plugin with the status. Earlier design, =
I sent out history record with pending status and  when I received  status =
update I  used  'property changed'  signal for status update. But I use 'ui=
nt32,variant' type which is not consistent with the current ofono property =
changed signal type. My questions,
>  1) Are you ok with using signal for status update, this lets us send out=
 history as soon as we receive them if the agent is running      =

> =

>  2) If we want to avoid signal, then we can store the outgoing text messa=
ge record until we receive the status update from ofono, combine them and s=
end out in case of agent running. In case of agent not running we do this a=
nyway. =


you can just send the method call (it is not a signal in this case) both
times. When you get the pending one and once the final one. The SMS
contains its own SHA-1 based id. So the history application can easily
update its database. It can be used as primary key. oFono ensures its
uniqueness as good as SHA-1 hash can do.

Regards

Marcel



--===============5188118837007296569==--

