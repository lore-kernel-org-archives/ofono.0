Content-Type: multipart/mixed; boundary="===============8172151072939549695=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Update on "Source/Destination port addressing scheme from 3GPP
 23.040" TODO task?
Date: Sat, 04 Sep 2010 16:45:05 +0300
Message-ID: <AANLkTimnq1dXVZdMataWnPA2v4j8Vp5S0SGT1qFDGcP4@mail.gmail.com>
In-Reply-To: <58BD0469C48A7443A479A13D101685E305042BF2@ala-mail09.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8172151072939549695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chris,

2010/9/4 Schoppa, Chris <Chris.Schoppa@windriver.com>:
> As we start to flesh out thinking on how to handle SMS notifications, and
> WAP Push =C3=A0 MMS message notification in particular, the need for the =
proposed
> SMS message routing to handlers based on Destination Port becomes more
> urgent.
>
> Is there any current activity happening on this task from the TODO list?

I sent out an API proposal a few days ago, and based on the
discussion, I'm currently revising it. In short, the idea is to extend
the current MessageManager with an agent registration API, allowing
agents to register to receiving SMSs, including application messages
such as WAP push.

Cheers,
Aki

--===============8172151072939549695==--

