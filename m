Content-Type: multipart/mixed; boundary="===============3242145837819172708=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Tue, 01 Feb 2011 15:01:31 +0200
Message-ID: <1296565291.1719.58.camel@miia-desktop>
In-Reply-To: <1296488678.1520.226.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3242145837819172708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Marcel,

Seems that you are not going to go with me on this. I do understand your
point that this is very marginal feature, me myself I only use it couple
times a year (which also answers to your question) and I might be in a
rare group. But I do appreciate the feature when I need it.

> I am not following here. What is an option good for if it does not give
> anything to the user. In fact it could potentially be actually lying to
> the user since we have no control whatsoever.
What I meant was that if the network does not support the setting, then
it could be hidden from the UI. Then there would not be scenario that
user has option that does nothing. I understand from the specification
(23.040) that this should be possible to know:

"The SC shall reject any Unsupported/ Reserved values received by
returning the =E2=80=98TP-VP not supported=E2=80=99 TP-FCS value in the Sub=
mit SM Report
for RP-Error."

But when it comes to this SMS Validity Period being supported in oFono,
I guess we are done. I asked for it and gave my arguments but you said
no. I don't find I am able to do more to this for now at least.

BR,
Miia
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



--===============3242145837819172708==--

