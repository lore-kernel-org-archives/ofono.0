Content-Type: multipart/mixed; boundary="===============5508362974229960223=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/8] gprs: data bearer for telit with PSNT
Date: Tue, 14 Aug 2012 01:53:06 -0500
Message-ID: <5029F5D2.5060304@gmail.com>
In-Reply-To: <502A7133.1010307@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5508362974229960223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

>> Do you really need to query this? In theory if we are turning off
>> auto-attach, we should never be in a state where the bearer should be
>> queried.
> Once '#PSNT=3D1' is sent, the modem emits #PSNT URCs even just after
> enabling the modem (e.g. after changing the SIM or setting the modem
> online again).

By the way, the gprs atom is meant to be put into the post_sim phase now.

> So if the value does not change incidentally in gprs phase, the modem
> will not send an URC. That's why I added the query. Is this ok in this
> case?

I still don't see how it can not change.  If you go offline you should =

be detached and only attaching once the gprs atom tells you to.  I =

presume the PSNT will change during / after the attach procedure =

completes, not before.  That means just the URC is enough.  Same with =

sim change, etc.

Lets get a version of this patch upstream without the query.  If you can =

show that we still need to query then I have no problems pushing that =

afterwards as well.

Regards,
-Denis

--===============5508362974229960223==--

