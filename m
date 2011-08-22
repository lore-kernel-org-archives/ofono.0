Content-Type: multipart/mixed; boundary="===============6115490625635355463=="
MIME-Version: 1.0
From: Dalleau, Frederic <frederic.dalleau@intel.com>
Subject: Re: [Clarification Request]HFP Modem:Notification of Multiparty Call
 Created Using AG
Date: Mon, 22 Aug 2011 10:31:46 +0200
Message-ID: <CA+QXtDtSLswPbGcWi3a1arwbuiVnwde-6xhs6w1C0RcAUFNEzg@mail.gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836215186E43FF@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6115490625635355463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

> Is there a specific reason to limit the availability of multiparty call
> support initiated through Ofono only?

There is no such limitation. The status of multiparty call is sent to
an handsfree in +CLCC message response. If it is not the case, it
could be a bug either in oFono or in the handsfree.  Can you
provide more details about your setup and ideally an hcidump log?
I'd also recommend you to use a newer version of oFono since
multiparty call management (+CHLD) is not complete in 0.48.

Regards,
Fr=C3=A9d=C3=A9ric

--===============6115490625635355463==--

