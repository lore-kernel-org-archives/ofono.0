Content-Type: multipart/mixed; boundary="===============6969359566237463855=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Re: Please comment on callhistory API
Date: Thu, 30 Sep 2010 11:41:33 -0700
Message-ID: <4CA4D9DD.4090703@intel.com>
In-Reply-To: <1285682933.2657.5.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6969359566237463855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel,
Marcel Holtmann wrote:
> Hi Raji,
>
>   =

>>> this is the second time I have to remind you to not top post. Next time
>>> I will ignore your email. Just a friendly reminder to follow proper
>>> mailing list etiquette.
>>>
>>>   =

>>>       =

>>>> org.ofono.History will be the main adapter interface and =

>>>> org.ofono.CallHistoryAgent the callhistory agent and =

>>>> org.ofono.SmsHistoryAgent as the sms history agent. I want to seperate =

>>>> the two agents so that sms app will expose sms history agent and diale=
r =

>>>> will register and expose callhistory agent. Then it will be clear whic=
h =

>>>> agent is interested in which history, vs one org.ofono.HistoryAgent =

>>>> exposing ReportCall and ReportTextMessage methods. In the later case =

>>>> adapter needs to flush both smshistory and callsistory onto two agents =

>>>> even though agents are not interested only in type of history.
>>>>     =

>>>>         =

>>> actually not really. So why does the dialer and SMS application need to
>>> register for the history? Isn't that going to be stored central in
>>> Tracker or something similar. Should not be Tracker or some Tracker
>>> helper be registering the agent?
>>>   =

>>>       =

>> No, Dialer and Sms applications are the ones that read and stores =

>> locally, this will probably move to tracker eventually.
>> So I dont think we can assume that there is going to be a tracker agent.
>>     =

>>> I might be wrong, but does it really make sense to separate it on this
>>> level?
>>>   =

>>>       =

>> I am thinking by separating the applications will only register and get =

>> data they are interested in.
>>     =

>
> so Denis and I had a long chat about this. And essentially the history
> agent concept is not really something that we should maintain long term.
> We need be able to Tracker to listen on the D-Bus system bus and have
> oFono history plugin send data directly to Tracker. The history plugin
> should track if Tracker is running or not. If not spool. Otherwise send
> data to Tracker directly. Everything else is a pretty much complicated
> design.
>
> However for a short term solution, you could do a history agent concept
> as part of a MeeGo specific plugin.
>
> So use org.ofono as D-Bus service name and com.meego.TelephonyHistory
> and com.meego.TelephonyHistoryAgent as interface names.
>
> The main object path is / since are not going to make this based on a
> per modem.
>
> Two method calls in the agent a) ReportVoiceCall a) ReportTextMessage
> and that is it in. In the info dict include the Modem property which
> points to the modem object this information originates from.
 For outgoing TextMessages, ofono updates the history plugin in two method =
calls, first all the text message history related properties msg id, messag=
e , local received time,actual sent time, lineid and status=3D'Pending' and=
 in another method ofono updates plugin with the status. Earlier design, I =
sent out history record with pending status and  when I received  status up=
date I  used  'property changed'  signal for status update. But I use 'uint=
32,variant' type which is not consistent with the current ofono property ch=
anged signal type. My questions,
 1) Are you ok with using signal for status update, this lets us send out h=
istory as soon as we receive them if the agent is running      =


 2) If we want to avoid signal, then we can store the outgoing text message=
 record until we receive the status update from ofono, combine them and sen=
d out in case of agent running. In case of agent not running we do this any=
way. =


> Failure of not existing a) or b) should be handled gracefully so that in
> the first error case we don't retry anymore.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>   =



--===============6969359566237463855==--

