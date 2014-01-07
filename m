Content-Type: multipart/mixed; boundary="===============8840308495219700082=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono issue: Reject SCO: Agent not registered
Date: Tue, 07 Jan 2014 13:09:50 -0600
Message-ID: <52CC50FE.2050703@gmail.com>
In-Reply-To: <CANhWJ4jJ1JYbkosOkY8azspmf9gF=cgVSXZYExXye_CQ9+VP6g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8840308495219700082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ignazio,

 > I'm trying to talk with some oFono developers to understand if my
> previous conclusion is correct or not, but I wasn't very lucky lately.
>

Essentially nothing registers an HandsfreeAudioAgent with oFono.  The =

only known implementation today exists as a plugin / module in PA. =

Patches have been submitted upstream and I believe they have mostly made =

it into the PA tree, but I lost track of the progress sometime in late =

November.

> As far as you know are there a way to solve that problem or if exist an
> anofficial version of PA that provide the support to blueZ5, oFono and
> so for bluetooth HFP?
>

You might try the latest upstream of PulseAudio.  But essentially this =

question should be asked on the PA mailing list.

Regards,
-Denis

--===============8840308495219700082==--

