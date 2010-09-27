Content-Type: multipart/mixed; boundary="===============8039302209896197700=="
MIME-Version: 1.0
From: rajyalakshmi bommaraju <rajyalakshmi.bommaraju@intel.com>
Subject: Re: Please comment on callhistory API
Date: Mon, 27 Sep 2010 16:30:34 -0700
Message-ID: <4CA1291A.3040909@intel.com>
In-Reply-To: <1285626082.9845.16.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8039302209896197700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,
Marcel Holtmann wrote:
> Hi Raji,
>
> this is the second time I have to remind you to not top post. Next time
> I will ignore your email. Just a friendly reminder to follow proper
> mailing list etiquette.
>
>   =

>> org.ofono.History will be the main adapter interface and =

>> org.ofono.CallHistoryAgent the callhistory agent and =

>> org.ofono.SmsHistoryAgent as the sms history agent. I want to seperate =

>> the two agents so that sms app will expose sms history agent and dialer =

>> will register and expose callhistory agent. Then it will be clear which =

>> agent is interested in which history, vs one org.ofono.HistoryAgent =

>> exposing ReportCall and ReportTextMessage methods. In the later case =

>> adapter needs to flush both smshistory and callsistory onto two agents =

>> even though agents are not interested only in type of history.
>>     =

>
> actually not really. So why does the dialer and SMS application need to
> register for the history? Isn't that going to be stored central in
> Tracker or something similar. Should not be Tracker or some Tracker
> helper be registering the agent?
>   =

No, Dialer and Sms applications are the ones that read and stores =

locally, this will probably move to tracker eventually.
So I dont think we can assume that there is going to be a tracker agent.
> I might be wrong, but does it really make sense to separate it on this
> level?
>   =

I am thinking by separating the applications will only register and get =

data they are interested in.
> And it needs to be MessageHistoryAgent if we decide to go for this. We
> banned the shortcut "sms" from the rest of the API.
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



--===============8039302209896197700==--

