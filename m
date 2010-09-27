Content-Type: multipart/mixed; boundary="===============6216613726321932076=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Please comment on callhistory API
Date: Tue, 28 Sep 2010 07:21:22 +0900
Message-ID: <1285626082.9845.16.camel@aeonflux>
In-Reply-To: <4CA100DF.40402@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6216613726321932076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

this is the second time I have to remind you to not top post. Next time
I will ignore your email. Just a friendly reminder to follow proper
mailing list etiquette.

> org.ofono.History will be the main adapter interface and =

> org.ofono.CallHistoryAgent the callhistory agent and =

> org.ofono.SmsHistoryAgent as the sms history agent. I want to seperate =

> the two agents so that sms app will expose sms history agent and dialer =

> will register and expose callhistory agent. Then it will be clear which =

> agent is interested in which history, vs one org.ofono.HistoryAgent =

> exposing ReportCall and ReportTextMessage methods. In the later case =

> adapter needs to flush both smshistory and callsistory onto two agents =

> even though agents are not interested only in type of history.

actually not really. So why does the dialer and SMS application need to
register for the history? Isn't that going to be stored central in
Tracker or something similar. Should not be Tracker or some Tracker
helper be registering the agent?

I might be wrong, but does it really make sense to separate it on this
level?

And it needs to be MessageHistoryAgent if we decide to go for this. We
banned the shortcut "sms" from the rest of the API.

Regards

Marcel



--===============6216613726321932076==--

